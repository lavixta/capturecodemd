local config = require('capturecodemd.config')
local has_path,path = pcall(require,'plenary.path')
-- test for all neccessary commands
local a = require('plenary.debug_utils').sourced_filepath()
a = vim.fn.fnamemodify(a,"h:h:h:h")
local M = {}
M.setup = function(opts) config.setup(opts)
end
M.show_md_telescope = function(opts, telescope_opts)
    require('capturecodemd.telescope').capture_code(opts,telescope_opts)
end
-- Use telescope to display files and return error if telescope has not been installed
M.show_md_files = function(opts, telescope_opts)
    if pcall(require, 'telescope') then
        M.show_md_telescope(opts, telescope_opts)
    else
        print("Please install telescope" ) 
    end
end

return M
