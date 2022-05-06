require("user.lsp.init").setup_lsp()

vim.cmd(
  [[
augroup lsp_format_config
  autocmd!
  autocmd BufWritePost * lua vim.lsp.buf.formatting_sync()
augroup end
]]
)
