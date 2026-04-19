vim.g.mapleader = ' '

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.swapfile = false
vim.opt.hlsearch = false
vim.opt.completeopt:append('noselect')
vim.o.winborder = 'rounded'

-- LSP completion
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
    end,
})

-- Colorscheme
vim.cmd.colorscheme('gruber-darker')
vim.cmd('hi statusline guibg=NONE')
