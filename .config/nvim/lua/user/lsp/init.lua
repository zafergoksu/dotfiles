local function make_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
    capabilities = vim.tbl_extend("keep", capabilities, require("lsp-status").capabilities)

    return capabilities
end

local function hover()
    local filetype = vim.bo.filetype

    if vim.tbl_contains({ "vim", "help" }, filetype) then
        vim.cmd("h " .. vim.fn.expand("<cword>"))
    elseif vim.tbl_contains({ "man" }, filetype) then
        vim.cmd("Man " .. vim.fn.expand("<cword>"))
    else
        vim.lsp.buf.hover()
    end
end

local function lsp_format(client)
    if client.resolved_capabilities.document_formatting then
        vim.api.nvim_exec(
            [[
            augroup Format
            autocmd! * <buffer>
            autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()
            augroup END
        ]]   ,
            false
        )
    end
end

local function make_on_attach(server_name)
    return function(client, bufnr)
        local function buf_set_keymap(...)
            vim.api.nvim_buf_set_keymap(bufnr, ...)
        end

        local function buf_set_option(...)
            vim.api.nvim_buf_set_option(bufnr, ...)
        end

        local opts = { noremap = true, silent = true }

        buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
        buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)

        if server_name == "rust_analyzer" then
            buf_set_keymap("n", "K", "<cmd>RustHoverActions<CR>", opts)
        else
            buf_set_keymap("n", "K", "<cmd>lua require('user.lsp.init').hover()<CR>", opts)
        end

        buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
        buf_set_keymap("n", "<C-s>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

        buf_set_keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
        buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)

        buf_set_keymap("n", "<leader>ca", "<cmd>lua require('telescope.builtin').lsp_code_actions()<CR>", opts)
        buf_set_keymap("v", "<leader>ca", "<cmd>lua require('telescope.builtin').lsp_code_actions()<CR>", opts)

        buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
        buf_set_keymap("n", "[g", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
        buf_set_keymap("n", "]g", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)

        if server_name == "rust_analyzer" then
            buf_set_keymap("n", "<leader>ff", "<cmd>RustFmt<CR>", opts)
        else
            buf_set_keymap("n", "<leader>ff", "<cmd> lua vim.lsp.buf.formatting()", opts)
        end

        if server_name == "rust_analyzer" then
            buf_set_keymap("n", "gJ", "<cmd>RustJoinLines<CR>", opts)
        end

        if server_name == "tsserver" then
            client.resolved_capabilities.document_formatting = false
        end

        lsp_format(client)
    end
end

local function make_flags()
    return {
        debounce_text_changes = 350,
    }
end

local function make_lua_cmd()
    -- brew install lua-language-server
    local sumneko_binary = "/usr/bin/lua-language-server"

    return { sumneko_binary }
end

local function make_lua_settings()
    local runtime_path = vim.split(package.path, ";")
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")

    local runtime_files = vim.api.nvim_get_runtime_file("", true)
    vim.tbl_extend("keep", runtime_files, {
        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
        [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
    })

    return {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
                -- Setup your lua path
                path = runtime_path,
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false
            }
        },
    }
end

local function setup_lsp()
    local lsp_status = require("lsp-status")
    lsp_status.register_progress()

    local lspconfig = require("lspconfig")
    local capabilities = make_capabilities()
    local flags = make_flags()

    lspconfig.clangd.setup({
        capabilities = capabilities,
        on_attach = make_on_attach("clangd"),
    })

    lspconfig.sumneko_lua.setup({
        cmd = make_lua_cmd(),
        capabilities = capabilities,
        on_attach = make_on_attach("sumneko_lua"),
        flags = flags,
        settings = make_lua_settings(),
    })

    lspconfig.cmake.setup({
        capabilities = capabilities,
        on_attach = make_on_attach("cmake"),
    })

    lspconfig.dockerls.setup({
        capabilities = capabilities,
        on_attach = make_on_attach("dockerls"),
    })

    lspconfig.gopls.setup({
        capabilities = capabilities,
        on_attach = make_on_attach("gopls"),
    })

    local html_capabilities = capabilities
    html_capabilities.textDocument.completion.completionItem.snippetSupport = true

    lspconfig.html.setup({
        capabilities = html_capabilities,
        on_attach = make_on_attach("html"),
    })

    local json_capabilities = capabilities
    json_capabilities.textDocument.completion.completionItem.snippetSupport = true

    lspconfig.jsonls.setup({
        capabilities = html_capabilities,
        on_attach = make_on_attach("jsonls"),
    })

    lspconfig.yamlls.setup({
        capabilities = capabilities,
        on_attach = make_on_attach("yamlls"),
        settings = {
            yaml = {
                schemaStore = {
                    enable = true
                }
            },
        },
    })

    lspconfig.tsserver.setup({
        on_attach = make_on_attach("tsserver"),
        capabilities = capabilities,
        filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
    })

    lspconfig.svelte.setup({
        on_attach = make_on_attach("svelte"),
        capabilities = capabilities,
    })

    local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end
end

return {
    hover = hover,
    make_capabilities = make_capabilities,
    make_on_attach = make_on_attach,
    setup_lsp = setup_lsp
}
