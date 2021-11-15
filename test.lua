local path = "/Users/me/.config/posts"
local f = os.execute(('[ -d "%s" ]'):format(path))

if not f then
	os.execute("mkdir " .. path)
end
local dir = io.popen('find "' .. path .. '" -type f')
for filename in dir:lines() do
	print(filename)
end
