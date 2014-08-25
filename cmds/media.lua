-- media.lua by Wesker aka DekraN for AlphaBase HM7
-- UPDATED at 09/10/2009, version 1.0.0


function ab_play()
	if isStringForbidden(curcmd[1][2]) then
		local x =
		{
			"paused",
			"resumed",
			"paused",
			"resumed",
			"paused",
			"resumed",
			"paused",
			"resumed"
		}
		if mediaData[1] == -2 then
    			usage()
		else
			if mediaData[1] == -1 then
				mediaData[1] = 0
				Music.resume()
			elseif mediaData[1] == 0 then
				mediaData[1] = -1
				Music.pause()
			elseif mediaData[1] == 1 then
				mediaData[1] = 2
				Ogg.pause()
			elseif mediaData[1] == 2 then
				mediaData[1] = 1
				Ogg.pause()
			elseif mediaData[1] == 3 then
				if oa == 1 then
					return print2("INFO: OA must be disabled.")
				end
				mediaData[1] = 4
				Aa3me.pause()
			elseif mediaData[1] == 4 then
				if oa == 1 then
					return print2("INFO: OA must be disabled.")
				end
				mediaData[1] = 3
				Aa3me.pause()
			elseif mediaData[1] == 5 then
				mediaData[1] = 6
				if oa == 1 then
					Mp3.pause()
				else
					Mp3me.pause()
				end
			elseif mediaData[1] == 6 then
				mediaData[1] = 5
				if oa == 1 then
					Mp3.pause()
				else
					Mp3me.pause()
				end
			end
			print2(fixString(mediaData[2]).." successfully "..x[mediaData[1]+2]..'.')
		end
	else
		if curpos[envs[1]][1] ~= 0 then
			if mode == 0 then
				stopList()
			else
				return print2("INFO: "..fixString(mediaData[3]).." is already playing.")
			end
		end
		if sysData[envs[1]][8][1] ~= -2 then
			if mode == 0 then
				stopPlay()
			else
				return print2(mediaData[2].." is already playing.")
			end
		end
		local a = tonumber(curcmd[1][2])
		if a == nil or (a ~= 0 and a ~= 1 and a ~= 2 and a ~= 3) then
			return print2("INFO: MODE must be 0 for Ogg, 1 for Mp3, 2 for Aa3 or 3 for other formats.")
		end
		if fstor[a+5] == nil then
			return print2("INFO: No Music currently loaded in this format.")
		end
		local b = isStringForbidden(curcmd[1][3]) and 0 or tonumber(curcmd[1][3])
		if b == nil or (b ~= 0 and b ~= 1) then
			return print2("INFO: MODE must be a boolean value (0 for null, 1 for repeat).")
		end
		local c =
		{
			"Off",
			"On"
		}
		if a == 0 then
			Ogg.play()
			if b == 1 then
				Ogg.mode()
			end
			mediaData =
			{
				2,
				fstor[5]
			}
		elseif a == 1 then
			if oa == 1 then
				Mp3.play()
				if b == 1 then
					Mp3.mode()
				end
			else
				Mp3me.play()
				if b == 1 then
					Mp3me.mode()
				end
			end
			mediaData =
			{
				6,
				fstor[6]
			}
		elseif a == 2 then
			if oa == 1 then
				return print2("INFO: OA must be disabled.")
			end
			Aa3me.play()
			if b == 1 then
				Aa3me.mode()
			end
			mediaData =
			{
				4,
				fstor[7]
			}
		elseif a == 3 then
			if oa == 0 then
				return print2("INFO: OA must be enabled.")
			end
			if b == 0 then
				b = false
			else
				b = true
			end
			Music.stop()
			Music.play(fstor[8],b)
			mediaData =
			{
				0,
				fstor[8]
			}
		end
		print2("Successfully playing: "..mediaData[2])
		musicInfo()
		-- onUserPlay(mediaData[2])
	end
end
addCommand({ "play" }, "(MODE) (MODE2)")

function ab_play2()
	if isStringForbidden(curcmd[3][1]) then
		return usage()
	end
	local extensions =
	{
		"uni", "it", "xm", "s3m", "mod",
		"mtm", "stm", "dsm", "med", "far",
		"ult", "669", "wav", "wave", "ogg",
		"ogm", "oga", "ogv", "ogx", "mp3", "aa3"
	}
	local a = ext(curcmd[3][1], extensions)
 	if type(a) ~= 'number' then
	    return
	end
	local b = 0
	if a > 0 and a < 15 then
		b = 3
	elseif a == 20 then
		b = 1
	elseif a == 21 then
		b = 2
	end
	local c = isStringForbidden(curcmd[3][2]) and 0 or tonumber(curcmd[3][2])
	if c == nil or (c ~= 0 and c ~= 1) then
		return print2("INFO: MODE must be a boolean value (0 for null, 1 for repeat).")
	end
	if fstor[b+5] ~= curcmd[3][1] then
		sendInput("load "..curcmd[3][1])
	end
	if System.doesFileExist(curcmd[3][1]) ~= 0 then
		sendInput("play "..b..' '..c)
	end
end
addCommand({ "play2" }, "[PATH]~(MODE)")

function ab_stop()
	if mediaData[1] == -2 then
		return print2("INFO: No music currently playing.")
	end
	-- onUserStop(mediaData[2])
	if curpos[envs[1]][1] == 0 then
		stopPlay()
	else
		stopList()
	end
	print2(fixString(mediaData[2]).." successfully stopped.")
end
addCommand({ "stop" })

function ab_plist()
	if mediaData[1] ~= -2 then
		if mode == 1 then
			stopPlay()
		else
			return print2("INFO: Music is currently playing.")
		end
	end
	if curpos[envs[1]][1] == 0 then
		if isStringForbidden(curcmd[2][2]) then
			curcmd[2][2] = "aufs/a-list.auf"
		end
		local x = ext(curcmd[2][2],{ "auf","lua","txt","dat","ini" })
        	if x == nil then
		    	return
		end
		if type(x) ~= 'number' then
			if mode == 0 then
			    curcmd[2][2] = x
			else
			    return print2("INFO: NO-Extension Proof System actually doesnt work.")
			end
		end
		if System.doesFileExist(curcmd[2][2]) == 0 then
			   return print2("INFO: "..fixString(curcmd[2][2]).." doesnt exist.")
		end
		local f = io.open(curcmd[2][2],'r')
		local a = f:read("*l")
		local b = split(a, fsep)
		local m = #b
		if m == 1 then
			return print2("INFO: Invalid output (a-pl.auf is corrupted).")
		end
		local d = { }
		for i=1,m do
			table.insert(d, b[i])
		end
		f:close()
		curpos[envs[1]][1] = 1
		mediaData[2] = ''
		mediaData[3] = curcmd[2][2]
		for i=1,#d do
			table.insert(mediaData, d[i])
		end
		print2(fixString(mediaData[3]).." successfully started.")
		playList()
	else
		stopList()
	end
end
addCommand({ "plist" }, "(PATH)")

function ab_mlist()
	if isStringForbidden(curcmd[3][1]) then
		return usage()
	end
	local a = ext(curcmd[3][1],{ "auf","lua","txt","dat","ini" })
	if a == nil then
		return
	end
	if type(a) ~= 'number' then
		if mode == 0 then
			curcmd[3][1] = a
		else
			return print2("INFO: NO-Extension Proof System actually doesnt work.")
		end
	end
	if System.doesFileExist(curcmd[3][1]) == 0 then
		return print2("INFO: "..fixString(curcmd[3][1]).." doesnt exist.")
	end
	local b = isStringForbidden(curcmd[3][2]) and 1 or tonumber(curcmd[3][2])
	if b == nil or (b ~= 0 and b ~= 1 and b ~= 2 and b ~= 3) then
		return print2("INFO: MODE must be 0 for Ogg, 1 for Mp3, 2 for Aa3 or 3 for other formats.")
	end
	if fstor[b+5] == nil then
		return print2("INFO: No Music currently loaded in this format.")
	end
	sendInput("write "..curcmd[3][1]..fsep..fstor[b+5]..fsep)
end
addCommand({ "mlist" }, "[PATH]~(MODE)")