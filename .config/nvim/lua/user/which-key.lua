local wk = require('which-key')

wk.setup({
    delay = 500,
    icons = { mappings = false },
    triggers = {
        { "<leader>a", mode = "nv" },
        { "<leader>b", mode = "n" },
        { "<leader>g", mode = "n" },
        { "<leader>h", mode = "nv" },
        { "<leader>t", mode = "n" },
    },
})

-- Register key group labels
wk.add({
    { "<leader>a", group = "Claude" },
    { "<leader>b", group = "Buffer" },
    { "<leader>g", group = "Git" },
    { "<leader>h", group = "Hunk" },
    { "<leader>t", group = "Toggle" },
})
