-- useful.lua by Wesker aka DekraN for AlphaBase HM7
-- UPDATED at 09/10/2009, version 1.0.0


function ab_ext()
    if isStringForbidden(curcmd[3][1]) then
		if curfile == nil then
			return usage()
		else
			curcmd[3][1] = curfile
		end
	end
	local c = ext(curcmd[3][1],{"zip","rar"})
	if c == nil then
		return
	end
	if type(a) ~= 'number' then
		if mode == 0 then
			curcmd[3][1] = c
		else
			return print2("INFO: NO-Extension Proof System actually doesnt work.")
		end
	end
	if System.doesFileExist(curcmd[3][1]) == 0 then
		return print2("INFO: "..fixString(curcmd[3][1]).." doesnt exist.")
	end
	local a = System.currentDirectory()
	if not isStringForbidden(curcmd[3][2]) then
		if System.doesDirExist(curcmd[3][2]) == 0 then
			return print2("INFO: "..fixString(curcmd[3][2]).." doesnt exist.")
		end
		a = curcmd[3][2]
	end
	local b = isStringForbidden(curcmd[3][3]) and '' or curcmd[3][3]
	print2(fixString(curcmd[3][1]).." successfully extracted in: "..fixString(a)..'.')
	print2("PASSWORD: "..fixString(b,1))
	ZIP.extract(curcmd[3][1],a,b)
end
addCommand({ "ext" }, "[PATH]~[PATH2]~(PASSWORD)")

function ab_list()
    if isStringForbidden(curcmd[3][1]) then
	    curcmd[3][1] = System.currentDirectory()
    end
    if isStringForbidden(curcmd[3][2]) then
        curcmd[3][2] = ''
	end
    local c = curcmd[3][1]
	local a = ext(c,{"zip", "rar"}, 1)
	if type(a) == 'number' then
		if System.doesFileExist(c) == 0 then
			return print2("INFO: "..fixString(c).." doesnt exist.")
		end
		if System.doesDirExist("temp") == 0 then
			System.createDirectory("temp")
		end
		ZIP.extract(c,"temp",curcmd[3][2])
		c = "temp"
	else
		c = fixLastChar(c, 0)
		if System.doesDirExist(c) == 0 then
		    return print2("INFO: "..fixString(c).." doesnt exist.")
		end
	end
	print2(fixString(c).." CONTENT:")
	local fl = System.listDirectory(c)
	for i,v in ipairs(fl) do
		if v.name ~= '' and v.name ~= '.' and v.name ~= ".." then
			print2("- "..v.name,{i == #fl and 0 or 1,1})
		end
	end
	if c == "temp" then
		System.removeDirectory("temp")
	end
end
addCommand({ "list" }, "(PATH)~(PASSWORD)")

function ab_tree()
	if isStringForbidden(curcmd[2][2]) then
		curcmd[2][2] = System.currentDirectory()
	end
	--[[
	-- highly experimental, it prints all the subdirs but the graphical pattern
	-- gets corrupted after displaying the first subdirs group
	local x = 0
	local function pdir(dir)
		dir = fixLastChar(dir, 0)
		local function doesHaveDirs(fld)
			for i, v in ipairs(System.listDirectory(fld)) do
				if v.name ~= '' and v.name ~= '.' and v.name ~= ".."
				and System.listDirectory(fld..v.name) then
					return 1
				end
			end
		end
		local s = ''
		for i=0,x*4 do
			s = s..' '
		end
		print2(s..fixString(dir)..(doesHaveDirs(dir) == 1 and "__" or ''), {1,1})
		local fl = System.listDirectory(dir)
		for i, v in ipairs(fl) do
			if v.name ~= '' and v.name ~= '.' and v.name ~= ".."
			and System.listDirectory(dir..v.name) then
				pdir(dir..v.name)
				if doesHaveDirs(dir..v.name) then
					x = x +1
				elseif i == #fl then
					x = x -1
				end
			end
		end
	end
	pdir(curcmd[2][2])
	]]
	print2(fixString(curcmd[2][2]).." SUB-DIRS:")
	local function pdir(dir)
		dir = fixLastChar(dir, 0)
		print2(dir,{1,1})
		for i, v in ipairs(System.listDirectory(dir)) do
			if v.name ~= '' and v.name ~= '.' and v.name ~= ".."
			and System.listDirectory(dir..v.name) then
				pdir(dir..v.name)
			end
		end
	end
	pdir(curcmd[2][2])
end
addCommand({ "tree" }, "(PATH)")

function ab_create()
	if isStringForbidden(curcmd[2][2]) then
		return usage()
	end
	if mode == 0 and System.doesDirExist(curcmd[2][2]) == 1 then
		return print2("INFO: "..fixString(curcmd[2][2]).." already exists.")
	end
	local a = fsym(curcmd[2][2])
	if type(a) == 'number' then
		return
	end
	curcmd[2][2] = a
	print2(fixString(curcmd[2][2]).." successfully created.")
	System.createDirectory(curcmd[2][2])
end
addCommand({ "create" }, "[PATH]")

function ab_rem()
    if isStringForbidden(curcmd[2][2]) then
		if curfile == nil then
			return usage()
		else
			curcmd[2][2] = curfile
		end
	end
	if System.doesFileExist(curcmd[2][2]) == 0 and System.doesDirExist(curcmd[2][2]) == 0 then
		return print2("INFO: "..fixString(curcmd[2][2]).." already doesnt exist.")
	end
	print2(fixString(curcmd[2][2]).." successfully removed.")
	
	if System.listDirectory(curcmd[2][2]) then
		System.removeDirectory(curcmd[2][2])
	else
		if mode == 0 then
			if ext(curcmd[2][2], {"AUF"}, 1) ~= nil and access(0, curcmd[1][1]) == -1 then
				return
			end
		end
		System.removeFile(curcmd[2][2])
	end
end
addCommand({ "rem" }, "[PATH]")

function ab_rename()
    if isStringForbidden(curcmd[3][1]) then
		if curfile == nil then
			return usage()
		else
			curcmd[3][1] = curfile
		end
	end
	if System.doesFileExist(curcmd[3][1]) == 0 and System.doesDirExist(curcmd[3][1]) == 0 then
		return print2("INFO: "..fixString(curcmd[3][1]).." doesnt exist.")
	end
	if isStringForbidden(curcmd[3][2]) then
		curcmd[3][2] = mode == 0 and "New"..(mode == 0 and '' or math.random(10000,20000))
	end
	local a = fsym(curcmd[3][2])
	if type(a) == 'number' then
		return
	end
	curcmd[3] = a
	print2(fixString(curcmd[3][1]).." renamed in "..curcmd[3][2])
	local b = { }
	if curcmd[3][1]:find('/') ~= nil then
		local a = split(curcmd[3][1],'/')
		b = split(curcmd[3][1], a[#a])
	else
		b[1] = ''
	end
	System.rename(curcmd[3][1],b[1]..curcmd[3][2])
end
addCommand({ "rename" }, "[PATH]~(STRING)")

function ab_size()
    if isStringForbidden(curcmd[2][2]) then
		if curfile == nil then
			return usage()
		else
			curcmd[2][2] = curfile
		end
	end
	if System.doesFileExist(curcmd[2][2]) == 0 and System.doesDirExist(curcmd[2][2]) == 0 then
		return print2("INFO: "..fixString(curcmd[2][2]).." doesnt exist.")
	end
	local function getDirSize(dir)
		dir = fixLastChar(dir, 0)
		local fl = System.listDirectory(dir)
		local s = 0
		for i, file in pairs(fl) do
			if file.name ~= "" and file.name ~= "." and file.name ~= ".." then
				s = System.listDirectory(dir..file.name)
				and s + getDirSize(dir..file.name)
				or s + System.getFileSize(dir..file.name)
			end
		end
		return s
	end
	print2(fixString(curcmd[2][2]).." SIZE: "
	..(System.listDirectory(curcmd[2][2]) and getDirSize(curcmd[2][2]) or System.getFileSize(curcmd[2][2]))/(1024^2).." MB")
end
addCommand({ "size" }, "[PATH]")

function ab_exists()
    if isStringForbidden(curcmd[2][2]) then
		if curfile == nil then
			return usage()
		else
			curcmd[2][2] = curfile
		end
	end
	print2("INFO: "..fixString(curcmd[2][2])..' '..((System.listDirectory(curcmd[2][2])
	and System.doesDirExist(curcmd[2][2]) or System.getFileSize(curcmd[2][2])) == 1
	and "exists" or "doesnt exist")..'.')
end
addCommand({ "exists" }, "[PATH]")

function ab_copy()
	if isStringForbidden(curcmd[3][1]) then
		if curfile == nil then
			return usage()
		else
			curcmd[3][1] = curfile
		end
	end
	if System.doesFileExist(curcmd[3][1]) == 0 and System.doesDirExist(curcmd[3][1]) == 0 then
		return print2("INFO: "..curcmd[3][1].." doesnt exist.")
	end
	if isStringForbidden(curcmd[3][2]) or System.doesDirExist(curcmd[3][2]) == 0 then
		curcmd[3][2] = System.currentDirectory()
	end
	local a = isStringForbidden(curcmd[3][3]) and 0 or tonumber(curcmd[3][3])
	if a == nil then
		return print2("INFO: MODE must be a boolean value (0 for null, 1 for deleting source).")
	end
	local function copyDir(source, dest, replace)
   		if System.doesDirExist(source) == 0 then
        	System.copyFile(source, dest, replace)
        	printf(source.." copyied in: "..dest..'.',{1,1})
   		else
       	 	source = source .. "/"
        	dest = dest .. "/"
        	fl = System.listDirectory(source)
        	System.createDirectory(dest)
        	for i, file in pairs(fl) do
              	if file.name ~= "" and file.name ~= "." and file.name ~= ".." then
                 	copyDir(source .. file.name, dest .. file.name)
              	end
       		end
   		end
	end
	print2("info: Wait while copying "..fixString(curcmd[3][1]).." in: "..fixString(curcmd[3][2]))
	copyDir(curcmd[3][1], curcmd[3][2], tonumber(curcmd[3][3]))
end
addCommand({ "copy" }, "[PATH]~(PATH2)~(MODE)")

function ab_dirs()
	local old = System.currentDirectory()
	local dir =
	{
		"ISO","MP_ROOT","MyRandomGameboot","SEPLUGINS","PICTURE","VIDEO",
		"MUSIC","PSP","CXMB","GAME","COMMON","RSSCH","SAVEDATA","THEME",
		"PHOTO","APP","RADIOPLAYER","GAME150","LICENSE","GAME3XX","GAME4XX",
		"GAME5XX","IMPORT","100MNV01","100ANV01","ULES00856","UPDATE",
		"ChickHEN","VIDEO"
	}

	System.currentDirectory("ms0:/")
	for i,v in ipairs(dir) do
		if System.doesDirExist(v) == 0 then
			if v == "IMPORT" then
				System.currentDirectory("ms0:/PSP/RSSCH/")
			elseif v == "100MNV01" then
				System.currentDirectory("ms0:/MP_ROOT/")
			elseif v == "ULES00856" then
				System.currentDirectory("ms0:/PSP/APP/")
			elseif v == "UPDATE" then
				System.currentDirectory("ms0:/PSP/GAME/")
			elseif v == "ChickHEN" then
				System.currentDirectory("ms0:/PSP/PHOTO/")
			elseif v == "VIDEO" then
				System.currentDirectory("ms0:/ISO/")
			end
			System.createDirectory(v)
		end
	end
	print2("info: Folders successfully created.")
end
addCommand({ "dirs" })

function ab_md5()
	if isStringForbidden(curcmd[2][2]) then
		if curfile == nil then
			return usage()
		else
			curcmd[2][2] = curfile
		end
	end
	print2(fixString(curcmd[2][2]).." MD5: "..System.md5sum(curcmd[2][2]))
end
addCommand({ "md5" }, "[STRING]")

function ab_info()
	print2("DATE: "..System.getDate(3)..'/'..System.getDate(2)..'/'..System.getDate(1).." TIME: "..System.getTime(1)..':'..System.getTime(2)..':'..System.getTime(3)..':'..System.getTime(4)..' '..System.getTime(5),{1,1})
	print2("PSP INFORMATION: "..System.getModel(1)..' '..System.getModel(0)..' '..System.cfwVersion()..' '..nickname,{1,1})
	print2("Init CPU: "..cpu.."MHZ CPU: "..System.getCpuSpeed().."MHz BUS: "..System.getBusSpeed().."MHz.",{1,1})
	print2("Current USB Status (UPDATED):",{1,1})
	print2(System.usbState(1,1)..", "..System.usbState(2,1)..", "..System.usbState(3,1)..'.',{1,1})
	print2("Current HPRM's Status (UPDATED):",{1,1})
	local a =
	{
		"Not Connected",
		"Connected"
	}
	print2(a[Hprm.headphone()+1]..", "..a[Hprm.remote()+1]..", "..a[Hprm.mic()+1],{1,1})
	if mode == 1 then
		print2("info: C.E.: "..(#sysData[envs[1]] == 13 and sysData[envs[1]][13] or '')..'('..envs[1].."), W.E.: "
		..(#sysData[envs[1]] == 13 and sysData[envs[1]][13] or '')..'('..envs[1]..").",{1,1})
		print2("info: Maximum Environments Allowed: "..max_env..'.',{1,1})
		print2("info: Total Commands: "..#cmd[1]..'.',{1,1})
	end
	if wlan == 1 then
		print2("info: IP: "..fixString(Wlan.getIP(),1),{1,1})
	end
	print2("Available Memory: "..System.getFreeMemory()/(1024^2).."MB",{1,1})
	if UMD.checkDisk() == 1 then
		UMD.init()
		print2("UMD Size: "..UMD.getSize()/(1024^2).."MB",{1,1})
	end
	if System.powerIsBatteryExist() then
		print2("Battery: "..System.powerGetBatteryLifePercent().."% "..System.powerGetBatteryTemp().."C "..(System.powerGetBatteryVolt()/1000)..'V'.." CS: "..System.powerGetBatteryChargingStatus().." TR: "..System.powerGetBatteryLifeTime()..'m',{1,1})
	end
	if getUser() ~= nil then
		print2("Current logged as: "..getUser(),{1,1})
		print2("REGISTER D/T: "..sysData[envs[1]][11][3],{1,1})
		print2("LOGIN D/T: "..sysData[envs[1]][11][4],{0,1})
	else
		print2('',{1,1})
	end
	musicInfo()
end
addCommand({ "info" })

function ab_lua()
	System.madeby()
end
addCommand({ "lua" })

function ab_sdata()
	local a =
	{
		"*SAVE_DATA",
		"SAVE_NAME",
		"GAME_NAME",
		"DETAILS",
		"ID"
	}
	if isStringForbidden(curcmd[3][1]) then
		return usage()
	end
	for i=1,5 do
		if not isStringForbidden(curcmd[3][i]) then
			curcmd[i] = a[i]
		end
	end
	System.startGameSave(a[1],a[2],a[3],a[4],a[5])
end
addCommand({ "sdata" }, "[SAVE_DATA]~(SAVE_NAME)~(GAME_NAME)~(DETAILS)~(ID)")

function ab_ldata()
	if isStringForbidden(curcmd[1][2]) then
		return usage()
	end
	print2(curcmd[1][2].." DATA: "..System.startGameLoad(curcmd[1][2]))
end
addCommand({ "ldata" }, "[ID]")