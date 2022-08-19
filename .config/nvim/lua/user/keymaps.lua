local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Normal
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Save and Quit
keymap("n", "<leader>s", ":w<CR>", opts)
keymap("n", "<leader>q", ":q<CR>", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jj", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Telescope
keymap("n", "<C-p>", "<cmd>Telescope find_files<CR>", opts)
--keymap("n", "<C-p>", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", opts)
keymap("n", "<C-f>", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "\\\\", "<cmd>Telescope buffers<cr>", opts)
keymap("n", ";;", "<cmd>Telescope help_tags<cr>", opts)

-- Nvimtree
keymap("n", "<C-e>", ":NvimTreeToggle<CR>", opts)

-- Formatting
keymap("n", "<leader>f", ":Format<cr>", opts)

-- Buffers
keymap("n", "<leader>d", ":Bdelete %<CR>", opts)

-- DAP
keymap("n", "<leader>b", ":DapToggleBreakpoint<CR>", opts)
keymap("n", "<leader>r", ":lua require('dapui').toggle()<CR>", opts)
keymap("n", "<F4>", ":RustDebuggables<CR>", opts)
keymap("n", "<F5>", ":DapContinue<CR>", opts)
keymap("n", "<F6>", ":DapStepOver<CR>", opts)
keymap("n", "<F7>", ":DapStepInto<CR>", opts)
keymap("n", "<F8>", ":DapStepOut<CR>", opts)
keymap("n", "<F9>", ":DapTerminate<CR>", opts)
