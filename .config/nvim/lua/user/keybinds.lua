local map = vim.keymap.set

-- Files / quit
map('n', '<leader>s', '<cmd>update<cr>', { desc = 'Save file' })
map('n', '<leader>q', '<cmd>quit<cr>', { desc = 'Quit window' })
map('n', '<Esc>', '<cmd>nohlsearch<cr>', { desc = 'Clear search highlight' })

-- Escape insert mode
map('i', 'jj', '<Esc>', { desc = 'Escape insert mode' })

-- System clipboard (kept from previous config)
map({ 'n', 'v', 'x' }, '<leader>y', '"+y', { desc = 'Yank to system clipboard' })
map({ 'n', 'v', 'x' }, '<leader>Y', '"+Y', { desc = 'Yank line to system clipboard' })
map({ 'v', 'x' }, '<leader>d', '"+d', { desc = 'Delete to system clipboard' })

-- Window navigation
map('n', '<C-h>', '<C-w>h', { desc = 'Go to left window' })
map('n', '<C-j>', '<C-w>j', { desc = 'Go to lower window' })
map('n', '<C-k>', '<C-w>k', { desc = 'Go to upper window' })
map('n', '<C-l>', '<C-w>l', { desc = 'Go to right window' })

-- Resize windows
map('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase window height' })
map('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease window height' })
map('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease window width' })
map('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase window width' })

-- Keep selection while indenting
map('x', '<', '<gv', { desc = 'Indent left' })
map('x', '>', '>gv', { desc = 'Indent right' })

-- Move selected lines
map('x', 'J', ":move '>+1<cr>gv=gv", { desc = 'Move selection down' })
map('x', 'K', ":move '<-2<cr>gv=gv", { desc = 'Move selection up' })
map('x', '<A-j>', ":move '>+1<cr>gv=gv", { desc = 'Move selection down' })
map('x', '<A-k>', ":move '<-2<cr>gv=gv", { desc = 'Move selection up' })

-- Quality-of-life
map('x', 'p', '"_dP', { desc = 'Paste without overwriting register' })
map('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down (centered)' })
map('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up (centered)' })
map('n', 'n', 'nzzzv', { desc = 'Next search result (centered)' })
map('n', 'N', 'Nzzzv', { desc = 'Prev search result (centered)' })

-- Buffers
map('n', '<S-l>', '<cmd>BufferLineCycleNext<cr>', { desc = 'Next buffer' })
map('n', '<S-h>', '<cmd>BufferLineCyclePrev<cr>', { desc = 'Previous buffer' })
map('n', '<leader>bd', '<cmd>bdelete<cr>', { desc = 'Delete buffer' })
map('n', '<leader>bp', '<cmd>BufferLinePick<cr>', { desc = 'Pick buffer' })
map('n', '<leader>bo', function()
    local cur = vim.api.nvim_get_current_buf()
    for _, b in ipairs(vim.api.nvim_list_bufs()) do
        if b ~= cur and vim.bo[b].buflisted and not vim.bo[b].modified then
            pcall(vim.api.nvim_buf_delete, b, {})
        end
    end
end, { desc = 'Delete other buffers' })

-- File explorer
map('n', '<C-e>', '<cmd>NvimTreeToggle<cr>', { desc = 'Toggle file explorer' })
map('n', '<leader>E', '<cmd>NvimTreeToggle<cr>', { desc = 'Toggle file explorer' })

-- UI toggles
map('n', '<leader>uw', function()
    vim.opt.wrap = not vim.opt.wrap:get()
end, { desc = 'Toggle wrap' })
map('n', '<leader>us', function()
    vim.opt.spell = not vim.opt.spell:get()
end, { desc = 'Toggle spell' })
map('n', '<leader>uh', function()
    local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })
    vim.lsp.inlay_hint.enable(not enabled, { bufnr = 0 })
end, { desc = 'Toggle inlay hints' })
