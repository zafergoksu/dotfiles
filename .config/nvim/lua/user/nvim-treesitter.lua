-- Neovim 0.12+ ships built-in treesitter parsers and highlighting
-- nvim-treesitter is now mainly used for installing additional parsers
require('nvim-treesitter').setup({
    -- Install additional parsers not bundled with Neovim
    ensure_install = {
        -- Systems / low-level
        "c", "cpp", "rust", "go", "zig",
        -- Scripting
        "python", "bash", "lua", "perl", "ruby",
        -- Web
        "javascript", "typescript", "tsx", "html", "css", "svelte", "vue", "json", "yaml", "toml",
        -- Data / config
        "sql", "graphql", "dockerfile", "make", "cmake",
        -- Documentation
        "markdown", "markdown_inline", "typst", "latex",
        -- Other
        "java", "kotlin", "swift", "elixir", "haskell", "ocaml",
    },
    -- Highlighting is enabled by default in Neovim 0.12+
})
