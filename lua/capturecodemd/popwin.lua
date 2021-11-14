local api = vim.api
local M = {}
M.addComment = function ()
    M.comment = api.nvim_get_current_line()
    vim.cmd('stopinsert')
  vim.cmd('q')

  end
M.create_win = function(buf)
  buf = buf
api.nvim_buf_set_option(buf,'bufhidden','wipe')
local editorWidth = api.nvim_get_option('columns')
local editorHeight = api.nvim_get_option('lines')
local opts = {
 relative = "editor",
 style ="minimal",
  width = 100,
  height = 1,
  row = math.ceil((editorHeight)/2 - 1),
  col = math.ceil((editorWidth - 100)/2),
  border = "rounded",
  focusable = true,
}
M.win = api.nvim_open_win(buf,true,opts)
api.nvim_win_set_option(M.win,'winhl','Normal:normal')
vim.schedule(function()
vim.cmd('startinsert')
end)
-- api.nvim_buf_set_keymap(buf,'i','<C-c>',"<cmd>lua vim.cmd('q')<CR>",{silent=true})
-- api.nvim_buf_set_keymap(buf,'i','<ESC>',"<cmd>lua vim.cmd('q')<CR>",{silent=true})

end
return M
