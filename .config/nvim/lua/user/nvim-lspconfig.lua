vim.cmd(
    [[
augroup lsp_format_config
  autocmd!
  autocmd BufWritePost * lua vim.lsp.buf.format()
augroup end
]]
)
