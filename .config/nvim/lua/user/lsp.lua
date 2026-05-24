-- Completion capabilities advertised to every server (from nvim-cmp).
local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok_cmp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
if ok_cmp then
    capabilities = vim.tbl_deep_extend('force', capabilities, cmp_lsp.default_capabilities())
end

-- Defaults applied to all servers, plus per-server overrides.
-- (nvim 0.11+ vim.lsp.config / vim.lsp.enable; servers are auto-enabled by
-- mason-lspconfig and their base configs come from nvim-lspconfig.)
vim.lsp.config('*', {
    capabilities = capabilities,
})

vim.lsp.config('lua_ls', {
    settings = {
        Lua = {
            runtime = { version = 'LuaJIT' },
            workspace = {
                checkThirdParty = false,
                library = vim.api.nvim_get_runtime_file('', true),
            },
            diagnostics = { globals = { 'vim' } },
            telemetry = { enable = false },
        },
    },
})

vim.lsp.config('clangd', {
    cmd = {
        'clangd',
        '--background-index',
        '--clang-tidy',
        '--header-insertion=iwyu',
        '--header-insertion-decorators',
        '--completion-style=detailed',
        '--function-arg-placeholders',
        '--all-scopes-completion',
        '--pch-storage=memory',
        '--offset-encoding=utf-16',
    },
    init_options = { fallbackFlags = { '-std=c++20' } },
})

-- Install + auto-enable servers.
require('mason-lspconfig').setup({
    ensure_installed = {
        'lua_ls',
        'clangd',
        'gopls',
        'rust_analyzer',
        'svelte',
        'pyright',
    },
    automatic_enable = true,
})

-- Buffer-local keymaps once a server attaches.
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local bufnr = ev.buf
        local client = vim.lsp.get_client_by_id(ev.data.client_id)

        -- Guarantee native completion never competes with nvim-cmp.
        pcall(vim.lsp.completion.enable, false, ev.data.client_id, bufnr)

        local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        local ok_tel, builtin = pcall(require, 'telescope.builtin')
        if ok_tel then
            map('n', 'gd', builtin.lsp_definitions, 'Goto definition')
            map('n', 'gr', builtin.lsp_references, 'Goto references')
            map('n', 'gi', builtin.lsp_implementations, 'Goto implementation')
            map('n', 'gy', builtin.lsp_type_definitions, 'Goto type definition')
        else
            map('n', 'gd', vim.lsp.buf.definition, 'Goto definition')
            map('n', 'gr', vim.lsp.buf.references, 'Goto references')
            map('n', 'gi', vim.lsp.buf.implementation, 'Goto implementation')
            map('n', 'gy', vim.lsp.buf.type_definition, 'Goto type definition')
        end

        map('n', 'gD', vim.lsp.buf.declaration, 'Goto declaration')
        map('n', 'K', vim.lsp.buf.hover, 'Hover documentation')
        map({ 'n', 'i' }, '<C-s>', vim.lsp.buf.signature_help, 'Signature help')
        map('n', '<leader>rn', vim.lsp.buf.rename, 'Rename symbol')
        map({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, 'Code action')
        map('n', ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end, 'Next diagnostic')
        map('n', '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end, 'Prev diagnostic')

        -- Inlay hints on by default where supported (toggle with <leader>uh).
        if client and client:supports_method('textDocument/inlayHint') then
            pcall(vim.lsp.inlay_hint.enable, true, { bufnr = bufnr })
        end
    end,
})
