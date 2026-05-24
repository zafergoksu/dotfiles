local function on_attach(bufnr)
    local api = require('nvim-tree.api')
    local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    api.config.mappings.default_on_attach(bufnr)

    -- Custom mappings
    vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
    vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
    vim.keymap.set('n', 'o', api.node.open.edit, opts('Open'))
    vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Directory'))
    vim.keymap.set('n', '<C-v>', api.node.open.vertical, opts('Open: Vertical Split'))
    vim.keymap.set('n', '<C-x>', api.node.open.horizontal, opts('Open: Horizontal Split'))
    vim.keymap.set('n', '<C-e>', api.tree.close, opts('Close'))
end

require('nvim-tree').setup({
    on_attach = on_attach,
    view = { width = 35 },
    renderer = {
        group_empty = true,
        highlight_git = true,
        indent_markers = { enable = true },
    },
    diagnostics = { enable = true },
    git = { enable = true },
    update_focused_file = { enable = true },
    filters = { dotfiles = false },
})
