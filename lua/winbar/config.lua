local config = {}

config.options = {
    enabled = true,

    show_file_path = true,
    show_symbols = true,

    colors = {
        path = '',
        file_name = '',
        symbols = '',
    },

    icons = {
        file_icon_default = '',
        seperator = '>',
        editor_state = '●',
        lock_icon = '',
    },

    exclude_filetype = {
        'help',
        'startify',
        'dashboard',
        'packer',
        'neogitstatus',
        'NvimTree',
        'Trouble',
        'alpha',
        'lir',
        'Outline',
        'spectre_panel',
        'toggleterm',
        'qf',
    }
}

function config.set_options(opts)
    opts = opts or {}

    for opt, _ in pairs(opts) do
        if (config.options[opt] ~= nil) then
            config.options[opt] = opts[opt]
        end
    end
end

return config
