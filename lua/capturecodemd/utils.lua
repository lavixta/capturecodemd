local M = {}
M.get_user_input_char = function()
	local c = vim.fn.getchar()
	while type(c) ~= "number" do
		c = vim.fn.getchar()
	end
	return vim.fn.nr2char(c)
end
M.addComment = function(file_path, current_file_type, yank_text)
	local comment = vim.api.nvim_get_current_line()
	local destination_file = io.open(file_path, "w")
	destination_file:write(comment .. "\n" .. "```" .. current_file_type .. "\n" .. yank_text .. "```")
	vim.cmd("stopinsert")
	vim.cmd("q")
end
return M
