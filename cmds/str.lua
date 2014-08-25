-- str.lua by Wesker aka DekraN for AlphaBase HM7
-- UPDATED at 09/10/2009, version 1.0.0


function ab_char()
	if isStringForbidden(curcmd[3][1]) then
		return usage()
	end
	local x = ifind(curcmd[3][1])
	if x == nil then
		return print2("INFO: FONT/ID not found.")
	end
	if isStringForbidden(curcmd[3][2]) then
		curcmd[3][2] = "12,12"
	end
	local a = split(curcmd[3][2],',')
	a =
	{
		tonumber(a[1]),
		tonumber(a[2])
	}
	if isStringForbidden(curcmd[3][3]) then
		return
		print2(fstor[1][x][2].." Pixel Size: "..curcmd[3][2]),
		fstor[1][x][1]:setPixelSizes(a[1],a[2])
	end
	local b = split(curcmd[3][3],',')
	print2("Pixel Size: "..curcmd[3][2].." DPIs: "..curcmd[3][3])
	fstor[1][x][1]:setCharSize(a[1],a[2],b[1],b[2])
end
addCommand({ "char" }, "[FONT/ID]~(W,H)~(DPIX,DPIY)")

function ab_schar()
	local b = isStringForbidden(curcmd[3][1]) and char or curcmd[3][1]
	if curcmd[3][1] == '.' or curcmd[3][1] == "\\" or curcmd[3][1] == schar or curcmd[3][1] == sep then
		return
		print2("INFO: Invalid CHAR. It cannot be: '\', '.' or rrepeat char.",{1}),
   		usage({0,1})
	end
	local a = isStringForbidden(curcmd[3][2]) and nickname or curcmd[3][2]
	print2("Successfully charset: "..b.." with REPLACE: "..a,{1})
	char = b
	replace = a
	print2(mode == 1 and "info: Test (trying to printing '"..b.."'): "..char or '',{non(mode),1})
end
addCommand({ "schar" }, "(CHAR)~(REPLACE)")

function ab_ochar()
	local a =
	{
		schar,
		fsep,
		sep
	}
	local b = isStringForbidden(curcmd[3][1]) and 0 or tonumber(curcmd[3][1])
	if b == nil or (b ~= 0 and b ~= 1) then
		return
		print2("INFO: MODE must be 0 for RRC, 1 for FPS, 3 for CPS.",{1}),
		usage({0,1})
	end
	local c = isStringForbidden(curcmd[3][2]) and a[b+1] or curcmd[3][2]
	if b == 0 then
		schar = c
	elseif b == 1 then
		fsep = c
	else
		sep = c
	end
	print2("Successfully charset: "..b)
end
addCommand({ "ochar" }, "(MODE)~(CHAR)")

function ab_sub()
	if isStringForbidden(curcmd[3][1]) or isStringForbidden(curcmd[3][2]) then
		return usage()
	end
	local a = isStringForbidden(curcmd[3][3]) and 1 or getLine(curcmd[3][3])
	if a == nil then
		return
	end
	print2("Successfully replaced all the char like: '"..curcmd[3][1].."'",{1})
	print2("in the line No. "..a.." with: \""..curcmd[3][2].."\".",{mode})
	if mode == 1 then
		print2("info: OLDLINE: "..sysData[envs[1]][1][a][1],{0,1})
	else
		curpos[envs[1]][2] = a
	end
	sysData[envs[1]][1][a][1] = sysData[envs[1]][1][a][1]:gsub(curcmd[3][1], curcmd[3][2])
end
addCommand({ "sub" }, "[STRING]~[STRING2]~(LINE)")

function ab_text()
	if isStringForbidden(curcmd[3][1]) then
		return usage()
	end
	local a = ifind(curcmd[3][1])
	if a == nil then
		return print2("INFO: FONT/ID not found.")
	end
	if isStringForbidden(curcmd[3][2]) then
		curcmd[3][2] = "STRING"
	end
	print2(curcmd[3][2].." Sizes: "..fstor[1][a][1]:getTextSize(curcmd[3][2]))
end
addCommand({ "text" }, "[FONT/ID]~[STRING]")

function ab_print()
	if isStringForbidden(curcmd[3][1]) then
		return usage()
	end
	local b = isStringForbidden(curcmd[3][2]) and 1 or ifind(curcmd[3][2], 4)
	local a = tonumber(curcmd[3][3])
	if a == nil then
		print2(curcmd[3][1])
		sysData[envs[1]][1][#sysData[envs[1]][1]-non(mode)][5] = b
	else
		if a < 1 or a > #sysData[envs[1]][1] then
			return print2("INFO: LINE must be an integer between 1 and number of AB prints.")
		end
		print2("Successfully replaced line No. "..a.." with: ",{1})
		print2(curcmd[3][2], {mode,1})
		if mode == 1 then
			print2("OLDLINE: "..sysData[envs[1]][1][a][1])
		end
		sysData[envs[1]][1][a][1] = curcmd[3][2]
		sysData[envs[1]][1][a][5] = b
	end
end
addCommand({ "print" }, "[STRING]~(COLOR/ID)~(ID)")