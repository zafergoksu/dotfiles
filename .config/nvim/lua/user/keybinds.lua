-- General
vim.keymap.set('n', '<leader>s', ':update<CR>', { desc = 'Save' })
vim.keymap.set('n', '<leader>q', ':quit<CR>', { desc = 'Quit' })
vim.keymap.set('i', 'jj', '<Esc>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y', { desc = 'Yank to clipboard' })
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>d', '"+d', { desc = 'Delete to clipboard' })

-- LSP
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = 'Go to declaration' })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = 'Go to definition' })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = 'Go to implementation' })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = 'Go to references' })
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = 'Rename symbol' })
vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, { desc = 'Type definition' })
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = 'Format' })
vim.keymap.set("n", "<C-s>", vim.lsp.buf.signature_help, { desc = 'Signature help' })
vim.keymap.set("n", "[g", vim.diagnostic.goto_prev, { desc = 'Previous diagnostic' })
vim.keymap.set("n", "]g", vim.diagnostic.goto_next, { desc = 'Next diagnostic' })

vim.lsp.enable({ 'lua_ls', 'svelte-language-server', 'clangd', 'gopls', 'rust_analyzer' })

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Visual mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("x", "J", ":move '>+1<CR>gv-gv")
vim.keymap.set("x", "K", ":move '<-2<CR>gv-gv")
vim.keymap.set("x", "<A-j>", ":move '>+1<CR>gv-gv")
vim.keymap.set("x", "<A-k>", ":move '<-2<CR>gv-gv")

-- File explorer
vim.keymap.set('n', '<C-e>', ':NvimTreeToggle<CR>')

vim.keymap.set("n", "<S-l>", ":bnext<CR>")
vim.keymap.set("n", "<S-h>", ":bprevious<CR>")
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>")
vim.keymap.set("n", "<leader>bD", ":%bdelete<CR>")

-- Claude Code keybindings
vim.keymap.set("n", "<leader>ac", "<cmd>ClaudeCode<cr>", { desc = "Toggle Claude" })
vim.keymap.set("n", "<leader>af", "<cmd>ClaudeCodeFocus<cr>", { desc = "Focus Claude" })
vim.keymap.set("n", "<leader>ar", "<cmd>ClaudeCode --resume<cr>", { desc = "Resume Claude" })
vim.keymap.set("n", "<leader>aC", "<cmd>ClaudeCode --continue<cr>", { desc = "Continue Claude" })
vim.keymap.set("n", "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", { desc = "Add buffer to Claude" })
vim.keymap.set("v", "<leader>as", "<cmd>ClaudeCodeSend<cr>", { desc = "Send selection to Claude" })

-- Which-key keybindings
vim.keymap.set("n", "<leader>?", "<cmd>WhichKey<cr>", { desc = "Show all keybindings" })

-- Git Fugitive keybindings
vim.keymap.set("n", "<leader>gs", "<cmd>Git<cr>", { desc = "Git status" })
vim.keymap.set("n", "<leader>gc", "<cmd>Git commit<cr>", { desc = "Git commit" })
vim.keymap.set("n", "<leader>gp", "<cmd>Git push<cr>", { desc = "Git push" })
vim.keymap.set("n", "<leader>gl", "<cmd>Git pull<cr>", { desc = "Git pull" })
vim.keymap.set("n", "<leader>gB", "<cmd>Git blame<cr>", { desc = "Git blame" })
vim.keymap.set("n", "<leader>gL", "<cmd>Git log<cr>", { desc = "Git log" })
vim.keymap.set("n", "<leader>gd", "<cmd>Gdiffsplit<cr>", { desc = "Git diff split" })
vim.keymap.set("n", "<leader>gD", "<cmd>Gdiffsplit!<cr>", { desc = "Git diff 3-way" })
