-- NOTE: this config tracks nvim-treesitter's `main` branch, which behaves very
-- differently from the old `master` branch:
--   * there is no `require('nvim-treesitter.configs').setup`,
--   * parsers are installed explicitly (asynchronously),
--   * highlighting/indentation are NOT enabled automatically - we start them
--     per buffer in a FileType autocmd.
local ok, ts = pcall(require, 'nvim-treesitter')
if not ok then
    return
end

pcall(ts.setup, {})

-- Install every available parser (user opted for "all").
local parsers
local ok_avail, available = pcall(function()
    return ts.get_available()
end)
if ok_avail and type(available) == 'table' and #available > 0 then
    parsers = available
else
    -- Fallback list if the `get_available` API isn't present.
    parsers = {
        'lua', 'c', 'cpp', 'cmake', 'rust', 'go', 'python', 'bash',
        'markdown', 'markdown_inline', 'json', 'yaml', 'toml', 'vim',
        'vimdoc', 'typst', 'html', 'css', 'javascript', 'typescript',
        'svelte', 'gitcommit', 'diff', 'query',
    }
end
-- The `main` branch compiles parsers from source via the tree-sitter CLI.
-- Without it, installs fail noisily and there's no point trying.
if vim.fn.executable('tree-sitter') == 1 then
    -- Install the essentials synchronously first so core languages highlight
    -- immediately on a fresh setup where parsers are still downloading. Then
    -- fetch the rest async.
    local core = { 'c', 'cpp', 'lua', 'vim', 'vimdoc', 'query', 'markdown', 'markdown_inline' }
    pcall(function()
        local handle = ts.install(core)
        if handle and handle.wait then
            handle:wait(300000)
        end
    end)
    pcall(ts.install, parsers)
else
    vim.schedule(function()
        vim.notify(
            'tree-sitter CLI not found: parsers cannot be built (treesitter is on the `main` branch).\n'
                .. 'Install it, e.g. `pacman -S tree-sitter-cli` or `:MasonInstall tree-sitter-cli`, then run require("nvim-treesitter").install(...).',
            vim.log.levels.WARN
        )
    end)
end

local has_indentexpr = type(ts.indentexpr) == 'function'

-- Start treesitter highlighting + indentation for buffers whose language has a
-- parser available. Guarded so a not-yet-installed parser can't break startup.
vim.api.nvim_create_autocmd('FileType', {
    callback = function(ev)
        local lang = vim.treesitter.language.get_lang(ev.match)
        if not lang then
            return
        end
        if not pcall(vim.treesitter.language.add, lang) then
            return
        end
        pcall(vim.treesitter.start, ev.buf, lang)
        if has_indentexpr then
            vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
    end,
})
