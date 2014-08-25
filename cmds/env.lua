-- env.lua by Wesker aka DekraN for AlphaBase HM7
-- UPDATED at 18/10/2009, version 1.0.1


function ab_keyb()
	keyb = non(keyb)
	print2("Keyboard Mode: "..(keyb == 1 and "Danzeff" or "Official")..'.')
end
addCommand({ "keyb" })

function ab_dir()
	if isStringForbidden(curcmd[2][2]) then
		curcmd[2][2] = "ms0:/PSP/GAME/AlphaBase HM7/"
	end
	if System.doesDirExist(curcmd[2][2]) == 0 then
		return print2("INFO: "..fixString(curcmd[2][2]).." doesnt exist.")
	end
	System.currentDirectory(curcmd[2][2])
	print2("Current Directory: "..fixString(System.currentDirectory()),{mode})
	print2((mode == 0 or isStringForbidden(curdir)) and '' or "Init Directory: "..fixString(curdir),{0,1})
end
addCommand({ "dir" }, "(PATH)")

function ab_file()
	if isStringForbidden(curcmd[2][2]) then
		curfile = nil
   		usage()
	else
		if System.doesFileExist(curcmd[2][2]) == 0 then
			return print2("INFO: "..fixString(curcmd[2][2]).." doesnt exist.")
		end
		curfile = curcmd[2][2]
		print2("Current File: "..fixString(curcmd[2][2]))
	end
end
addCommand({ "file" }, "[PATH]")

function ab_get()
	if isStringForbidden(curcmd[2][2]) then
		if mode == 0 then
		    	if isStringForbidden(sysData[envs[1]][10][curpos[envs[1]][8]]) then
		        	usage()
			else
		    		print2(sysData[envs[1]][10][curpos[envs[1]][8]])
			end
		else
			print2(sysData[envs[1]][10][curpos[envs[1]][8]])
		end
		return
	end
	local a = tonumber(curcmd[2][2])
	if a == nil then
		for i=1,#sysData[envs[1]][10] do
			if curcmd[2][2] == sysData[envs[1]][10][i] then
				if mode == 0 then
					curpos[envs[1]][8] = i
				else
					print2("INFO: "..curcmd[2][2].." already exists in the snaplist.")
				end
				return sendInput("get")
			end
		end
		print2("Successfully got the string: "..curcmd[2][2])
		table.insert(sysData[envs[2]][10], curcmd[2][2])
		curpos[envs[1]][8] = #sysData[envs[1]][10]
	else
		if a < 1 or a > #sysData[envs[1]][10] then
			return print2("INFO: Snapshot string not found in this position.")
		end
		curpos[envs[1]][8] = a
	end
	sendInput(mode == 0 and "get" or '')
end
addCommand({ "get" }, "(STRING)~(POS)")

function ab_unget()
	local a = isStringForbidden(curcmd[3][1]) and curpos[envs[1]][8] or tonumber(curcmd[3][1])
	if a == nil then
		for i=1,#sysData[envs[1]][10] do
			if curcmd[3][1] == sysData[envs[1]][10][i] then
		            a = i
			end
		end
	else
		if a < 1 or a > #sysData[envs[1]][10] then
			return print2("INFO: Snapshot string not found in this position.")
		end
	end
	if isStringForbidden(curcmd[3][2]) then
		print2("Successfully removed the snapshot string in pos No. "..a..'.',{non(mode)})
		print2("OLD: "..sysData[envs[1]][10][a]..'.',{0,1})
		table.remove(sysData[envs[1]][10], a)
		if mode == 0 then
			curpos[envs[1]][8] = #sysData[envs[1]][10]
		end
	else
		print2("Successfully replaced the snapshot string in pos No. "..a..'.',{non(mode)})
		print2(mode == 0 and '' or "OLD: "..sysData[envs[1]][10][a]..", NEW: "..curcmd[3][2]..'.',{0,1})
		sysData[envs[1]][10][a] = curcmd[3][2]
	end
end
addCommand({ "unget" }, "(STRING/POS)~(STRING2)")

function ab_find()
	if isStringForbidden(curcmd[3][1]) then
		return usage()
	end
	local function usage2()
		print2("INFO: MODE must be 0 for Fonts, 1 for Images, 2 for Sockets or 3 for Colors.")
	end
 	local a = isStringForbidden(curcmd[3][2]) and 0 or tonumber(curcmd[3][2])
 	if a == nil or (a ~= 0 and a ~= 1) then
 		return print2("INFO: MODE must be a boolean value (0 for itemlist search, 1 for macrolist search).")
	end
	local b = isStringForbidden(curcmd[3][3]) and 0 or tonumber(curcmd[3][3])
	if b == nil or (not isStringForbidden(curcmd[3][3]) and a == 1) then
		return print2("INFO: MODE2 must be 0 for Fonts, 1 for Images, 2 for Sockets or 3 for Colors.")
	end
	local c = a == 0 and ifind(curcmd[3][1], b +1) or getCmd(curcmd[3][1])
  	print2(curcmd[3][1]..' '..(c == nil and "doesnt exist" or "exists").." in the "..(a == 0 and "itemlist" or "macrolist")..'.')
end
addCommand({ "find" }, "[ELEMENT]~(MODE)~(MODE2)")

function ab_key()
	if isStringForbidden(curcmd[3][2]) then
	        return usage()
	end
	local a =
	{
		"Circle",
		"Triangle",
		"Square",
		"Home",
		"Start",
		"Select",
		"R",
		"L"
	}
	local b = 1
	for i=1,8 do
		if curcmd[3][1] == a[i] or tonumber(curcmd[3][1]) == i -1 then
			b = i
			break
		end
		if i == 8 then
			return
			print2("INFO: Invalid KEY. It must be:",{1}),
			print2(table.concat(a,", ")..'.',{0,1})
		end
	end
	local x = split(curcmd[2][2], curcmd[3][1]..sep)
	loadstring(a[b].." = \""..x[2].."\"")()
	print2("Successfully "..a[b].." keybinded.",{1})
	print2(mode == 0 and '' or "as INPUT: "..curcmd[3][1],{non(mode),1})
end
addCommand({ "key" }, "(KEY)~[INPUT]")

function ab_slist()
	local b = isStringForbidden(curcmd[3][1]) and 0 or tonumber(curcmd[3][1])
	if b == nil or (b ~= 0 and b ~= 1 and b ~= 2) then
		return
		print2("INFO: Invalid MODE. It must be:",{1}),
		print2("0 for Markerslist, 1 for Cmdlist, 2 for Poslist.",{1,1}),
		usage({0,1})
	end
	if isStringForbidden(curcmd[3][2]) then
		curcmd[3][2] = files[12][b+1]
	end
  	local a = ext(curcmd[3][2],{ "lua","txt","ini","dat" })
	if a == nil then
		return
	end
	if type(a) ~= 'number' then
		if mode == 0 then
			curcmd[3][2] = a
		else
			return
			print2("INFO: NO-Extension Proof System actually doesnt work.",{1}),
			usage({0,1})
		end
	end
	if System.doesFileExist(curcmd[3][2]) == 0 then
		return
		print2("INFO: "..fixString(curcmd[3][1]).." doesnt exist.",{1}),
		usage({0,1})
	end
	local c =
	{
		"Markers",
		"Cmd",
		"Pos"
	}
	sysData[envs[1]][12][b+1] = curcmd[3][2]
	print2("Successfully set: "..fixString(curcmd[3][2]).." as "..c[b+1].."list.")
end
addCommand({ "slist" }, "(MODE)~[PATH]")

function ab_env()
	if isStringForbidden(curcmd[3][1]) then
	    	if mode == 1 then
	    		usage()
	    	end
		return prog:showData()
	end
	local a = isStringForbidden(curcmd[3][2]) and 0 or tonumber(curcmd[3][2])
	if a == 0 then
		prog:setProgram(curcmd[3][1])
		print2("info: PROGRAM NAME: "..curcmd[3][1])
	elseif a == 1 then
		prog:setAuthor(curcmd[3][1])
		print2("info: AUTHOR NAME: "..curcmd[3][1])
	elseif a == 2 then
		prog:setVersion(curcmd[3][1])
		print2("info: BUILT VERSION: "..curcmd[3][1])
	else
		print2("INFO: MODE must be 0 for Program Name, 1 for Author, 2 for Version.")
	end
end
addCommand({ "env" }, "[STRING]~(MODE)")

function ab_envs()
	local a = not isStringForbidden(curcmd[2][2]) and ifind(curcmd[2][2],nil,0) or nil
	if a == nil then
		if #sysData +1 > max_env then
			return print2("INFO: Cannot create more environment.")
		end
	       	print2("Successfully created a new environment.",{mode})
	      	addEnv(curcmd[2][2])
	       	envs[1] = #sysData
		if mode == 1 then
			if not isStringForbidden(curcmd[2][2]) then
			    print2("NAME: "..curcmd[2][2],{0,1})
			end
		else
			envs[2] = envs[1]
			setupFor(1)
		end
	else
		if a < 1 or a == envs[1] or (mode == 1 and (a == envs[2] or a > max_env)) then
			return print2("INFO: Invalid or forbidden Environment.")
		end
		remEnv(a, 0)
		print2("Successfully removed the "..curcmd[2][2].." environment.")
	end
end
addCommand({ "envs" }, "(ENV/ID)")

function ab_cenv()
	local a = isStringForbidden(curcmd[3][1]) and (mode == 0 and #sysData or 1) or ifind(curcmd[3][1],nil,0)
	if a == nil then
		return
		print2("INFO: ENV/ID not found.",{1}),
		usage({0,1})
	end
	local b = isStringForbidden(curcmd[3][2]) and 0 or tonumber(curcmd[3][2])
	if b == nil or (b ~= 0 and b ~= 1) then
		return
		print2("INFO: MODE must be a boolean value (0 for C.E., 1 for W.E.).",{1}),
		usage({0,1})
	end
	envs[b+1] = a
	if b == 0 then
		envs[2] = a
	end
	if mode == 1 then
		print2("Successfully set the "..(b == 0 and "Current" or "Working").." Environment as: "
		..(#sysData[envs[b+1]] == 13 and sysData[envs[b+1]][13] or '')..'('..envs[b+1]..").")
	end
end
addCommand({ "cenv" }, "(ENV/ID)~(MODE)")

function ab_menv()
	if isStringForbidden(curcmd[1][2]) then
		return usage()
	end
	local a = tonumber(curcmd[1][2])
	if a == nil or a < 1 then
		return print2("INFO: MAX must be an integer > than 0.")
	end
	max_env = a
	print2("Max Environments Value set to: "..a..'.')
end
addCommand({ "menv" }, "(MAX)")

function ab_col()
	local a = isStringForbidden(curcmd[3][1]) and 0 or tonumber(curcmd[3][1])
	if a == nil or (a ~= 0 and a ~= 1) then
		return print2("INFO: MODE must be a boolean value (0 for syscol, 1 for clearcol).")
	end
	local b = isStringForbidden(curcmd[3][2]) and (a == 0 and 1 or 2) or ifind(curcmd[3][2], 4)
	if b == nil then
		return print2("INFO: COLOR/ID not found.")
	end
	print2("Successfully colorset: "..fstor[4][b][2])
	fstor[4][a+1][1] = fstor[4][b][1]
end
addCommand({ "col" }, "(MODE)~(COLOR/ID)")

-- USAGE: (LINE)
function ab_goto()
	local a = isStringForbidden(curcmd[3][1]) and 1 or getLine(curcmd[3][1])
	if a == nil then
		return
	end
	if #sysData[envs[1]][1] < 28 and mode == 0 then
		return print2("INFO: Cannot line-goto because it's unnecessary.")
	end
	curpos[envs[1]][2] = a
end
addCommand({ "goto" }, "(LINE)")

function ab_hlpr()
	local b = getHelper()
	local s = { }
	print2("HELPER VARS:")
	local a = isStringForbidden(curcmd[1][2]) and -1 or tonumber(curcmd[1][2])
	if a == nil or (a ~= -1 and a ~= 0 and a ~= 1) then
		return print2("INFO: MODE must be a boolean value (0 for Normal H.V., 1 for SETTINGS.ini H.V.).")
	end
	local n, m = a == 0 and 29 or 1, a == 1 and 28 or #b
	for i=n,m do
		table.insert(s, "printf(\"- "..b[i].." = \"..(("..b[i]..") == nil and 'nil' or "..b[i].."),{"..(i == m and '0' or '1')..",1},\"HELPER\")")
	end
	local old = mode
	mode = 0
	loadstring(table.concat(s))()
	mode = old
end
addCommand({ "hlpr" }, "(MODE)")

function ab_usage()
	if isStringForbidden(curcmd[2][2]) then
		return usage()
	end
	local a = getCmd(curcmd[2][2])
  	if a == nil then
		return print2("INFO: CMD not found into macrolist.")
	end
	sendInput(cmd[1][a][2])
end
addCommand({ "usage" },"(CMD)")

function ab_mode()
	mode = non(mode)
	print2((mode == 0 and "Normal" or "Extended").." mode successfully set.")
end
addCommand({ "mode" })

function ab_dbg()
	printf("info: Debug Processing (auto linelinking and hlpr vars nilcheck);",{1},"DEBUG")
	printf("info: P.M. is automatically managed while debugging.",{0,1},"DEBUG")
	local old = mode
	mode = 1
	sendInput("goto "..(mode == 0 and #sysData[envs[1]][1] or 1))
	print2('',{0,1},"NULL")
	mode = old
	local a = getHelper()
	local s = { }
	local b = #a
	for i=29,b do
		table.insert(s, "if "..a[i].." == nil then printf(\"WARNING: The "..a[i].." var is nil.\",{"..(i==b and '0' or '1')..",1},\"D/H\") end ")
	end
	local old = mode
		mode = 0
	loadstring(table.concat(s))()
	mode = old
	if (getUser() == nil and (sysData[envs[1]][11][2] ~= nil or sysData[envs[1]][11][3] ~= nil or sysData[envs[1]][11][4] ~= nil))
	or (getUser() ~= nil and (sysData[envs[1]][11][2] == nil or sysData[envs[1]][11][3] == nil or sysData[envs[1]][11][4] == nil)) then
		sysData[envs[1]][11] = { }
		print2("Successfully restored the User Data.")
	end
end
addCommand({ "dbg" })

-- assure cpu speed is 333
function ab_hlp()
	local a = isStringForbidden(curcmd[1][2]) and 0 or tonumber(curcmd[1][2])
    if a == nil or (a ~= 0 and a ~= 1) then
    	return
		print2("INFO: MODE must be a boolean value (0 for Commands, 1 for Functions).",{1}),
		usage({0,1})
    end
 	print2((a == 0 and "COMMANDS" or "FUNCTIONS").." LIST:")
	if mode == 0 then
		local function tab(t, group)
			local m = #t
			if m < 1 then
				return
			end
			local function rst(v,v2)
				return v - math.floor(v/v2)*v2
			end
			local d = { }
			for i=1,m do
				local s = split(t[i],' ')
				table.insert(d, s[1])
			end
			local n = #d
			if rst(n,group) ~= 0 then
				while rst(n,group) ~= 0 do
					table.insert(d,'')
					n = #d
				end
			end
			local g = { }
			for i=1,n,group do
				table.insert(g,{ })
				for k=i,(i+group)-1 do
					if not isStringForbidden(d[k]) then
						table.insert(g[#g], d[k])
					end
				end
			end
			local tab = #g
			for i=1,tab do
				local s = ''
				local tab2 = #g[i]
				for x=1,tab2 do
					s = s..g[i][x]..((i == tab and x == tab2) and '.' or ", ")
				end
				printf(s,{ i == tab and 0 or 1 })
			end
		end
		if a == 0 then
			local b = { }
			for i=1,#cmd[1] do
				table.insert(b, cmd[1][i][2])
			end
			tab(b, 8)
		else
 	    	tab(cmd[2], 3)
 	    end
	else
		local n = #cmd[a+1]
   		for i=1,n do
   			if a == 0 then
   				print2("- "..cmd[1][i][2]..' '..cmd[1][i][1]..(i == n and '.' or ','),{ i == n and 0 or 1, 1 })
   			else
				print2("- "..cmd[2][i]..(i == n and '.' or ','),{ i == n and 0 or 1, 1 })
			end
		end
	end
end
addCommand({ "hlp" }, "(MODE)")

function ab_cred()
	prog:showData()
	print2("thanks to Homemister and PiCkDaT for LUAPlayer HM7,",{1,1})
	print2("thanks to Danzel for the Danzeff Keyboard, and",{1,1})
	print2("thanks to www.psp-ita.com for support and tutorials.",{1,1})
	print2("contact me at marco_chiarelli[NOSPAM]yahoo.it or at:",{1,1})
	print2("marco.chiarelli[NOSPAM]hotmail.it for anything and",{1,1})
	print2("also for fix your scripts! Regards, Wesker.",{0,1})
end
addCommand({ "cred" })