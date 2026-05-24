local dap = require('dap')
local dapui = require('dapui')

dapui.setup()
require('nvim-dap-virtual-text').setup({})

-- Auto-install + auto-configure the codelldb adapter (C/C++/Rust default configs).
require('mason-nvim-dap').setup({
    ensure_installed = { 'codelldb' },
    automatic_installation = true,
    handlers = {},
})

-- Map codelldb launch.json entries to C/C++/Rust filetypes. nvim-dap now reads
-- .vscode/launch.json automatically on demand
require('dap.ext.vscode').type_to_filetypes.codelldb = { 'c', 'cpp', 'rust' }

-- ── cmake-aware launch ─────────────────────────────────────────────────────
-- Deduce the executable from cmake-tools so <F5> never asks for a path.
-- nvim-dap's async config contract (see eval_option in dap.lua): a config field
-- may be a function that returns a *suspended coroutine*; dap resumes it with its
-- session coroutine, and we hand back the value via coroutine.resume(dap_co, v).
local function cmake_program()
    return coroutine.create(function(dap_co)
        local function finish(value)
            coroutine.resume(dap_co, value == nil and dap.ABORT or value)
        end

        local ok, ct = pcall(require, 'cmake-tools')
        if not ok then
            vim.notify('cmake-tools not available', vim.log.levels.ERROR)
            return finish(nil)
        end

        -- 1. Reuse an already-selected launch target — no prompt on repeat <F5>.
        --    (cmake-tools stores the target name and re-resolves the path against
        --    the active build dir, so Debug/Release switches are handled.)
        local sel = ct.get_launch_target_path()
        if type(sel) == 'string' and sel ~= '' then
            return finish(sel)
        end

        -- 2. Enumerate executable targets from the CMake codemodel
        --    (auto-configures the project first if it hasn't been generated).
        ct.get_cmake_launch_targets(function(res)
            local data = (res and res.data) or {}
            local paths = data.abs_paths or {}
            if #paths == 0 then
                vim.notify('No CMake executable targets found', vim.log.levels.WARN)
                return finish(nil)
            elseif #paths == 1 then
                return finish(tostring(paths[1]))
            end
            -- 3. Multiple targets: let cmake-tools pick (telescope via ui-select)
            --    and remember the choice for subsequent <F5> / <leader>md runs.
            ct.select_launch_target(true, function()
                local p = ct.get_launch_target_path()
                finish(type(p) == 'string' and p ~= '' and p or nil)
            end)
        end)
    end)
end

-- Replace mason-nvim-dap's "prompt for executable path" defaults so <F5> goes
-- straight into the cmake-resolved target (no config menu, no path typing).
for _, ft in ipairs({ 'cpp', 'c', 'rust' }) do
    dap.configurations[ft] = {
        {
            name = 'Launch (cmake target)',
            type = 'codelldb',
            request = 'launch',
            cwd = '${workspaceFolder}',
            stopOnEntry = false,
            args = {},
            program = cmake_program,
        },
    }
end

-- Open/close the DAP UI automatically with a debug session.
dap.listeners.before.attach.dapui_config = function() dapui.open() end
dap.listeners.before.launch.dapui_config = function() dapui.open() end
dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

-- Signs
-- NOTE: sign `text` MUST be non-empty. A sign with empty text has nothing to
-- display, so Neovim places it (sign_place returns an id) but does not retain it
-- in sign_getplaced(). nvim-dap reconstructs breakpoints from placed signs, so
-- empty text makes toggled breakpoints silently vanish.
vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'DiagnosticError', numhl = '' })
vim.fn.sign_define('DapBreakpointCondition', { text = '◆', texthl = 'DiagnosticWarn', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '▶', texthl = 'DiagnosticWarn', linehl = 'Visual' })

local map = vim.keymap.set
map('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Toggle breakpoint' })
map('n', '<leader>dB', function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, { desc = 'Conditional breakpoint' })
map('n', '<leader>dc', dap.continue, { desc = 'Continue' })
map('n', '<leader>di', dap.step_into, { desc = 'Step into' })
map('n', '<leader>do', dap.step_over, { desc = 'Step over' })
map('n', '<leader>dO', dap.step_out, { desc = 'Step out' })
map('n', '<leader>dr', dap.repl.toggle, { desc = 'Toggle REPL' })
map('n', '<leader>dl', dap.run_last, { desc = 'Run last' })
map('n', '<leader>dt', dap.terminate, { desc = 'Terminate' })
map('n', '<leader>du', dapui.toggle, { desc = 'Toggle DAP UI' })
map('n', '<leader>de', function() dapui.eval() end, { desc = 'Eval expression' })

-- Function keys
map('n', '<F5>', dap.continue, { desc = 'Debug: continue' })
map('n', '<F9>', dap.toggle_breakpoint, { desc = 'Debug: toggle breakpoint' })
map('n', '<F10>', dap.step_over, { desc = 'Debug: step over' })
map('n', '<F11>', dap.step_into, { desc = 'Debug: step into' })
map('n', '<F12>', dap.step_out, { desc = 'Debug: step out' })
