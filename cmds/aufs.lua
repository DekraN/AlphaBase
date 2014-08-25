-- aufs.lua by Wesker aka DekraN for AlphaBase HM7
-- UPDATED at 07/10/2009, version 1.0.0


function ab_mark()
	if isStringForbidden(curcmd[3][1]) or isStringForbidden(curcmd[3][2]) then
		return usage()
	end
	local a = split(curcmd[2][2], curcmd[3][1]..sep)
	table.insert(sysData[envs[2]][9], a[2])
	table.insert(sysData[envs[2]][9], curcmd[3][1])
	print2("Marker successfully added into markerslist ("..sysData[envs[1]][12][1]..").")
end
addCommand({ "mark" }, "[NAME]~[INPUT]")

function ab_ctrl()
	local b = access(0, curcmd[1][1])
	if b == -1 then
		return
	end
	if isStringForbidden(curcmd[3][1]) then
		return usage()
	end
	if getCmd(curcmd[3][1]) == nil then
		return print2("INFO: CMD not found into macrolist.")
	end
	local a = isStringForbidden(curcmd[3][2]) and 0 or tonumber(curcmd[3][2])
	if a == nil or a > b then
		return print2("INFO: LEVEL must be an integer <= than "..b..'.')
	end
	table.insert(sysData[envs[2]][8], curcmd[3][1])
	table.insert(sysData[envs[2]][8], curcmd[3][2])
	print2("Control successfully added into cmdlist ("..sysData[envs[1]][12][2]..").",{1})
	print2(mode == 0 and '' or "info: CMD: \""..curcmd[3][1].."\", LVL: "..curcmd[3][2],{non(mode),1})
end
addCommand({ "ctrl" }, "[CMD]~[LEVEL]")

function ab_pos()
	if isStringForbidden(curcmd[3][1]) or isStringForbidden(curcmd[3][2]) then
		return usage()
	end
	local a = split(curcmd[3][1])
	a =
	{
		tonumber(a[1]),
		tonumber(a[2]),
		tonumber(a[3]),
		tonumber(a[4])
	}
	for i=1,4 do
		if a[i] == nil then
			return print2("INFO: XMIN,YMIN,XMAX,YMAX must be a float array.")
		end
	end
	if coordsCheck(a[1], a[2]) == 0 or coordsCheck(a[3], a[4]) == 0 then
		return
	end
	local b = split(curcmd[2][2], curcmd[3][1]..sep)
	table.insert(sysData[envs[2]][7], { a[1], a[2], a[3], a[4], b[2] })
	print2("Successfully added a new pos-control into poslist ("..sysData[envs[1]][12][3]..").",{1})
	print2(mode == 0 and '' or "as INPUT: "..b[2]..
	", XMIN: "..a[1]..", YMIN: "..a[2]..", XMAX: "..a[3]..", YMAX: "..a[4]..'.',{non(mode),1})
end
addCommand({ "pos" }, "[XMIN,YMIN,XMAX,YMAX]~[INPUT]")

function ab_mac()
	local b = mode == 0 and access(0, curcmd[1][1]) or 0
	if b == -1 then
		return
	end
	if isStringForbidden(curcmd[3][1]) then
		return
		restartVars(1),
		print2("Successfully reset the commands list from all the macros loaded.")
	end
	local a = getCmd(curcmd[3][1])
	if a == nil then
		return print2("INFO: CMD not found into macrolist.")
	end
	if isStringForbidden(curcmd[3][2]) then
		for i=#cmd[1][a],3,-1 do
			table.remove(cmd[1][a][i])
		end
		return print2("INFO: Successfully reset the command: "..curcmd[3][1]..'.')
	end
	local c, d = getCmd(curcmd[3][2])
	if a == c then
		return
		table.remove(cmd[1][a][d]),
		print2("Macro successfully removed from macrolist.")
	end
	table.insert(cmd[1][a], curcmd[3][2])
	print2("Macro successfully added into macrolist.",{1})
	print2(mode == 0 and '' or "info: CMD: \""..curcmd[3][1].."\", MAC: "..curcmd[3][2],{non(mode),1})
end
addCommand({ "mac" }, "[CMD]~[REPLACE]")

function ab_fmac()
	local a = isStringForbidden(curcmd[3][1]) and "a-mac.auf" or curcmd[3][1]
    local b = ext(a, { "auf","lua","txt","dat","ini" })
    if b == nil then
		return
	end
	if type(b) ~= 'number' then
		if mode == 0 then
			curcmd[3][1] = b
		else
			return print2("INFO: NO-Extension Proof System actually doesnt work.")
		end
	end
	if getMacro(a, 1) ~= 0 then
		print2("Successfully loaded the macrolist from: "..fixString(c))
	end
end
addCommand({ "fmac" }, "(PATH)")