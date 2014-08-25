-- chunk.lua by Wesker aka DekraN for AlphaBase HM7
-- UPDATED at 09/10/2009, version 1.0.0


function ab_load()
	if isStringForbidden(curcmd[3][1]) then
		if curfile == nil then
			return usage()
		else
			curcmd[3][1] = curfile
		end
	end
	local extensions =
	{
		"ttf", "jpg", "jpeg", "png", "uni",
		"it", "xm", "s3m", "mod", "mtm",
		"stm", "dsm", "med", "far", "ult",
		"669", "wav", "wave", "ogg", "ogm",
		"oga", "ogv", "ogx", "mp3", "aa3"
	}
	local b = ext(curcmd[3][1], extensions, 1)
	local function fixpath(s)
		local a = split(s, '/')
		return a[#a]
	end
	if b == nil then
		local a = isStringForbidden(curcmd[3][2]) and 80 or tonumber(curcmd[3][2])
		if a == nil then
			return print("INFO: PORT must be an integer.")
		end
		local c = isStringForbidden(curcmd[3][3]) and 0 or tonumber(curcmd[3][3])
		if c == nil or (c ~= 0 and c ~= 1) then
			return print2("INFO: MODE must be a boolean value (0 for Normal, 1 for UDP).")
		end
		table.insert(fstor[3],
		{ (c == 0 and Socket.connect(curcmd[3][1], a) or Socket.udpConnect(curcmd[3][1], a)), curcmd[3][1] })
		print2(curcmd[3][1].." successfully loaded.")
	else
		if System.doesFileExist(curcmd[3][1]) == 0 then
			print2("INFO: "..fixString(curcmd[3][1]).." doesnt exist.")
		else
			if b == 1 then
				table.insert(fstor[1],{ Font.load(curcmd[3][1]), fixpath(curcmd[3][1]) })
				if mode == 0 then
		    		fstor[1][#fstor[1]][1]:setPixelSizes(11.5, 11.5)
				end
			elseif b > 1 and b < 5 then
				table.insert(fstor[2],{ Image.load(curcmd[3][1]), fixpath(curcmd[3][1]) })
			elseif b > 4 and b < 19 then
				stopPlay()
				fstor[8] = curcmd[3][1]
			elseif b > 18 and b < 24 then
				stopPlay()
				Ogg.load(curcmd[3][1])
				fstor[5] = curcmd[3][1]
			elseif b == 24 then
				stopPlay()
				if oa == 1 then
					Mp3.load(curcmd[3][1])
				else
					Mp3me.load(curcmd[3][1])
				end
				fstor[6] = curcmd[3][1]
			elseif b == 25 then
				stopPlay()
				Aa3me.load(curcmd[3][1])
				fstor[7] = curcmd[3][1]
			end
			print2(fixString(curcmd[3][1]).." successfully loaded.")
			-- onUserLoad(curcmd[3][1])
		end
	end
end
addCommand({ "load", "connect" }, "[ELEMENT]~(PORT)~(MODE)")

function ab_unload()
	local function unloadItem(id, m)
		if m == nil then
			m = 0
		end
		print2(fstor[m][id][2].." successfully unloaded.")
		if m == 3 then
			fstor[3][id][1]:close()
		end
		table.remove(fstor[m],id)
	end
	if isStringForbidden(curcmd[3][1]) then
		if mode == 0 then
			for i=1,3 do
				for k=1,#fstor[i] do
		        	unloadItem(k, i)
				end
			end
		else
			return usage()
		end
	end
	local function usage2()
		print2("INFO: MODE must be 0 for Fonts, 1 for Images, 2 for Sockets or 3 for Colors.")
	end
	local b = ext(curcmd[3][1],{ "ttf","jpg","jpeg","png" }, 1)
	local c = isStringForbidden(curcmd[3][2]) and 0 or tonumber(curcmd[3][2])
	if c == nil or (c ~= 0 and c ~= 1 and c ~= 2 and c ~= 3) then
		print2("INFO: MODE must be an integer between 0 and 3.")
		if mode == 1 then
			usage2()
		end
	end
	local x = ifind(curcmd[3][1],c +1)
	if x == nil then
		return print2("INFO: NAME/ID not found.")
	end
	if (c == 0 and b ~= 1) or (c == 1 and (b < 2 or b > 4)) then
		return usage2()
	end
	if c == 3 and (x == 1 or x == 2 or x == 3 or x == 4 or x == 5 or x == 6) then
		return print2("INFO: Main Colors cannot be unloaded.")
	end
	if c == 1 and x == mouse[1] then
		mouse[1] = nil
		mouse[2] = false
	end
	unloadItem(x, c +1)
	-- onUserUnload(curcmd[3][1])
end
addCommand({ "unload", "disconnect" }, "[NAME/ID]~(MODE)")

function ab_load2()
	if isStringForbidden(curcmd[3][1]) then
		return usage()
	end
	local a = isStringForbidden(curcmd[3][1]) and 0 or tonumber(curcmd[3][1])
	if a == nil or (a ~= 0 and a ~= 1 and a ~= 2 and a ~= 3) then
		return
		print2("INFO: Invalid MODE. It must be:",{1}),
		print2("0 for an Empty Image, 1 for M.S.F. instance, 2 for P.F. instance, 3 for a color.",{0,1})
	end
	local b = a == 0 and { 0, 0, 0 } or { 255, 255, 255 }
	if not isStringForbidden(curcmd[3][2]) and (a == 0 or a == 3) then
		b = split(curcmd[3][2],',')
		b =
		{
			tonumber(b[1]),
			tonumber(b[2]),
			tonumber(b[3])
		}
		if a == 0 then
			if b[1] == nil or b[2] == nil then
				return print2("INFO: W,H must be float.")
			end
		else
			for i=1,3 do
				if b[i] == nil or b[i] < 0 or b[i] > 255 then
					return print2("INFO: R,G,B must be integers between 0 and 255.")
				end
			end
		end
	end
	if isStringForbidden(curcmd[3][3]) then
		if a == 0 then
			curcmd[3][3] = "Empty Image"
		elseif a == 1 then
			curcmd[3][3] = "Mono Spaced Font"
		elseif a == 2 then
			curcmd[3][3] = "Proportional Font"
		elseif a == 3 then
			curcmd[3][3] = "Color ("..b[1]..','..b[2]..','..b[3]..')'
		end
	end
	if a == 0 then
		table.insert(fstor[2],{ Image.createEmpty(b[1],b[2]), curcmd[3][3] })
	elseif a == 1 then
		table.insert(fstor[1],{ Font.createMonoSpaced(), curcmd[3][3] })
	elseif a == 2 then
		table.insert(fstor[1],{ Font.createProportional(), curcmd[3][3] })
	elseif a == 3 then
		table.insert(fstor[4],{ Color.new(b[1],b[2],b[3]), curcmd[3][3] })
	end
	print2(curcmd[3][3].." successfully loaded.")
	-- onUserLoad(c[a+1])
end
addCommand({ "load2" }, "(MODE)~(X/R, Y/G, /B *ONLY FOR MODE 0 AND 3*)~(NAME)")