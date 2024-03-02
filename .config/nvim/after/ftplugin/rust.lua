local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set(
  "n", 
  "K", 
  function()
    vim.cmd.RustLsp('hover', 'actions') -- supports rust-analyzer's grouping
    -- or vim.lsp.buf.codeAction() if you don't want grouping.
  end,
  { silent = true, buffer = bufnr }
)

vim.keymap.set(
  "n", 
  "<leader>dg", 
  function()
    vim.cmd.RustLsp('debuggables') -- supports rust-analyzer's grouping
    -- or vim.lsp.buf.codeAction() if you don't want grouping.
  end,
  { silent = true, buffer = bufnr }
)

vim.keymap.set(
  "n", 
  "<leader>roc", 
  function()
    vim.cmd.RustLsp('openCargo') -- supports rust-analyzer's grouping
    -- or vim.lsp.buf.codeAction() if you don't want grouping.
  end,
  { silent = true, buffer = bufnr }
)

