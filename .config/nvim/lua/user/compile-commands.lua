-- Resolves the clangd compile_commands.json directory and feeds it to clangd via
-- --compile-commands-dir, restarting clangd when it changes. Resolution priority:
--   1. per-project manual override (:ClangdBuildDir, persisted in stdpath('state'))
--   2. cmake-tools' active build directory
--   3. auto-detected common build dirs
local M = {}

local state_file = vim.fn.stdpath('state') .. '/clangd_build_dirs.json'
local applied = {} -- project_root -> last applied dir (prevents restart loops)

local function project_root()
    local ok, ct = pcall(require, 'cmake-tools')
    if ok and ct.is_cmake_project and ct.is_cmake_project() and ct.get_cwd then
        local cwd = ct.get_cwd()
        if cwd and cwd ~= '' then return cwd end
    end
    local found = vim.fs.root(0, { '.git', 'CMakeLists.txt', 'compile_commands.json' })
    return found or vim.fn.getcwd()
end

local function has_cc(dir)
    return dir and dir ~= '' and vim.fn.filereadable(dir .. '/compile_commands.json') == 1
end

local function load_overrides()
    if vim.fn.filereadable(state_file) ~= 1 then return {} end
    local ok, data = pcall(function()
        return vim.json.decode(table.concat(vim.fn.readfile(state_file), '\n'))
    end)
    return (ok and type(data) == 'table') and data or {}
end

local function save_override(root, dir)
    local data = load_overrides()
    data[root] = dir
    vim.fn.writefile({ vim.json.encode(data) }, state_file)
end

local function clear_override(root)
    local data = load_overrides()
    data[root] = nil
    vim.fn.writefile({ vim.json.encode(data) }, state_file)
end

local function detect(root)
    local candidates = { 'build', 'out', 'cmake-build-debug', 'cmake-build-release' }
    -- cmake-build-*/  and  build/<Config>/
    for _, g in ipairs(vim.fn.glob(root .. '/cmake-build-*', false, true)) do
        table.insert(candidates, vim.fn.fnamemodify(g, ':t'))
    end
    for _, g in ipairs(vim.fn.glob(root .. '/build/*', false, true)) do
        if vim.fn.isdirectory(g) == 1 then
            table.insert(candidates, 'build/' .. vim.fn.fnamemodify(g, ':t'))
        end
    end
    local found = {}
    for _, c in ipairs(candidates) do
        local dir = root .. '/' .. c
        if has_cc(dir) then table.insert(found, dir) end
    end
    return found
end

-- Returns the resolved absolute build dir (or nil).
local function resolve(root)
    local override = load_overrides()[root]
    if has_cc(override) then return override end

    local ok, ct = pcall(require, 'cmake-tools')
    if ok and ct.get_build_directory then
        local okd, dir = pcall(ct.get_build_directory)
        if okd and has_cc(dir) then return dir end
    end

    local found = detect(root)
    return found[1]
end

-- Sets clangd's --compile-commands-dir and restarts clangd if the dir changed.
function M.apply()
    local root = project_root()
    local dir = resolve(root)
    if applied[root] == dir then return end
    applied[root] = dir

    local base = (vim.lsp.config.clangd and vim.lsp.config.clangd.cmd) or { 'clangd' }
    local cmd = {}
    for _, a in ipairs(base) do
        if not tostring(a):match('^%-%-compile%-commands%-dir=') then
            table.insert(cmd, a)
        end
    end
    if dir then table.insert(cmd, '--compile-commands-dir=' .. dir) end
    vim.lsp.config('clangd', { cmd = cmd })

    local restarted = false
    for _, c in ipairs(vim.lsp.get_clients({ name = 'clangd' })) do
        c:stop(true)
        restarted = true
    end
    if restarted then
        vim.defer_fn(function() pcall(vim.cmd, 'silent! edit') end, 200)
    end
end

function M.pick()
    local root = project_root()
    local choices = detect(root)
    table.insert(choices, 'Enter path manually…')
    table.insert(choices, 'Clear override')
    vim.ui.select(choices, { prompt = 'clangd build dir for ' .. root }, function(choice)
        if not choice then return end
        if choice == 'Clear override' then
            clear_override(root)
        elseif choice == 'Enter path manually…' then
            local p = vim.fn.input('Build dir: ', root .. '/', 'dir')
            if p == '' then return end
            save_override(root, (vim.fn.fnamemodify(p, ':p'):gsub('/$', '')))
        else
            save_override(root, choice)
        end
        applied[root] = nil
        M.apply()
        vim.notify('clangd build dir updated for ' .. root, vim.log.levels.INFO)
    end)
end

vim.api.nvim_create_user_command('ClangdBuildDir', M.pick, { desc = 'Pick clangd build directory' })
vim.api.nvim_create_user_command('ClangdBuildDirClear', function()
    local root = project_root()
    clear_override(root)
    applied[root] = nil
    M.apply()
end, { desc = 'Clear clangd build-dir override for this project' })

vim.keymap.set('n', '<leader>mD', M.pick, { desc = 'Pick clangd build dir' })

-- Re-resolve on cwd change and when cmake-tools changes the build directory.
vim.api.nvim_create_autocmd('DirChanged', { callback = function() M.apply() end })
vim.api.nvim_create_autocmd('User', {
    pattern = { 'CMakeToolsSelectBuildType', 'CMakeToolsSelectBuildPreset',
        'CMakeToolsSelectConfigurePreset', 'CMakeToolsSelectBuildTarget' },
    callback = function()
        applied[project_root()] = nil
        M.apply()
    end,
})

-- Resolve once at startup so clangd's first attach already has the right flag.
M.apply()

return M
