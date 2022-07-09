local M = {}

local status_web_devicons_ok, web_devicons = pcall(require, 'nvim-web-devicons')
local opts = require('winbar.config').options
local f = require('winbar.utils')

local hl_winbar_path = 'WinBarPath'
local hl_winbar_file = 'WinBarFile'
local hl_winbar_symbols = 'WinBarSymbols'
local hl_winbar_file_icon = 'WinBarFileIcon'

local winbar_mode = function()
    -- if not f.isempty(value) and f.get_buf_option('mod') then
    --     local mod = '%#LineNr#' .. opts.editor_state .. '%*'
    --     if gps_added then
    --         value = value .. ' ' .. mod
    --     else
    --         value = value .. mod
    --     end
    -- end

    -- value = value .. '%{%v:lua.winbar_gps()%}'
end

local winbar_file = function()
    local file_path = vim.fn.expand('%:~:.:h')
    local filename = vim.fn.expand('%:t')
    local file_type = vim.fn.expand('%:e')
    local value = ''
    local file_icon = ''
    local file_icon_color = ''

    file_path = file_path:gsub('^%.', '')
    file_path = file_path:gsub('^%/', '')

    if not f.isempty(filename) then
        local default = false

        if f.isempty(file_type) then
            file_type = ''
            default = true
        end

        if status_web_devicons_ok then
            file_icon, file_icon_color = web_devicons.get_icon_color(filename, file_type, { default = default })
        end

        if not file_icon then
            file_icon = opts.icons.file_icon_default
        end

        vim.api.nvim_set_hl(0, hl_winbar_file_icon, { fg = file_icon_color })
        file_icon = '%#' .. hl_winbar_file_icon .. '#' .. file_icon .. ' %*'

        value = ' '
        if opts.show_file_path then
            local file_path_list = {}
            local _ = string.gsub(file_path, '[^/]+', function(w)
                table.insert(file_path_list, w)
            end)

            for i = 1, #file_path_list do
                value = value .. '%#' .. hl_winbar_path .. '#' .. file_path_list[i] .. ' ' .. opts.icons.seperator .. ' %*'
            end
        end
        value = value .. file_icon
        value = value .. '%#' .. hl_winbar_file .. '#' .. filename .. '%*'
    end

    return value

end

-- local _, gps = pcall(require, 'nvim-gps')
local _, gps = pcall(require, 'nvim-navic')
local winbar_gps = function()
    local status_ok, gps_location = pcall(gps.get_location, {})
    local value = ''

    if status_ok and gps.is_available() and gps_location ~= 'error' and not f.isempty(gps_location) then
        value = '%#' .. hl_winbar_symbols .. '# ' .. opts.icons.seperator .. ' %*'
        value = value .. '%#' .. hl_winbar_symbols .. '#'  .. gps_location .. '%*'
    end

    return value
end

local excludes = function()
    if vim.tbl_contains(opts.exclude_filetype, vim.bo.filetype) then
        vim.opt_local.winbar = nil
        return true
    end

    return false
end

M.init = function()
    if f.isempty(opts.colors.path) then
        hl_winbar_path = 'MsgArea'
    else
        vim.api.nvim_set_hl(0, hl_winbar_path, { fg = opts.colors.path })
    end

    if f.isempty(opts.colors.file_name) then
        hl_winbar_file = 'String'
    else
        vim.api.nvim_set_hl(0, hl_winbar_file, { fg = opts.colors.file_name })
    end

    if f.isempty(opts.colors.symbols) then
        hl_winbar_symbols = 'Function'
    else
        vim.api.nvim_set_hl(0, hl_winbar_symbols, { fg = opts.colors.symbols })
    end
end

M.show_winbar = function()
    if excludes() then
        return
    end

    local value = winbar_file()

    if opts.show_symbols then
        if not f.isempty(value) then
            local gps_value = winbar_gps()
            value = value .. gps_value
        end
    end

    local status_ok, _ = pcall(vim.api.nvim_set_option_value, 'winbar', value, { scope = 'local' })
    if not status_ok then
        return
    end
end

return M
