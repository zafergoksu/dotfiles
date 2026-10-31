local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
	defaults = {
		path_display = { "truncate" },
		mappings = {
			i = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
				["<esc>"] = actions.close,
			},
		},
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
		-- Route vim.ui.select() through telescope (cmake target picker, the
		-- dap executable picker, LSP code actions, etc.).
		["ui-select"] = {},
	},
})

-- These are built lazily; the fzf native library is compiled from init.lua.
pcall(telescope.load_extension, "fzf")
pcall(telescope.load_extension, "toggleterm")
pcall(telescope.load_extension, "ui-select")

local builtin = require("telescope.builtin")
local map = vim.keymap.set

map("n", "<C-p>", builtin.git_files, { desc = "Git files" })
map("n", "<C-g>", builtin.git_status, { desc = "Git status" })
map("n", "<C-f>", builtin.find_files, { desc = "Find files" })

map("n", "<leader>pf", builtin.find_files, { desc = "Find files" })
map("n", "<leader>pg", builtin.live_grep, { desc = "Live grep" })
map("n", "<leader>pw", builtin.grep_string, { desc = "Grep word under cursor" })
map("n", "<leader>pb", builtin.buffers, { desc = "Buffers" })
map("n", "<leader>pr", builtin.oldfiles, { desc = "Recent files" })
map("n", "<leader>ph", builtin.help_tags, { desc = "Help tags" })
map("n", "<leader>pk", builtin.keymaps, { desc = "Keymaps" })
map("n", "<leader>pd", builtin.diagnostics, { desc = "Diagnostics" })
map("n", "<leader>pc", builtin.commands, { desc = "Commands" })
map("n", "<leader>p/", builtin.current_buffer_fuzzy_find, { desc = "Search in current buffer" })
