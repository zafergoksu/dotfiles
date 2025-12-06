vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.swapfile = false
vim.g.mapleader = ' '
vim.o.winborder = 'rounded'
vim.opt.hlsearch = false
vim.o.winborder = 'none'

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
    end,
})
vim.cmd('set completeopt+=noselect')

-- colorscheme
-- vim.cmd('colorscheme vague')
-- require('ayu').setup({
--     mirage = false
-- })
-- require('ayu').colorscheme()
-- vim.o.background = 'light'
-- vim.cmd('colorscheme gruvbox')

-- vim.cmd.colorscheme('github-monochrome')

vim.cmd.colorscheme('gruber-darker')

vim.cmd(':hi statusline guibg=NONE')
