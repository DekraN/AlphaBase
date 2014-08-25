-- users.lua by Wesker aka DekraN for AlphaBase HM7
-- UPDATED at 09/10/2009, version 1.0.0


function ab_reg()
	if isStringForbidden(curcmd[3][1]) then
		return usage()
	end
	local fl = System.listDirectory("ms0:/PSP/GAME/AlphaBase HM7/users/")
	for i,v in pairs(fl) do
		if v.name == curcmd[3][1]..".usr" then
			return print2("INFO: "..curcmd[3][1].." already exists as NICKNAME.")
		end
	end
	if curcmd[3][2]:len() < 4 or curcmd[3][2]:len() > 8 then
		return print2("INFO: PASSWORD length must be between 4 and 8.")
	end
	if mode == 0 then
		if isStringForbidden(curcmd[3][3]) then
		    return usage()
		end
		if curcmd[3][2] ~= curcmd[3][3] then
		    return print2("INFO: PASSWORD and PASSWORD dont match.")
		end
	end
	local f = io.open("users/"..curcmd[3][1]..".usr",'w')
	f:write(curcmd[3][2]..fsep..level..fsep..System.getDate(3)..'/'..System.getDate(2)..'/'..System.getDate(1)..' '
	..System.getTime(1)..':'..System.getTime(2)..':'..System.getTime(3)
	..':'..System.getTime(4)..' '..System.getTime(5))
	f:flush()
	f:close()
	print2("Successfully created a new account.",{1})
	print2("NICKNAME: "..curcmd[3][1].." PASSWORD: "..fixString(curcmd[3][2],1),{0,1})
	if mode == 0 then
		sendInput("log "..curcmd[3][1]..sep..curcmd[3][2]..sep..(isStringForbidden(curcmd[3][3]) and '' or curcmd[3][3]))
	end
	-- onUserRegister()
end
addCommand({ "reg" }, "[NICKNAME]~[PASSWORD]~(PASSWORD)")

function ab_log()
	if getUser() ~= nil then
		print2("Successfully unlogged as: "..getUser())
		sysData[envs[1]][11] = { }
		-- onUserLogout()
		return
	end
	if isStringForbidden(curcmd[3][1]) then
		return usage()
	end
	if checkUsers(curcmd[3][1]) == 0 then
 		return print2("INFO: "..curcmd[3][1].." doesnt exist as NICKNAME.")
	end
	local f = io.open("users/"..curcmd[3][1]..".usr",'r')
	local c = split(f:read("*l"), fsep)
	if #c ~= 3 then
		local d = split(c[4], ',')
		print2("INFO: Invalid or isStringForbidden PERMISSIONS to login.",{mode})
		print2((mode == 0 or isStringForbidden(d[2])) and '' or d[2],{1,1})
		if tonumber(d[1]) == 1 then
			sendInput("shutdown")
		end
		return
	end
	if c[1] ~= curcmd[3][2] then
		return print2("INFO: Invalid or isStringForbidden PASSWORD.")
	end
	sysData[envs[1]][11] =
	{
		curcmd[3][1],
		tonumber(c[2]),
		c[3],
		System.getDate(3)..'/'..System.getDate(2)..'/'..System.getDate(1)..' '
		..System.getTime(1)..':'..System.getTime(2)..':'..System.getTime(3)
		..':'..System.getTime(4)..' '..System.getTime(5)
	}
	f:close()
	print2("Successfully logged as: "..curcmd[3][1])
	-- onUserLogin()
end
addCommand({ "log" }, "[NICKNAME]~[PASSWORD]")

function ab_lvl()
	if access(0, curcmd[1][1]) == -1 then
		return
	end
	if isStringForbidden(curcmd[1][2]) then
		local fl = System.listDirectory("users/")
		print2("USERS LEVELS:")
		for i, v in ipairs(fl) do
			if v.name ~= '' and v.name ~= '.' and v.name ~= ".." then
				local nick = v.name:sub(1,-5)
				print2(nick..": "..getLvl(nick),{ 1, 1 })
			end
		end
		return print2(mode == 0 and '' or "Default: "..level..", Max: "..getMaxLvl()..'.',{non(mode),1})
	end
	local a = tonumber(curcmd[1][2])
	local b = getMaxLvl()
	if a == nil or a < 0 or a > b then
		return
    		usage({1}),
		print2("INFO: LEVEL must be an integer between 0 and "..b..'.',{0,1})
	end
	level = a
	print2("Successfully levelset: "..a)
end
addCommand({ "lvl" }, "(LEVEL)")

function ab_slvl()
	if access(0, curcmd[1][1]) == -1 then
	    	return
	end
	if isStringForbidden(curcmd[3][1]) then
		return usage()
	end
	if checkUsers(curcmd[3][1]) == 0 then
		return print2("INFO: "..curcmd[3][1].." doesnt exist as NICKNAME.",{1})
	end
	if mode == 0 and isAdmin(curcmd[3][1]) then
		return
		print2("INFO: Cannot do this to an admin profile.",{1})
	end
	local e = isStringForbidden(curcmd[3][2]) and level or tonumber(curcmd[3][2])
	if e == nil then
		return
		print2("INFO: LEVEL must be an integer.",{1})
	end
	local f = io.open("users/"..curcmd[3][1]..".usr",'r')
	local d = split(f:read("*l"), fsep)
	f:close()
	f = io.open("users/"..curcmd[3][1]..".usr",'w')
	if #d == 3 then
		f:write(d[1]..fsep..e..fsep..d[3])
	else
		f:write(d[1]..fsep..e..fsep..d[3]..fsep..d[4])
	end
	f:close()
	print2("Successfully "..curcmd[3][1].."'s profile levelset:",{1})
	print2("OLD: "..d[2].." NEW: "..e,{1,1})
end
addCommand({ "slvl" }, "[NICKNAME]~(LEVEL)")

function ab_susp()
	if access(0, curcmd[1][1]) == -1 then
		return
	end
	if isStringForbidden(curcmd[3][1]) then
		local fl = System.listDirectory("users/")
		if mode == 0 then
			print2("USERS BAN-LIST:")
			for i, v in ipairs(fl) do
				if v.name ~= '' and v.name ~= '.' and v.name ~= ".." then
					local f = io.open("users/"..v.name,'r')
					local a = split(f:read("*l"), fsep)
					f:close()
					if not isStringForbidden(a[4]) then
						local b = split(a[4], ',')
						print2(v.name:sub(1,-5)..';',{1,1})
						print2("MODE: "..(tonumber(b[1]) == 0 and "Advise Only" or "Kicking User")..
						(isStringForbidden(b[2]) and '' or "REASON: "..b[2]),{1,1})
					end
				end
			end
		else
			usage()
		end
		return
	end
	if mode == 0 and isAdmin(curcmd[3][1]) then
		return print2("INFO: Cannot do this to an admin profile.")
	end
	local c = isStringForbidden(curcmd[3][2]) and mode or tonumber(curcmd[3][2])
	if c == nil or (c ~= 0 and c ~= 1) then
		return print2("INFO: MODE must be a boolean value (0 for advise only, 1 for kicking user).")
	end
	local b = isStringForbidden(curcmd[3][3]) and '' or curcmd[3][3]
	local f = io.open("users/"..curcmd[3][1]..".usr",'r')
	local a = split(f:read("*l"), fsep)
	f:close()
	f = io.open("users/"..curcmd[3][1]..".usr",'w')
	if #a == 3 then
		f:write(a[1]..fsep..a[2]..fsep..a[3]..fsep..c..','..b)
		print2("Successfully suspended the "..curcmd[3][1].."'s profile:",{1})
		print2((isStringForbidden(b) and '' or "REASON: "..b..", ").."MODE: "..(c == 0 and "advise only" or "kicking user")..'.')
	else
		f:write(a[1]..fsep..a[2]..fsep..a[3])
		print2("Successfully removed the suspension to: "..curcmd[3][1].."'s profile.")
	end
	f:close()
end
addCommand({ "susp" }, "[NICKNAME]~(MODE)~(STRING)")

function ab_adm()
	if isStringForbidden(curcmd[2][2]) then
	        if mode == 0 then
	        	local fl = System.listDirectory("users/")
			print2("USERS ADMINS:")
			for i, v in ipairs(fl) do
				if v.name ~= '' and v.name ~= '.' and v.name ~= ".." then
					local nick = v.name:sub(1,-5)
					if isAdmin(nick) then
						print2(nick..(i == #fl and '.' or ';'), {1,1})
					end
				end
			end
		else
			usage()
		end
		return
	end
	sendInput("slvl "..curcmd[2][2]..fsep..getMaxLvl())
end
addCommand({ "adm" }, "[NICKNAME]")

-- USAGE: [OLDPASS]~[PASSWORD]~(PASSWORD)
function ab_pass()
	if getUser() == nil then
	        return print2("INFO: Must be logged to do this.")
	end
	if isStringForbidden(curcmd[3][1]) then
		return usage()
	end
	local f = io.open("users/"..getUser()..".usr",'r')
	local a = split(f:read("*l"), fsep)
	f:close()
	if a[1] ~= curcmd[3][1] then
		return print2("INFO: Invalid or forbidden OLDPASS.")
	end
	if curcmd[3][2]:len() < 4 or curcmd[3][2]:len() > 8 then
		return print2("INFO: PASSWORD length must be between 4 and 8.")
	end
	if mode == 0 then
		if isStringForbidden(curcmd[3][3]) then
			usage()
		end
		if curcmd[3][2] ~= curcmd[3][3] then
  			return print2("INFO: PASSWORD and PASSWORD dont match.")
		end
	end
	f = io.open("users/"..getUser()..".usr",'w')
	f:write(curcmd[3][2]..fsep..a[2]..fsep..a[3])
	f:close()
	print2("Successfully "..getUser().."'s profile pass-set:",{1})
	print2("OLD: "..fixString(a[1],1).." NEW: "..fixString(curcmd[3][2],1))
end
addCommand({ "pass" }, "[OLDPASS]~[PASSWORD]~(PASSWORD)")