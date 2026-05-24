-- Leader must be set before plugins/keymaps load.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- nvim-tree wants netrw disabled.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local opt = vim.opt

-- UI
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = 'yes'
opt.termguicolors = true
opt.showmode = false       -- lualine shows the mode
opt.laststatus = 3         -- global statusline
opt.winborder = 'rounded'
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = false

-- Indentation
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smartindent = true

-- Search
opt.hlsearch = true        -- highlight matches; <Esc> clears (see keybinds)
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- Files / history
opt.swapfile = false
opt.backup = false
opt.undofile = true

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Completion / responsiveness
opt.completeopt = { 'menu', 'menuone', 'noselect' }
-- Neovim 0.12 built-in autocompletion: pinned off so it can't compete with nvim-cmp.
pcall(function() vim.o.autocomplete = false end)
opt.updatetime = 250
opt.timeoutlen = 400

-- Diagnostics
vim.diagnostic.config({
    virtual_text = true,
    severity_sort = true,
    underline = true,
    update_in_insert = false,
    float = { border = 'rounded', source = true },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.INFO] = '',
            [vim.diagnostic.severity.HINT] = '',
        },
    },
})

-- Colorscheme
pcall(function()
    require('tokyonight').setup({ style = 'night' })
    vim.cmd.colorscheme('tokyonight-night')
end)
