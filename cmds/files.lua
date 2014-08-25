-- files.lua by Wesker aka DekraN for AlphaBase HM7
-- UPDATED at 09/10/2009, version 1.0.0


function ab_write()
	if isStringForbidden(curcmd[3][1]) then
		return usage()
	end
	if mode == 0 then
		if ext(curcmd[3][1], {"AUF"}, 1) ~= nil and access(0, curcmd[1][1]) == -1 then
			return
		end
	end
	if isStringForbidden(curcmd[3][2]) then
		return print2("INFO: DATA must be an unempty string.")
	end
	local a = isStringForbidden(curcmd[3][3]) and 0 or tonumber(curcmd[3][3])
	if a == nil or (a ~= 0 and a ~= 1) then
		return print2("INFO: MODE must be a boolean value (0 for write, 1 for append).")
	end
	local b = isStringForbidden(curcmd[3][4]) and 1 or tonumber(curcmd[3][4])
	if b == nil or (b ~= 0 and b ~= 1) then
		return print2("INFO: MODE2 must be a boolean value (0 for null, 1 for flushing file-buffer).")
	end
	local x = { }
	local y =
	{
		"set",
		"cur",
		"end"
	}
	if not isStringForbidden(curcmd[3][5]) then
		x = split(curcmd[3][5],',')
		if #x == 1 then
			return print2("INFO: Invalid input (arguments must be seperated by ',').")
		end
		for i=1,3 do
			if x[1] == y[i] then
				break
			end
			if i == 3 then
				return print2("INFO: WHENCE must be: \""..y[1].."\", \""..y[2].."\" or \""..y[3].."\"")
			end
		end
		if tonumber(x[2]) == nil then
			return print2("INFO: OFFSET must be an integer.")
		end
	else
		x =
		{
			y[1],
			0
		}
	end
	local f = io.open(curcmd[3][1],a == 0 and 'w' or 'a')
	f:seek(x[1],x[2])
	f:write(curcmd[3][2])
	print2("Data successfully saved to: "..fixString(curcmd[3][1]),{1})
	print2("INPUT: "..curcmd[3][2],{1,1})
	print2(mode == 0 and '' or "WHENCE: "..x[1]..", OFFSET: "..x[2],{non(mode),1})
	if b == 1 then
		f:flush()
	end
	f:close()
end
addCommand({ "write" }, "[PATH]~[DATA]~(MODE)~(MODE2)~(WHENCE, OFFSET)")

function ab_read()
	if isStringForbidden(curcmd[3][1]) then
		return usage()
	end
	if mode == 0 then
		if ext(curcmd[3][1], {"AUF"}, 1) ~= nil and access(0, curcmd[1][1]) == -1 then
			return
		end
	end
	if System.doesFileExist(curcmd[3][1]) == 0 then
		return print2("INFO: "..fixString(curcmd[3][1]).." doesnt exist.")
	end
	if mode == 0 then
		print2("OUTPUT:")
	end
	local a = { }
	for line in io.lines(curcmd[3][1]) do
		table.insert(a, line)
	end
	if isStringForbidden(curcmd[3][2]) then
		local m = #a
		for i=1,m do
			print2(a[i],{i == m and 0 or 1,1})
		end
	else
		local b = tonumber(curcmd[3][2])
		if b == nil then
			return print2("INFO: LINE must be an integer between 1 and number of lines.")
		end
		print2(a[b] == nil and '' or a[b])
	end
end
addCommand({ "read" }, "[PATH]~(LINE)")