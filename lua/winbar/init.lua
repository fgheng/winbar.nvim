local opts = require('winbar.config').options

local M = {}

function M.setup(custom_opts)
    require('winbar.config').set_options(custom_opts)
    local winbar = require('winbar.winbar')

    winbar.init()
    if opts.enabled == true then
        vim.api.nvim_create_autocmd({ 'DirChanged', 'CursorMoved', 'BufWinEnter', 'BufFilePost', 'InsertEnter', 'BufWritePost' }, {
            callback = function()
                winbar.show_winbar()
            end
        })
    end
end

return M
