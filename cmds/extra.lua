-- extra.lua by Wesker aka DekraN for AlphaBase HM7
-- UPDATED at 09/10/2009, version 1.0.0


function ab_umd()
	if UMD.checkDisk() == 0 then
		return print2("INFO: UMD not found in UMD unit.")
	end
	UMD.init()
	if isStringForbidden(curcmd[2][2]) then
		return
		print2("*** UMD STARTED ***"),
		startend()
	end
	local x = fsym(curcmd[2][2])
	if type(x) == 'number' then
		return
	end
	curcmd[2][2] = x
	if mode == 0 and System.doesFileExist(curcmd[2][2]) == 1 then
		return print2("INFO: "..fixString(curcmd[2][2]).." already exists.")
	end
	local a = split(curcmd[2][2],'/')
	local m = #a
	local b = split(curcmd[2][2],a[m])
	UMD.ripISO(curcmd[2][2])
	print2("UMD successfully ripped as:",{1,1})
	print2(fixString(curcmd[2][2]),{0,1})
end
addCommand({ "umd" }, "(PATH)")

function ab_save()
	if isStringForbidden(curcmd[2][2]) then
		if curfile == nil then
			return usage()
		else
			curcmd[2][2] = curfile
		end
	end
	local a = split(curcmd[2][2],'/')
	local m = #a
	local b = split(curcmd[2][2],'/'..a[m])
	local x = fsym(a[m])
	if type(x) == 'number' then
		return
	end
	if System.doesDirExist(b[1]) == 0 and m ~= 1 then
		return print2("INFO: "..fixString(b[1]).." doesnt exist.")
	end
	if isForbiddenImage(b[1]..x) == 1 then
		return
	end
	if mode == 0 and System.doesFileExist(x) == 1 then
		return print2("INFO: "..fixString(curcmd[2][2]).." already exists.")
	end
	screen:save(x)
	print2("Screenshot successfully saved as:",{1,1})
		print2(fixString(x),{0,1})
end
addCommand({ "save" }, "(PATH)")

function ab_alarm()
	local a = isStringForbidden(curcmd[3][1]) and 1 or tonumber(curcmd[3][1])
	if a == nil or (a ~= 0 and a ~= 1 and a ~= 2 and a ~= 3) then
		return
		print2("INFO: MODE must be 0 for Ogg, 1 for Mp3, 2 for Aa3 or 3 for other formats.",{1}),
		usage({0,1})
	end
	if fstor[a+5] == nil then
		return print2("INFO: No Music currently loaded in this format.")
	end
	local b = isStringForbidden(curcmd[3][2]) and 0 or tonumber(curcmd[3][2])
	if b == nil or (b ~= 0 and b ~= 1) then
		return
		print2("INFO: MODE must be a boolean value (0 for AM, 1 for PM).",{1}),
		usage({0,1})
	end
	local c = isStringForbidden(curcmd[3][3]) and 0 or tonumber(curcmd[3][3])
	if c == nil or (c ~= 0 and c ~= 1) then
		return
		print2("INFO: MODE2 must be a boolean value (0 for null, 1 for repeat).",{1}),
		usage({0,1})
	end
	local s = isStringForbidden(curcmd[3][4]) and 0 or tonumber(curcmd[3][4])
	if s == nil or (s ~= 0 and s ~= 1) then
		return
		print2("INFO: MODE3 must be a boolean value (0 for null, 1 for sleeping awhile).",{1}),
		usage({0,1})
	end
	local d =
	{
		0,
		0
	}
	if not isStringForbidden(curcmd[3][5]) then
		local e = split(curcmd[3][5],':')
		if #e == 1 then
			return
			print2("INFO: Invalid input (arguments must be seperated by ':'.",{1}),
			usage({0,1})
		end
		d =
		{
			tonumber(e[1]),
			tonumber(e[2])
		}
		if d[1] == nil or d[2] == nil
		or d[1] < 0 or d[2] < 0
		or d[1] > 12 or d[2] > 59 then
			return
			print2("INFO: Invalid H:M format.",{1}),
			usage({0,1})
		end
	end
	local x =
	{
		tonumber(System.getTime(1)),
		tonumber(System.getTime(2))
	}
	local scan =
	{
		System.getTime(5) == "am" and x[1] or x[1] +12,
		x[1] < d[1] and 0 or 12
	}
	local time =
	{
		(scan[1]*60+x[2])*60+tonumber(System.getTime(3)),
		math.abs(scan[2]-((d[1]+12*b)*60+d[2])*60)
	}
	sendInput("set "..time[2]..','..time[1]..sep..c..sep.."play2 "..fstor[a+5],1)
	if s == 1 then
		sendInput("sleep "..time[2]-time[1])
	end
end
addCommand({ "alarm" }, "(MODE)~(MODE2)~(MODE3)~(MODE4)~(H:M)")