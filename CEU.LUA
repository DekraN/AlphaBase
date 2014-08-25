-- CEU.LUA by Wesker aka DekraN for AlphaBase HM7
-- UPDATED at 05/11/09, version 1.0.0


--[[ It finds the given str command and return
its pos in the commands array ]]
function getCmd(str)
	for i=1,#cmd[1] do
		for j=2,#cmd[1][i] do
			if tonumber(str) == i or cmd[1][i][j] == str then
				return i, j
			end
		end
	end
end

-- Commands Elaboration Unit
function sendInput(str, prv)
	edit = 0
	curpos[envs[1]][4] = 1
	-- onUserInput(str)

	if prv == nil then
	    prv = 0
	end

	local w = #sysData[envs[1]][1]

	if isStringForbidden(str) then
		if keyb == 1 and mode == 0 then
			table.remove(sysData[envs[1]][1], w)
		end
		return
	end

	local nstring = split(str, schar)
	local get = #nstring
	if get ~= 1 and prv == 0 then
		for i=1,get do
	    	sendInput(nstring[i])
		end
		return
	end

	curcmd[1] = split(str, ' ')
	curcmd[2] = split(str, curcmd[1][1]..' ')
	curcmd[3] = split(curcmd[2][2], sep)
	curcmd[4] = str
	curcmd[5] = getCmd(curcmd[1][1])

	for i=1,#sysData[envs[1]][8],2 do
		if sysData[envs[1]][8][i] == str then
			if getUser() == nil or sysData[envs[1]][11][2] < sysData[envs[1]][8][i+1] then
				return
				printf("INFO: Invalid or forbidden PERMISSIONS for "..str,{1},sysData[envs[1]][12][2]),
				printf("Required level: "..sysData[envs[1]][8][i+1]..'.',{0,1},sysData[envs[1]][12][2])
			end
			break
		end
	end

	if curcmd[5] ~= nil then
	    loadstring("ab_"..cmd[1][curcmd[5]][2].."()")()
	else
		local c = 0
		for i=2,#sysData[envs[1]][9],2 do
			if str == sysData[envs[1]][9][i] then
				if mode == 1 then
					print2("INPUT: "..sysData[envs[1]][9][i].." OUTPUT: Wait...")
				end
				sendInput(sysData[envs[1]][9][i-1])
				c = c +1
			end
		end
		if c == 0  then
		    if tonumber(str) == nil then
    			print2("INFO: "..(mode == 0 and curcmd[1][1].." is an i" or 'I').."nvalid or unexistant command.",{1})
				print2(mode == 1 and "info: For commandlist, type \"help\" or goto www.psp-ita.com" or '',{ non(mode), 1 })
			else
			    print2("INFO: COMMAND must be an integer between 1 and "..#cmd[1]..'.')
			end
		end
	end

	return 1, restartVars(0)
	-- if the given str command gets no error, then the function returns 1,
	-- according to a good programming style.
end