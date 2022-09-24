-- Gruvbox Dark
--[[ vim.g.gruvbox_contrast_dark = "hard" ]]
--[[ vim.cmd("colorscheme gruvbox") ]]

-- Tokyo Night Dark
--[[ vim.cmd("colorscheme tokyonight-night") ]]

-- Nightfox
--[[ vim.cmd("colorscheme nightfox") ]]

-- Github Theme Dark
--[[ require("github-theme").setup({ ]]
--[[     theme_style = "dimmed", ]]
--[[ }) ]]

-- OneDarkPro
require("onedark").setup({
    style = "dark"
})
require("onedark").load()
