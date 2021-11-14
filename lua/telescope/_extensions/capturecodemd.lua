local telescope = require('telescope')
local capture_code = require('capturecodemd.telescope').capture_code

return telescope.register_extension { exports = { capturecodemd = capture_code } }

