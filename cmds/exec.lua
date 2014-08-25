-- exec.lua by Wesker aka DekraN for AlphaBase HM7
-- UPDATED at 18/10/2009, version 1.0.1


function ab_print2()
	if isStringForbidden(curcmd[3][1]) then
		return usage()
	end
	local f = ifind(curcmd[3][2])
	if f == nil then
		return print2("INFO: FONT/ID not found.")
	end
	if isStringForbidden(curcmd[3][3]) then
		curcmd[3][3] = "0, 0"
	end
	local i = split(curcmd[3][3],',')
	i =
	{
		tonumber(i[1]),
		tonumber(i[2])
	}
	if coordsCheck(i[1], i[2]) == 0 then
		return
	end
	local a = isStringForbidden(curcmd[3][4]) and 1 or ifind(curcmd[3][4],4)
	if a == nil then
		return print2("INFO: COLOR/ID not found.")
	end
	if mode == 1 then
		print2("INPUT: "..curcmd[3][1].." ("..fixString(curcmd[3][2])..") ("..curcmd[3][3]..") ("..curcmd[3][4]..')')
	end
	local x = tonumber(curcmd[3][5])
	if x == nil then
		table.insert(sysData[envs[2]][2],{ f, i[1], i[2], curcmd[3][1], a })
	else
		if x < 1 or x > #sysData[envs[1]][2] then
			   return print2("INFO: ID must be an integer between 1 and number of prints.")
		end
		sysData[envs[1]][2][x] =
		{
			f,
			i[1],
			i[2],
			curcmd[3][1],
			a
		}
	end
	if mode == 0 then
		clear = 0
	end
end
addCommand({ "print2" }, "[STRING]~[FONT/ID]~(X,Y)~(COLOR/ID)~ID)")

function ab_img()
	if isStringForbidden(curcmd[3][1]) then
  		return usage()
	end
	local a = ifind(curcmd[3][1],2)
	if a == nil then
	return print2("INFO: NAME/ID not found.")
	end
	local b =
	{
		0,
		0
	}
	if not isStringForbidden(curcmd[3][2]) then
		b = split(curcmd[3][2],',')
		b =
		{
			tonumber(b[1]),
			tonumber(b[2])
		}
		if b[1] == nil or b[2] == nil then
			return print2("INFO: X,Y must be a float array.")
		end
	end
	if coordsCheck(b[1], b[2]) == 0 then
		return
	end
	print2(fstor[2][a][2].." successfully blit in: "..b[1]..','..b[2].." coords.")
	local c = tonumber(curcmd[3][3])
	if c == nil then
		table.insert(sysData[envs[2]][3],{ b[1], b[2], a })
	else
		if c < 1 or c > #sysData[envs[1]][3] then
			return print2("INFO: ID must be an integer between 1 and number of images.")
		end
		sysData[envs[1]][3][c] =
		{
			b[1],
			b[2],
			a
		}
	end
	if mode == 0 then
		clear = 0
	end
end
addCommand({ "img" }, "[NAME/ID]~(X,Y)")

function ab_rect()
	if isStringForbidden(curcmd[3][1]) then
		return usage()
	end
	local a = split(curcmd[3][1],',')
	a =
	{
		tonumber(a[1]),
		tonumber(a[2]),
		tonumber(a[3]),
		tonumber(a[4])
	}
	for i=1,4 do
		if a[i] == nil then
			return print2("INFO: X,Y,W,H must be a float array.")
		end
	end
	if coordsCheck(a[1], a[2]) == 0 or (mode == 0 and coordsCheck(a[1]+a[3],a[2]+a[4]) == 0) then
		return
	end
	local b = isStringForbidden(curcmd[3][2]) and 1 or ifind(curcmd[3][2],4)
	if b == nil then
		return print2("INFO: COLOR not found.")
	end
	local x = isStringForbidden(curcmd[3][3]) and 0 or tonumber(curcmd[3][3])
	if x == nil or (x ~= 0 and x ~= 1) then
		return print2("INFO: MODE must be a boolean value (0 for empty rect, 1 for filled rect).")
	end
	print2("Successfully drawn a"..(x == 1 and " filled" or "n empty")
	..' '..fstor[4][b][2].." rectangle in: "..a[1]..','..a[2].." coords.",{mode})
	print2(mode == 0 and '' or "info: W: "..a[3]..", H: "..a[4]..'.',{1,1})
	local y = tonumber(curcmd[3][4])
	if y == nil then
		table.insert(sysData[envs[2]][4],{ a[1], a[2], a[3], a[4], b, x })
	else
		if y < 1 or y > #sysData[envs[1]][4] then
			print2("INFO: ID must be an integer between 1 and number of rectangles.")
		end
		sysData[envs[1]][4][y] =
		{
			a[1],
			a[2],
			a[3],
			a[4],
			b,
			x
		}
	end
	if mode == 0 then
		clear = 0
	end
end
addCommand({ "rect" }, "[X,Y,W,H]~(COLOR/ID)~(MODE)")

function ab_line()
	if isStringForbidden(curcmd[3][1]) then
		return usage()
	end
	local a = split(curcmd[3][1],',')
	a =
	{
		tonumber(a[1]),
		tonumber(a[2]),
		tonumber(a[3]),
		tonumber(a[4])
	}
	for i=1,4 do
		if a[i] == nil then
			return print2("INFO: X0,Y0,X1,Y1 must be a float array.")
		end
	end
	if coordsCheck(a[1], a[2]) == 0 or coordsCheck(a[3], a[4]) == 0 then
		return
	end
	local b = isStringForbidden(curcmd[3][2]) and 1 or ifind(curcmd[3][2],4)
	if b == nil then
		return print2("INFO: COLOR not found.")
	end
	print2("Successfully drawn a "..fstor[4][b][2]..
	" line in: "..a[1]..','..a[2]..','..a[3]..','..a[4].." coords.")
	local c = tonumber(curcmd[3][3])
	if c == nil then
		table.insert(sysData[envs[2]][5],{ a[1], a[2], a[3], a[4], b })
	else
		if c < 1 or c > #sysData[envs[1]][5] then
		        return print2("INFO: ID must be an integer between 1 and number of lines.")
		end
		sysData[envs[1]][5][c] =
		{
			a[1],
			a[2],
			a[3],
			a[4],
			b
		}
	end
	if mode == 0 then
		clear = 0
	end
end
addCommand({ "line" }, "[X0,Y0,X,Y]~(COLOR/ID)")

function ab_set()
	if isStringForbidden(curcmd[3][1]) or isStringForbidden(curcmd[3][3]) then
		return usage()
	end
	local c = split(curcmd[3][1],',')
	if #c == 1 then
		return print2("INFO: Invalid input (arguments must be seperated by ',').")
	end
	local d =
	{
		tonumber(c[1]),
		tonumber(c[2])
	}
	if d[1] == nil or d[2] == nil or d[1] < 0 or d[2] < 0
	or d[1] < d[2] or d[1] == 0 then
		return
		print2("INFO: TIMEn must be an integer.",{1}),
		print2(mode == 1 and "info: TIME2 must be a non-zero val and must be > than TIME1." or '',{non(mode),1})
	end
	local r = isStringForbidden(curcmd[3][2]) and 0 or tonumber(curcmd[3][2])
	if r == nil or (r ~= 0 and r ~= 1) then
		return print2("INFO: MODE must be a boolean value (0 for null, 1 for repeat).")
	end
	local a = split(curcmd[2][2], curcmd[3][1]..sep..curcmd[3][2]..sep)
	print2("Successfully timerset: "..a[2],{1})
	print2("as TIME2: "..d[1].."sec, TIME1: "..d[2].."sec.",{0,1})
	table.insert(sysData[envs[2]][6],{ Timer.new(d[2]*1000), d[1]*1000, a[2], r, 1 })
	sysData[envs[1]][6][#sysData[envs[1]][6]][1]:start()
	if mode == 0 then
		clear = 0
	end
end
addCommand({ "set" }, "[TIME2,TIME1]~(MODE)~[INPUT]")

function ab_time()
	if isStringForbidden(curcmd[2][2]) then
		return usage()
	end
	local a = nil
	local m = #sysData[envs[1]][6]
	for i=1,m do
		if sysData[envs[1]][6][i][3] == curcmd[2][2] then
			a = i
		end
		if a == nil and i == m then
			return print2("INFO: INPUT not found.")
		end
	end
	if sysData[envs[1]][6][a][5] == 1 then
		sysData[envs[1]][6][a][5] = 0
		sysData[envs[1]][6][a][1]:stop()
	else
		sysData[envs[1]][6][a][5] = 1
		sysData[envs[1]][6][a][1]:start()
	end
	print2("TIMER: "..curcmd[2][2],{1})
	print2("Current Status: "..(sysData[envs[1]][6][a][5] == 1 and "RUNNING" or "STOPPED")..'.',{0,1})
end
addCommand({ "time" }, "[INPUT]")

function ab_res()
	local a =
	{
		"AlphaBase prints",
		"User prints",
		"Images",
		"Rectangles",
		"Lines",
		"Timers"
	}
	local function usage2()
		usage({1})
		print2("INFO: ID must be:",{1,1})
		local s = ''
		for i=0,5 do
			s = s..i.." for "..a[i+1]..(i == 5 and '.' or ", ")
		end
		print2(s,{0,1})
	end
	if isStringForbidden(curcmd[1][2]) then
		if mode == 0 then
			curpos[envs[1]][2] = 1
		end
		for u=1,6 do
			if u == 6 then
				for i=1,#sysData[envs[1]][6] do
					sysData[envs[1]][u][i][1]:reset()
				end
			end
            		sysData[envs[1]][u] = { }
		end
		return print2("*** DISPLAY RESET ***")
	end
	local u = tonumber(curcmd[1][2])
        if u == nil or u < 0 or u > 5 then
		return usage2()
	end
	if isStringForbidden(curcmd[1][3]) then
		if u == 0 and mode == 0 then
        	curpos[envs[1]][2] = 1
		elseif u == 5 then
		    	for i=1,#sysData[envs[1]][6] do
		        	sysData[envs[1]][6][i][1]:reset()
			end
		end
        	sysData[envs[1]][u+1] = { }
		return print2("Successfully reset the group: "..a[u+1]..'.')
	end
	local id = tonumber(curcmd[1][3])
	local m = #sysData[envs[1]][u+1]
	if id == nil or id < 0 or id > m then
		return usage2()
	end
	table.remove(sysData[envs[1]][u+1], id)
	print2("Successfully reset the id: "..id.." from the group: "..a[u+1]..'.')
end
addCommand({ "res" }, "(ID) (ID2)")

function ab_input()
	local b =
	{
		"AlphaBase prints",
		"User prints",
		"Images",
		"Rectangles",
		"Lines",
		"Timers"
	}
	local function usage2()
		usage({1})
		print2("INFO: ID must be:",{1,1})
		local s = ''
		for i=0,5 do
			s = s..i.." for "..b[i+1]..(i == 5 and '.' or ", ")
		end
		print2(s,{0,1})
	end
	local c = { }
	for i=1,6 do
		table.insert(c, #sysData[envs[1]][i])
	end
	if isStringForbidden(curcmd[1][2]) then
		return print2("Total AB Elements: "..c[1]+c[2]+c[3]+c[4]+c[5]+c[6])
	end
	local a = tonumber(curcmd[1][2])
	if a == nil or a < 0 or a > 5 then
		return usage2()
	end
	if isStringForbidden(curcmd[1][3]) then
		return print2("Total "..b[a+1].." group Elements: "..c[a+1])
	end
	local d = tonumber(curcmd[1][3])
	if d == nil or d < 1 or d > c[a+1] then
		return usage2()
	end
	print2("ID: "..a.." ID2: "..d)
	if a == 0 then
		print2("LINE: "..sysData[envs[1]][1][d][1],{1,1})
		print2("INPUT: "..sysData[envs[1]][1][d][3],{mode,1})
		if mode == 1 then
			print2("D/T: "..sysData[envs[1]][1][d][2]..", USER: "..sysData[envs[1]][1][d][4],{0,1})
		end
	elseif a == 1 then
		print2("STRING: "..sysData[envs[1]][2][d][4],{1,1})
		print2("FONT: "..fstor[1][sysData[envs[1]][2][d][1]][2],{1,1})
		print2("X: "..sysData[envs[1]][2][d][2]..", Y: "..sysData[envs[1]][2][d][3].." COLOR: "..fstor[4][sysData[envs[1]][2][d][5]][2],{0,1})
	elseif a == 2 then
		print2("IMAGE: "..fstor[2][sysData[envs[1]][3][d][3]][2]..", X: "..sysData[envs[1]][3][d][1]..", Y: "..sysData[envs[1]][3][d][2],{1,1})
		print2("WIDTH: "..fstor[2][sysData[envs[1]][3][d][3]][1]:width()..", HEIGHT: "..fstor[2][sysData[envs[1]][3][d][3]][1]:height(),{0,1})
	elseif a == 3 then
		print2("X: "..sysData[envs[1]][4][d][1]..", Y: "..sysData[envs[1]][4][d][2]..", COLOR: "..fstor[4][sysData[envs[1]][4][d][5]][2],{1,1})
		print2("WIDTH: "..sysData[envs[1]][4][d][3]..", HEIGHT: "..sysData[envs[1]][4][d][4]..", TYPE: "
		..(sysData[envs[1]][4][d][6] == 0 and "Empty" or "Filled"),{0,1})
	elseif a == 4 then
		print2("X0: "..sysData[envs[1]][5][d][1]..", Y0: "..sysData[envs[1]][5][d][2]..", X: "..sysData[envs[1]][5][d][3]..", Y: "..sysData[envs[1]][5][d][4],{1,1})
		print2("COLOR: "..fstor[5][sysData[envs[1]][5][d][5]][2],{0,1})
	elseif a == 5 then
		print2("TIME2: "..sysData[envs[1]][6][d][2].."sec, CMD: "..sysData[envs[1]][6][d][3],{1,1})
		print2("REPEAT: "..(sysData[envs[1]][6][d][4] == 0 and "No" or "Yes")
		..", STATUS: "..(sysData[envs[1]][6][d][5] == 0 and "Stopped" or "Running"),{0,1})
	end
end
addCommand({ "input" }, "(ID) (ID2)")

function ab_clear()
	clear = non(clear)
	print2("*** SYSTEM CLEAR "..(clear == 1 and "ON" or "OFF").." ***")
end
addCommand({ "clear" })