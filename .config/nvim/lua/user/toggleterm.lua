require('toggleterm').setup({
    open_mapping = [[<c-\>]],
    direction = 'float',
    float_opts = { border = 'rounded' },
    size = function(term)
        if term.direction == 'horizontal' then
            return 15
        elseif term.direction == 'vertical' then
            return math.floor(vim.o.columns * 0.4)
        end
    end,
})

-- Easier navigation out of a toggleterm terminal.
local function set_terminal_keymaps()
    local opts = { buffer = 0 }
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

vim.api.nvim_create_autocmd('TermOpen', {
    pattern = 'term://*toggleterm#*',
    callback = set_terminal_keymaps,
})

local map = vim.keymap.set
map('n', '<leader>tt', '<cmd>ToggleTerm<cr>', { desc = 'Toggle terminal' })
map('n', '<leader>tf', '<cmd>ToggleTerm direction=float<cr>', { desc = 'Float terminal' })
map('n', '<leader>th', '<cmd>ToggleTerm direction=horizontal<cr>', { desc = 'Horizontal terminal' })
map('n', '<leader>tv', '<cmd>ToggleTerm direction=vertical<cr>', { desc = 'Vertical terminal' })

-- Lazygit in a floating terminal (only if it's installed).
local ok, terminal = pcall(require, 'toggleterm.terminal')
if ok and vim.fn.executable('lazygit') == 1 then
    local lazygit = terminal.Terminal:new({ cmd = 'lazygit', direction = 'float', hidden = true })
    map('n', '<leader>tg', function() lazygit:toggle() end, { desc = 'Lazygit' })
end
