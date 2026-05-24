require('cmake-tools').setup({
    cmake_command = 'cmake',
    cmake_build_directory = 'build',
    cmake_generate_options = { '-DCMAKE_EXPORT_COMPILE_COMMANDS=ON' },
    -- Soft-link build/compile_commands.json into the project root so clangd
    -- finds it (see also user.compile-commands for a manual fallback).
    cmake_soft_link_compile_commands = false,
    cmake_compile_commands_from_lsp = false,
    cmake_dap_configuration = {
        name = 'cpp',
        type = 'codelldb',
        request = 'launch',
        stopOnEntry = false,
        runInTerminal = true,
        console = 'integratedTerminal',
    },
})

local map = vim.keymap.set
map('n', '<leader>mg', '<cmd>CMakeGenerate<cr>', { desc = 'CMake generate' })
map('n', '<leader>mb', '<cmd>CMakeBuild<cr>', { desc = 'CMake build' })
map('n', '<leader>mr', '<cmd>CMakeRun<cr>', { desc = 'CMake run' })
map('n', '<leader>md', '<cmd>CMakeDebug<cr>', { desc = 'CMake debug' })
map('n', '<leader>mt', '<cmd>CMakeSelectBuildType<cr>', { desc = 'Select build type' })
map('n', '<leader>ms', '<cmd>CMakeSelectBuildTarget<cr>', { desc = 'Select build target' })
map('n', '<leader>mT', '<cmd>CMakeSelectLaunchTarget<cr>', { desc = 'Select launch target' })
map('n', '<leader>mc', '<cmd>CMakeClean<cr>', { desc = 'CMake clean' })
map('n', '<leader>mk', '<cmd>CMakeStop<cr>', { desc = 'CMake stop' })
map('n', '<leader>mP', '<cmd>CMakeSelectConfigurePreset<cr>', { desc = 'Select configure preset' })
map('n', '<leader>mB', '<cmd>CMakeSelectBuildPreset<cr>', { desc = 'Select build preset' })
