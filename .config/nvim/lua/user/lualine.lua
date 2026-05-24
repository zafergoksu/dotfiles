local function cmake_status()
    local ok, ct = pcall(require, 'cmake-tools')
    if not ok or not (ct.is_cmake_project and ct.is_cmake_project()) then
        return ''
    end
    local parts = {}
    if ct.get_build_type then
        local okb, bt = pcall(ct.get_build_type)
        if okb and bt and bt ~= '' then table.insert(parts, bt) end
    end
    if ct.get_build_target then
        local okt, tgt = pcall(ct.get_build_target)
        if okt and tgt and tgt ~= '' then table.insert(parts, tgt) end
    end
    if #parts == 0 then return '' end
    return ' ' .. table.concat(parts, ' ')
end

require('lualine').setup({
    options = {
        theme = 'tokyonight',
        globalstatus = true,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = { statusline = { 'NvimTree' } },
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff' },
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = { cmake_status, 'diagnostics', 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
    },
})
