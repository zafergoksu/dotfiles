-- Gruvbox Dark
vim.g.gruvbox_contrast_dark = "hard"
local colorscheme = "gruvbox"

-- Tokyo Night Dark
-- vim.g.tokyonight_style = "night"
-- vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
--
-- -- Change the "hint" color to the "orange" color, and make the "error" color bright red
-- vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }

-- Github Theme Dark
-- require("github-theme").setup({})
-- local colorscheme = "github_dark"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
end

-- OneDarkPro
--[[ require("onedark").setup({ ]]
--[[     style = "warmer" ]]
--[[ }) ]]
--[[ require("onedark").load() ]]
