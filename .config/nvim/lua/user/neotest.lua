local neotest = require('neotest')

-- neotest-gtest builds a `cpp` treesitter query when it loads; guard it so a
-- not-yet-installed parser can't break neotest (or startup) entirely.
local adapters = {}
local ok_gtest, gtest = pcall(require, 'neotest-gtest')
if ok_gtest then
    table.insert(adapters, gtest.setup({}))
else
    vim.notify('neotest-gtest unavailable (is the cpp treesitter parser installed?)', vim.log.levels.WARN)
end

neotest.setup({
    adapters = adapters,
})

local map = vim.keymap.set

map('n', '<leader>Tr', function() neotest.run.run() end, { desc = 'Run nearest test' })
map('n', '<leader>Tf', function() neotest.run.run(vim.fn.expand('%')) end, { desc = 'Run file' })
map('n', '<leader>Ta', function() neotest.run.run(vim.uv.cwd()) end, { desc = 'Run all tests' })
map('n', '<leader>Td', function() neotest.run.run({ strategy = 'dap' }) end, { desc = 'Debug nearest test' })
map('n', '<leader>Ts', function() neotest.summary.toggle() end, { desc = 'Toggle summary' })
map('n', '<leader>To', function() neotest.output.open({ enter = true }) end, { desc = 'Show output' })
map('n', '<leader>TO', function() neotest.output_panel.toggle() end, { desc = 'Toggle output panel' })
map('n', '<leader>TS', function() neotest.run.stop() end, { desc = 'Stop' })
map('n', '<leader>Tw', function() neotest.watch.toggle(vim.fn.expand('%')) end, { desc = 'Toggle watch' })
