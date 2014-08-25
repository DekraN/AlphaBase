-- pser.lua by Wesker aka DekraN for AlphaBase HM7
-- UPDATED at 09/10/2009, version 1.0.0


function ab_prx()
	if isStringForbidden(curcmd[3][1]) then
		if curfile == nil then
			return usage()
		else
			curcmd[3][1] = curfile
		end
	end
	local b = ext(curcmd[3][1],{"prx"})
	if b == nil then
		return
	end
	if type(b) ~= 'number' then
		curcmd[3][1] = b
	end
	if System.doesFileExist(curcmd[3][1]) == 0 then
		return print2("INFO: "..fixString(curcmd[3][1]).." doesnt exist.")
	end
	local a = isStringForbidden(curcmd[3][2]) and 0 or tonumber(curcmd[3][2])
	if a == nil or (a ~= 0 and a ~= 1) then
		return print2("INFO: MODE must be a boolean value (0 for null, 1 for loading kernel).")
	end
	if a == 0 then
		System.loadPrx(curcmd[3][1])
	else
		System.loadPrxKernel(curcmd[3][1])
	end
	print2(fixString(curcmd[3][1]).." successfully loaded.")
end
addCommand({ "prx" }, "[PATH]~(MODE)")

function ab_eboot()
	if isStringForbidden(curcmd[2][2]) then
		if curfile == nil then
			return usage()
		else
			curcmd[2][2] = curfile
		end
	end
	local a = ext(curcmd[2][2],{"pbp"})
	if a == nil then
		return
	end
	if type(a) ~= 'number' then
		curcmd[2][2] = a
	end
	if System.doesFileExist(curcmd[2][2]) == 0 then
		return print2("INFO: "..fixString(curcmd[2][2]).." doesnt exist.")
	end
	print2(fixString(curcmd[2][2]).." successfully loaded.")
	setupFor()
end
addCommand({ "eboot" }, "[PATH]")

function ab_psx()
    if isStringForbidden(curcmd[2][2]) then
		if curfile == nil then
			return usage()
		else
			curcmd[2][2] = curfile
		end
	end
	local a = ext(curcmd[2][2],{"pbp"})
	if a == nil then
		return
	end
	if type(a) ~= 'number' then
		curcmd[2][2] = a
	end
	if System.doesFileExist(curcmd[2][2]) == 0 then
		return print2("INFO: "..fixString(curcmd[2][2]).." doesnt exist.")
	end
	print2(fixString(curcmd[2][2]).." successfully loaded.")
	setupFor()
end
addCommand({ "psx" }, "[PATH]")

function ab_upd()
	if isStringForbidden(curcmd[2][2]) then
		if curfile == nil then
			return usage()
		else
			curcmd[2][2] = curfile
		end
	end
	local a = ext(curcmd[2][2],{"pbp"})
	if a == nil then
		return
	end
	if type(a) ~= 'number' then
		curcmd[2][2] = a
	end
	if System.doesFileExist(curcmd[2][2]) == 0 then
		return print2("INFO: "..fixString(curcmd[2][2]).." doesnt exist.")
	end
	print2(fixString(curcmd[2][2]).." successfully loaded.")
	setupFor()
end
addCommand({ "upd" }, "[PATH]")

function ab_elf()
	if isStringForbidden(curcmd[2][2]) then
		if curfile == nil then
			return usage()
		else
			curcmd[2][2] = curfile
		end
	end
	local a = ext(curcmd[2][2],{"elf"})
	if a == nil then
		return
	end
	if type(a) ~= 'number' then
		curcmd[2][2] = a
	end
	if System.doesFileExist(curcmd[2][2]) == 0 then
		return print2("INFO: "..fixString(curcmd[2][2]).." doesnt exist.")
	end
	print2(fixString(curcmd[2][2]).." successfully loaded.")
	System.loadElf(curcmd[2][2])
end
addCommand({ "elf" }, "[PATH]")

function ab_iso()
	if isStringForbidden(curcmd[2][2]) then
		if curfile == nil then
			return usage()
		else
			curcmd[2][2] = curfile
		end
	end
	local a = ext(curcmd[2][2],{ "iso","cso","rar" })
	if a == nil then
		return
	end
	if type(a) ~= 'number' then
		if mode == 0 then
			curcmd[2][2] = a
		else
			return print2("INFO: NO-Extension Proof System actually doesnt work.")
		end
	end
	if System.doesFileExist(curcmd[2][2]) == 0 then
		return print2("INFO: "..fixString(curcmd[2][2]).." doesnt exist.")
	end
	print2(fixString(curcmd[2][2]).." successfully loaded.")
	setupFor()
end
addCommand({ "iso" }, "[PATH]")

function ab_dfile()
    if isStringForbidden(curcmd[2][2]) then
		if curfile == nil then
			return usage()
		else
			curcmd[2][2] = curfile
		end
	end
	local a = ext(curcmd[2][2],{ "lua","txt","ini","dat" })
	if a == nil then
		return
	end
	if type(a) ~= 'number' then
		if mode == 0 then
			curcmd[2][2] = a
		else
			return print2("INFO: NO-Extension Proof System actually doesnt work.")
		end
	end
	if System.doesFileExist(curcmd[2][2]) == 0 then
		return print2("INFO: "..fixString(curcmd[2][2]).." doesnt exist.")
	end
	print2(fixString(curcmd[2][2]).." successfully loaded.")
	dofile(curcmd[2][2])
end
addCommand({ "dfile" }, "[PATH]")