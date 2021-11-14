local M = {}
local defaults = {
	path = "posts",
}
M.options = {}

function M.setup(opts)
	opts = opts or {}
	for key, val in pairs(defaults) do
		if opts[key] == nil then
			opts[key] = val
		end
	end
	M.options = opts
end
M.setup()

return M
