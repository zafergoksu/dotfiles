vim.pack.add({
    -- Colorscheme
    { src = 'https://github.com/folke/tokyonight.nvim' },
    { src = 'https://github.com/morhetz/gruvbox' },

    -- UI
    { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
    { src = 'https://github.com/nvim-tree/nvim-tree.lua' },
    { src = 'https://github.com/akinsho/bufferline.nvim' },
    { src = 'https://github.com/nvim-lualine/lualine.nvim' },
    { src = 'https://github.com/lukas-reineke/indent-blankline.nvim' },
    { src = 'https://github.com/folke/which-key.nvim' },

    -- Telescope
    { src = 'https://github.com/nvim-lua/plenary.nvim' },
    { src = 'https://github.com/nvim-telescope/telescope.nvim' },
    { src = 'https://github.com/nvim-telescope/telescope-fzf-native.nvim' },
    { src = 'https://github.com/nvim-telescope/telescope-ui-select.nvim' },

    -- LSP
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = 'https://github.com/mason-org/mason.nvim' },
    { src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
    { src = 'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim' },

    -- Completion + snippets
    { src = 'https://github.com/hrsh7th/nvim-cmp' },
    { src = 'https://github.com/hrsh7th/cmp-nvim-lsp' },
    { src = 'https://github.com/hrsh7th/cmp-buffer' },
    { src = 'https://github.com/hrsh7th/cmp-path' },
    { src = 'https://github.com/hrsh7th/cmp-cmdline' },
    { src = 'https://github.com/L3MON4D3/LuaSnip' },
    { src = 'https://github.com/saadparwaiz1/cmp_luasnip' },
    { src = 'https://github.com/rafamadriz/friendly-snippets' },

    -- Tresitter
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
    { src = 'https://github.com/windwp/nvim-ts-autotag' },

    -- Git
    { src = 'https://github.com/lewis6991/gitsigns.nvim' },
    { src = 'https://github.com/tpope/vim-fugitive' },

    -- Debugging
    { src = 'https://github.com/mfussenegger/nvim-dap' },
    { src = 'https://github.com/rcarriga/nvim-dap-ui' },
    { src = 'https://github.com/theHamsta/nvim-dap-virtual-text' },
    { src = 'https://github.com/nvim-neotest/nvim-nio' },
    { src = 'https://github.com/jay-babu/mason-nvim-dap.nvim' },

    -- Terminal
    { src = 'https://github.com/akinsho/toggleterm.nvim' },
    { src = 'https://github.com/ryanmsnyder/telescope-toggleterm.nvim' },

    -- Editing QoL
    { src = 'https://github.com/m4xshen/autoclose.nvim' },
    { src = 'https://github.com/kylechui/nvim-surround' },
    -- { src = 'https://github.com/folke/flash.nvim' },
    { src = 'https://github.com/ThePrimeagen/harpoon', version = 'harpoon2' },
    { src = 'https://github.com/folke/trouble.nvim' },
    { src = 'https://github.com/folke/todo-comments.nvim' },
    { src = 'https://github.com/stevearc/conform.nvim' },
    { src = 'https://github.com/MeanderingProgrammer/render-markdown.nvim' },

    -- C++ tooling
    { src = 'https://github.com/p00f/clangd_extensions.nvim' },
    { src = 'https://github.com/Civitasv/cmake-tools.nvim' },
    { src = 'https://github.com/krady21/compiler-explorer.nvim' },

    -- Other
    { src = 'https://github.com/chomosuke/typst-preview.nvim' },
    { src = 'https://github.com/coder/claudecode.nvim' },
})

-- Build telescope-fzf-native's native library on install/update, and self-heal if missing.
local function fzf_native_plugin_dir()
    for _, p in ipairs(vim.api.nvim_list_runtime_paths()) do
        if p:match('telescope%-fzf%-native%.nvim$') then return p end
    end
    return nil
end

vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(args)
        local data = args.data
        if data and data.spec and data.spec.name == 'telescope-fzf-native.nvim' and data.kind ~= 'delete' then
            vim.system({ 'make' }, { cwd = data.path }):wait()
        end
    end,
})

vim.api.nvim_create_autocmd('VimEnter', {
    once = true,
    callback = function()
        local dir = fzf_native_plugin_dir()
        if dir and vim.fn.filereadable(dir .. '/build/libfzf.so') ~= 1
            and vim.fn.filereadable(dir .. '/build/libfzf.dylib') ~= 1 then
            vim.notify('Building telescope-fzf-native...', vim.log.levels.INFO)
            vim.system({ 'make' }, { cwd = dir }, function()
                vim.schedule(function()
                    pcall(require('telescope').load_extension, 'fzf')
                end)
            end)
        end
    end,
})

-- Core
require('user.options')
require('user.keybinds')

-- LSP + completion
require('user.mason')
require('user.cmp')
require('user.lsp')

-- UI
require('user.nvim-tree')
require('user.bufferline')
require('user.lualine')
require('user.which-key')
require('user.indent-blankline')

-- Editing
require('user.autoclose')
require('user.surround')
-- require('user.flash')
require('user.harpoon')
require('user.todo-comments')
require('user.conform')
require('user.render-markdown')

-- Treesitter
require('user.nvim-treesitter')
require('user.ts-autotag')

-- Telescope
require('user.telescope')

-- Terminal
require('user.toggleterm')

-- Trouble (diagnostic panel)
require('user.trouble')

-- Git
require('user.gitsigns')

-- Debug
require('user.dap')

-- C++
require('user.clangd-extensions')
require('user.cmake-tools')
require('user.compile-commands')
require('user.compiler-explorer')

-- AI Tools
require('user.claudecode')
