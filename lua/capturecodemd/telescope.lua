local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local config = require("telescope.config").values
local c_conf = require("capturecodemd.config")
local popwin = require("capturecodemd.popwin")
local utils = require("capturecodemd.utils")
local my_path = c_conf.options.path
local ok, err, code = os.rename(my_path, my_path)
if not ok then
	print("create dir" .. my_path)
	os.execute("mkdir " .. my_path)
end
local dir = io.popen('find "' .. my_path .. '" -type f')
-- Create a collection of files
local md_files = {}
for filename in dir:lines() do
	table.insert(md_files, filename)
end
dir:close()
local yank_text
local coppy_text
local file_path
local current_file_type = vim.bo.filetype
M = {}
M.addComment = function()
	local comment = vim.api.nvim_get_current_line()
	local destination_file = io.open(file_path, "a")
	if coppy_text ~= nil then
		destination_file:write("\n" .. comment .. "\n" .. "```" .. current_file_type .. "\n" .. coppy_text .. "```")
	else
		destination_file:write("\n" .. comment .. "\n" .. "```" .. current_file_type .. "\n" .. yank_text .. "```")
	end
	destination_file:close()
	vim.cmd("stopinsert")
	vim.cmd("q")
end
local function setCommentWithEnter(curbuf)
	vim.api.nvim_buf_set_keymap(
		curbuf,
		"i",
		"<CR>",
		"<cmd>lua require('capturecodemd.telescope').addComment()<CR>",
		{ noremap = true }
	)
end

M.capture_code = function(telescope_opts)
	telescope_opts = telescope_opts or {}
	pickers.new(telescope_opts, {
		prompt_title = "Copy into file",
		finder = finders.new_table({
			results = md_files,
			entry_maker = function(entry)
				local displayPath = string.gsub(entry, ".+notes/", "")
				return {
					value = entry,
					display = displayPath,
					ordinal = entry,
				}
			end,
		}),
		sorter = config.generic_sorter(telescope_opts),
		attach_mappings = function(prompt_bufnr, map)
			actions.select_default:replace(function()
				-- actions.close(prompt_bufnr)
				yank_text = vim.fn.getreg("0")
				coppy_text = vim.fn.getreg("*")
				file_path = action_state.get_selected_entry()
				if file_path == nil then
					local filename = action_state.get_current_line()
					print("Do you want to create " .. filename .. ".md note and paste your copy into it y/n ?")
					local ans = utils.get_user_input_char()
					if ans ~= "y" then
						return true
					else
						actions.close(prompt_bufnr)
						local new_buf = vim.api.nvim_create_buf(false, true)
						local win = popwin.create_win(new_buf)
						file_path = my_path .. "/" .. filename .. ".md"
						-- clear messages
						table.insert(md_files, file_path)
						vim.api.nvim_command("normal! :")
						setCommentWithEnter(new_buf)
					end
				else
					actions.close(prompt_bufnr)
					file_path = action_state.get_selected_entry().value
					local new_buf = vim.api.nvim_create_buf(false, true)
					local win = popwin.create_win(new_buf)
					setCommentWithEnter(new_buf)
				end
			end)
			return true
		end,
		previewer = config.grep_previewer(telescope_opts),
	}):find()
end
return M
