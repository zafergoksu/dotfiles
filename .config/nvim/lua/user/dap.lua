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

-- Pick up .vscode/launch.json configurations when present.
pcall(function()
    require('dap.ext.vscode').load_launchjs(nil, { codelldb = { 'c', 'cpp', 'rust' } })
end)

-- Open/close the DAP UI automatically with a debug session.
dap.listeners.before.attach.dapui_config = function() dapui.open() end
dap.listeners.before.launch.dapui_config = function() dapui.open() end
dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

-- Signs
vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DiagnosticError', numhl = '' })
vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = 'DiagnosticWarn', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '', texthl = 'DiagnosticWarn', linehl = 'Visual' })

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
