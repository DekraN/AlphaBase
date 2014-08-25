-- a-utils.lua by Wesker aka DekraN for AlphaBase HM7
-- UPDATED at 07/10/2009, version 1.0.0.


-- It restarts the main vars and refresh the macrolist
function restartVars(m)
	if m == nil then
		return
		restartVars(0),
		restartVars(1)
	end
	if m == 0 then
		curpos[envs[1]][5] = 1
		curpos[envs[1]][6] = 1
		curpos[envs[1]][7] = 28
	else
	    for i, v in ipairs(System.listDirectory("cmds/")) do
	        if v.name ~= '' and v.name ~= '.' and v.name ~= ".." then
	            dofile("cmds/"..v.name)
			end
		end
	end
end

function explode(d,p)
  local t, ll
  t={ }
  ll=0
  if(#p == 1) then
  	return p
  end
    while 1 do
      l=string.find(p,d,ll+1,true) -- find the next d in the string
      if l~=nil then -- if "not not" found then..
        table.insert(t, string.sub(p,ll,l-1)) -- Save it in our array.
        ll=l+1 -- save just after where we found it for searching next time.
      else
        table.insert(t, string.sub(p,ll)) -- Save what's left in our array.
        break -- Break at end, as it should be, according to the lua manual.
      end
    end
  return t
end

function split(str, delim, maxNb)
    -- Eliminate bad cases...
    if str == nil then
		return { }
	end
    if string.find(str, delim) == nil then
        return { str }
	end
    if maxNb == nil or maxNb < 1 then
        maxNb = 0    -- No limit
    end
    local result = { }
    local pat = "(.-)" .. delim .. "()"
    local nb = 0
    local lastPos
    for part, pos in string.gfind(str, pat) do
        nb = nb + 1
        result[nb] = part
        lastPos = pos
        if nb == maxNb then
			break
		end
    end
    -- Handle the last field
    if nb ~= maxNb then
        result[nb + 1] = string.sub(str, lastPos)
    end
    return result
end

function addEnv(str)
	local default_env =
	{
		{ },
		{ },
		{ },
		{ },
		{ },
		{ },
		{ },
		{ },
		{ },
		{ },
		{ },
		files
	}
	local default_pos =
	{
		0,
		1,
		1,
		0
	}
	table.insert(sysData, default_env)
	table.insert(curpos, default_pos)
	if not isStringForbidden(str) then
		table.insert(sysData[#sysData], str)
	end
end

function remEnv(env)
	table.remove(sysData, env)
end

function addCommand(str, str2)
	if isStringForbidden(str2) then
	    str2 = ''
	else
	    str2 = str2:gsub('~', sep)
	end
	table.insert(cmd[1], { str2 })
	for i=1,#str do
	    table.insert(cmd[1][#cmd[1]], str[i])
	end
end

function isStringForbidden(str)
	return str == nil or str == ' ' or str == ''
end

function parse(v)
	return tonumber(v) == nil and "nan" or v
end

function maxmin( t )
  local max = -math.huge
  local min = math.huge

  for k,v in pairs( t ) do
    if type(v) == 'number' then
      max = math.max( max, v )
      min = math.min( min, v )
    end
  end

  return max, min
end

function isForbiddenImage(str)
	local a = ext(str, { "jpg", "jpeg", "png" }, 1)
	if type(a) ~= 'number' then
    	return
		1,
		print2("INFO: Invalid format. Only JPEG and PNG are allowed.")
	end
end

function fixLastChar(str, m)
	return m == nil and (str:sub(-1,-1) == '/' and str:sub(1,-2) or str)
	or (str:sub(-1,-1) ~= '/' and str..'/' or str)
end

function fixString(str, m)
   if m == nil then
      m = 0
   end
   str = fixLastChar(str)
   local a = str
   if mode == 0 then
      if m == 0 then
         local b = split(str,'/')
		 a = b[#b]
      else
         local x = ''
         for i = 1,string.len(a) do
            x = x..'*'
         end
      	 a = x
      end
   end
   return a
end

function stopPlay()
   if mediaData[1] == -1 or mediaData[1] == 0 then
      Music.stop()
   elseif mediaData[1] == 1 or mediaData[1] == 2 then
      Ogg.stop()
   elseif mediaData[1] == 3 or mediaData[1] == 4 then
      if me ~= 0 then
         Aa3me.stop()
      end
   elseif mediaData[1] == 5 or mediaData[1] == 6 then
      if me == 0 then
	     Mp3.stop()
	  else
	     Mp3me.stop()
      end
   end
   mediaData[1] = -2
end

function access(m, str)
	if m == nil then
		m = 1
	end
	local c = getMaxLvl()
	if getUser() == nil or sysData[envs[1]][11][2] < c then
		if m ~= 1 then
			printf("INFO: Invalid or forbidden PERMISSIONS for: "..str,{1},"a-base.lua")
		    printf("Required level: "..c..'.',{0,1},"a-base.lua")
		end
		return -1
	end
	return c
end

function getLvl(str)
    local f = io.open("users/"..str..".usr",'r')
	local d = split(f:read("*l"), fsep)
	f:close()
	return tonumber(d[2])
end

function getMaxLvl()
	local fl = System.listDirectory("users/")
	local b = { }
	for i, v in pairs(fl) do
		if v.name ~= '' and v.name ~= '.' and v.name ~= ".." then
			table.insert(b, getLvl(v.name:sub(1,-5)))
		end
	end
	return maxmin(b)
end

function isAdmin(str)
	return getLvl(str) == access(1) and str ~= getUser()
end

function drawRect(x, y, w, h, c)
   screen:drawLine(x, y, x+w, y, c)
   screen:drawLine(x, y, x, y+h, c)
   screen:drawLine(x+w, y, x+w, y+h, c)
   screen:drawLine(x+w, y+h, x, y+h, c)
end

function getUser()
	return sysData[envs[1]][11][1]
end

function imgBlit(image, x, y)
	if ifind(image, 2) == nil then
		sendInput("load "..image)
	end
	sendInput("imm "..image..sep..x..sep..y)
end

-- Intelligent print
function iprint(str, font, x, y, col)
	if isStringForbidden(font) then
		printf(str)
	else
		sendInput("print "..str..sep..font..sep..x..sep..y)
	end
end

function Alpha:New()
	c = { }
	setmetatable(c, self)
	self.__index = self
	return c
end

function Alpha:Init(program, author, version)
	if not isStringForbidden(program) then
		self:setProgram(program)
	end
	if not isStringForbidden(author) then
		self:setAuthor(author)
	end
	if not isStringForbidden(version) then
		self:setVersion(version)
	end
end

function Alpha:setProgram(str)
	self[1] = str == nil and '' or str
end

function Alpha:setAuthor(str)
	self[2] = str == nil and '' or str
end

function Alpha:setVersion(str)
	self[3] = str == nil and '' or str
end

function Alpha:showData()
	printf('#'..self[1], {1})
	printf("info: by: "..self[2], {1,1})
	printf("info: VERSION: "..self[3], {0,1})
end

function getMacro(path, m)
	if m == nil then
	    m = 0
	end
	if System.doesFileExist(path) == 1 then
		for line in io.lines(path) do
			local x = split(line, ';')
    		local a = split(x[1], fsep)
    		local b = getCmd(a[1])
    		if #a ~= 1 and b ~= nil then
    			for i=2,#a do
    				table.insert(cmd[1][b], a[i])
				end
			end
		end
	elseif m == 1 then
		return
		0,
		printf("INFO: "..fixString(path).." doesnt exist.")
	end
end

function musicInfo(m)
	local str = { }
	if curpos[envs[1]][1] ~= 0 then
		local a =
		{
			mediaData[curpos[envs[1]][1]+2],
			mediaData[2],
			mediaData[curpos[envs[1]][1]+4]
		}
		local c = #mediaData
		if curpos[envs[1]][1] == 1 then
			if c == 5 then
				str[1] = "<< "..a[2].." <<"
			else
				str[1] = "<< "..a[2].." << "..a[3]
			end
		elseif curpos[envs[1]][1]+4 == c then
			str[1] = a[1].." << "..a[2].." << "
		else
			str[1] = a[1].." << "..a[2].." << "..a[3]
		end
		if mode == 1 then
		    printf("info: Current Playlist: "..fixString(mediaData[3]),{1})
		end
		printf(str[1],{0,1})
	end
	if mediaData[1] == -2 or mode == 0 then
		return
	end
	if mediaData[1] == 1 or mediaData[1] == 2 then
		str =
		{
			"ARTIST: "..Ogg.artist().."; TITLE: "..Ogg.title().."; ALBUM: "..Ogg.album()..';',
        	"GENRE: "..Ogg.genre().."; YEAR: "..Ogg.year().."; TNUMBER: "..Ogg.trackNumber()..';',
        	"STIME: "..Ogg.songTime().."; TIME: "..Ogg.gettime()..'.'
		}
	elseif mediaData[1] == 3 or mediaData[1] == 4 then
		str =
		{
		   "ARTIST: "..Aa3me.artist().."; TITLE: "..Aa3me.title().."; ALBUM: "..Aa3me.album()..';',
           "GENRE: "..Aa3me.genre().."; YEAR: "..Aa3me.year().."; TNUMBER: "..Aa3me.trackNumber()..';',
           "STIME: "..Aa3me.songTime().."; RSTIME: "..Aa3me.rawSongTime()..';',
           "TIME: "..Aa3me.gettime().."; PERCENT: "..Aa3me.percent().."%; BIT: "..Aa3me.instantBitrate()..'.'
		}
	elseif mediaData[1] == 5 or mediaData[1] == 6 then
	    str = oa == 1 and
	    {
	        "ARTIST: "..Mp3.artist().."; TITLE: "..Mp3.title().."; ALBUM: "..Mp3.album()..';',
		    "GENRE: "..Mp3.genre().."; YEAR: "..Mp3.year().."; TNUMBER: "..Mp3.trackNumber()..';',
		    "TIME: "..Mp3.getTime().."; STIME: "..Mp3.songTime()..'.'
		}
		or
		{
		    "ARTIST: "..Mp3me.artist().."; TITLE: "..Mp3me.title().."; ALBUM: "..Mp3me.album()..';',
		    "GENRE: "..Mp3me.genre().."; YEAR: "..Mp3me.year().."; TNUMBER: "..Mp3me.trackNumber()..';',
		    "TIME: "..Mp3me.gettime().."; STIME: "..Mp3me.songTime().."; RSTIME: "..Mp3me.rawSongTime()..';',
		    "PERCENT: "..Mp3me.percent().."%; BIT: "..Mp3me.instantBitrate()..'.'
		}
	end
	if m == nil then
		m = #str
	end
	for i=1,m do
		printf(str[i],{1,1})
	end
	printf('',{1,1})
end

function printf(str, m, INPUT)
	if str == nil then
		return
	elseif type(str) == 'number' then
		str = tostring(str)
	end
	if mode == 0 then
		System.powerTick()
		str = str:gsub(char, replace)
		str = str:gsub("\a",'')
		str = str:gsub("\b",'')
		str = str:gsub("\f",'')
		str = str:gsub("\n",'')
		str = str:gsub("\r",'')
		str = str:gsub("\t",'')
		str = str:gsub("\v",'')
	end
	local a =
	{
		System.getDate(3)..'/'..System.getDate(2)..'/'..System.getDate(1),
		System.getTime(1)..':'..System.getTime(2) ..' '..System.getTime(5)
	}
	if INPUT == nil then
	    INPUT = "NULL"
	end
	if m == nil then
	    m =
		{
			0,
			0
		}
	end
	if m[2] == nil then
	    m[2] = 0
	end
	curpos[envs[mode+1]][3] = 1
	table.insert(sysData[envs[mode+1]][1],{ nil, a[1].." - "..a[2], INPUT, getUser() })
	local n = #sysData[envs[mode+1]][1]
	if str:find("INFO: ") ~= nil then
	    sysData[envs[mode+1]][1][n][5] = 3
	elseif str:sub(1,6) == "info: "
	or str:find("OUTPUT: ") ~= nil
	or str:find("INPUT: ") ~= nil then
		sysData[envs[mode+1]][1][n][5] = 4
		if str:sub(1,6) == "info: " then
			str = str:gsub("info: ",'')
		end
	elseif str:find("Successfully") ~= nil or str:find("successfully") ~= nil then
		sysData[envs[mode+1]][1][n][5] = 5		
	elseif str:sub(1,1) == '#' then
		sysData[envs[mode+1]][1][n][5] = 6
		str = str:gsub('#','')
	end
	if mode == 1 and m[2] ~= 1 then
		sysData[envs[mode+1]][1][n][1] = a[2].." - "..str
	else
		sysData[envs[mode+1]][1][n][1] = str
	end
	if n > 27 and mode == 0 then
		curpos[envs[mode+1]][2] = n - 26
	end
	if mode == 0 and m[1] ~= 1 then
		printf('',{1,1})
	end
	-- onPrintOutput(str)
end

function print2(s, m)
	printf(s, m, curcmd[4])
end

function stopList()
	curpos[envs[1]][1] = 0
	printf(fixString(mediaData[3]).." successfully stopped.")
	mediaData = { -2 }
	stopPlay()
end

function ext(str,extension,m)
	if m == nil then
		m = 0
	end
	local x = ''
	for i,v in ipairs(extension) do
		x = str..'.'..v
		if System.doesFileExist(x) == 1 and System.doesFileExist(str) == 0 then
			return x
		elseif (str:sub(-(v:len()))):lower() == v then
			return i
		end
	end
	if m == 0 then
		printf("INFO: "..fixString(str).." is not in a valid format.")
	end
end

function getLine(str)
	local a = tonumber(str)
	if a ~= nil then
		if a < 1 or a > #sysData[envs[1]][1] then
			return
			0,
			print2("INFO: LINE must be an integer between 1 and number of LINES.",{1}),
			usage({0,1})
		end
		return a
	else
		for i=1,#sysData[envs[1]][1] do
			if str == sysData[envs[1]][1][i][1] then
				return i
			end
		end
	end
end

function checkMouse()
	return mouse[1] ~= nil and mouse[2]
end

function coordsCheck(x, y)
	if mode == 0 and (x < 0 or x > 470 or y < 0 or y > 260) then
		return
		0,
		printf("INFO: Invalid Coords:", {1}, "DEBUG"),
		printf("info: Xn must be >= 0 and <= 470, and Yn must be >= 0 and <= 260.", {0,1}, "DEBUG")
	end
end

function checkUsers(str)
	local fl = System.listDirectory("ms0:/PSP/GAME/AlphaBase HM7/users/")
	for i, v in pairs(fl) do
		if v.name:find(str) ~= nil then
			return
		end
	end
	return 0
end

function ifind(str, m, m2)
	if m2 == nil then
		if m == nil then
			m = 1
		end
		for i=1,#fstor[m] do
    		if str == fstor[m][i][2] or tonumber(str) == fstor[m][i][1] then
	    		return i
	    	end
		end
	else
		for i=1,#sysData do
		    if sysData[i][13] == str or tonumber(str) == i then
		        return i
			end
		end
	end
end

function getHelper()
	local skip = 1
	local b = { }
	for v in io.lines("SCRIPT.LUA") do
		if v:find("-- End") ~= nil then
			break
		end
		if skip == 0 then
			local a = split(v, " =")
			table.insert(b, a[1])
		end
		if v:find("Initializing Helper vars") ~= nil then
			skip = 0
		end
	end
	return b
end

function fsym(str)
	local s =
	{
		'/',
		':',
		'*',
		'?',
		'"',
		'<',
		'>',
		'|'
	}
	for i=1,8 do
		str = str:gsub(s[i],'_')
	end
	return str
end

function non(v)
  	return v == 0 and 1 or 0
end

function playList()
    mediaData[2] = mediaData[curpos[envs[1]][1]+3]
    local a = ext(mediaData[curpos[envs[1]][1]+3],{"ogg","ogm","oga","ogv","ogx","mp3","aa3"},1)
	if a > 0 and a < 6 then
		mediaData[1] = 2
		Ogg.stop()
		Ogg.load(mediaData[2])
		Ogg.play()
	elseif a == 6 then
		mediaData[1] = 6
		if oa == 1 then
			Mp3.stop()
			Mp3.load(mediaData[2])
			Mp3.play()
		else
			Mp3me.stop()
			Mp3me.load(mediaData[2])
			Mp3me.pla3y()
		end
	elseif a == 7 then
		if oa == 0 then
			mediaData[1] = 4
			Aa3me.stop()
			Aa3me.load(mediaData[2])
			Aa3me.play()
		end
	end
	musicInfo(2)
	-- onUserPlayList(mediaData[3], mediaData[2])
end

function usage(m)
	if m == nil then
	    m =
		{
			0,
			0
		}
	end
	if m[2] == nil then
		m[2] = 0
	end
	return print2("USAGE: "..curcmd[1][1]..' '..cmd[1][curcmd[5]][1]..'.',m)
end

function setupFor(m)
	if m == nil then
		m = 0
	end
	if m == 0 then
		for i=#sysData[envs[1]][1],non(mode)+((curcmd[1][1] == 'q' or curcmd[1][1] == "quit" or curcmd[1][1] == "oload") and 3 or 4),-1 do
			table.remove(sysData[envs[1]][1],i)
		end
		curpos[envs[1]][2] = 1
		print2("*** QUITTING PROGRAM ***")
		print2('#'..exit,{1,1}, "emsg")
		print2("info: Program will end up in 4 seconds...", {1,1})
		-- onUserQuitting()
		System.setcpuspeed(63)
		t = 120
	else
		printf('#'..welcome, {1,1}, "wmsg")
		printf("Press X for enter OSK, type \"hlp\" for help.", {0,1}, "HELPER")
	end
end