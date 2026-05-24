local harpoon = require('harpoon')
harpoon:setup({})

local map = vim.keymap.set

map('n', '<leader>ha', function() harpoon:list():add() end, { desc = 'Harpoon add file' })
map('n', '<leader>hh', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = 'Harpoon menu' })
map('n', '<leader>hn', function() harpoon:list():next() end, { desc = 'Harpoon next' })
map('n', '<leader>hp', function() harpoon:list():prev() end, { desc = 'Harpoon prev' })

-- Jump straight to slots 1-4.
for i = 1, 4 do
    map('n', '<leader>' .. i, function() harpoon:list():select(i) end, { desc = 'Harpoon to file ' .. i })
end
