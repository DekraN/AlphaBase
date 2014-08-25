-- AlphaBase v3.6 by Wesker aka DekraN
-- this is a "simple" homebrew which may help you for debugging your PSP


System.memclean()

fstor =
{
	{ },
	{ },
	{ },
	{ }
}

files =
{
	"a-marks.auf",
	"a-cmd.auf",
	"a-pos.auf"
}

mouse =
{
	nil,
	false,
	200,
	126,
	{ },
}

flash =
{
	1,
	1,
	nil,
	1
}

cmd =
{
	{ },
	{
		"assert (test, [message])",
		"collectgarbage(opt [, arg])",
		"dofile(filename)",
		"error(message [, level])",
		"getfenv(f)",
		"getmetatable(object)",
		"ipairs(t)",
		"load(func [, chunkname])",
		"loadfile(filename)",
		"loadstring(string [, chunkname])",
		"module(name [, ···])",
		"next(table [, index])",
		"pairs(t)",
		"pcall(f, arg1, ...)",
		"print(e1, e2, ...)",
		"rawequal(v1, v2)",
		"rawget(table, index)",
		"rawset(table, index, value)",
		"require(packagename)",
		"select(index, ...)",
		"setfenv(f, table)",
		"setmetatable(table, metatable)",
		"tonumber(e [, base])",
		"tostring(e)",
		"type(v)",
		"unpack(list)",
		"xpcall(f, err)",
		"math.abs()",
		"math.acos()",
		"math.asin()",
		"math.atan()",
		"math.atan2(n)",
		"math.ceil()",
		"math.cos()",
		"math.deg()",
		"math.exp()",
		"math.floor()",
		"math.log()",
		"math.log10()",
		"math.max(n1, )",
		"math.min(n1, )",
		"math.mod(n)",
		"math.pow(n)",
		"math.rad()",
		"math.sin()",
		"math.sqrt()",
		"math.tan()",
		"math.frexp(n1)",
		"math.ldexp(n1)",
		"math.random(rangemin,[rang)",
		"math.randomseed()",
		"table.concat(table [, sep [, i [, j]]])",
		"table.foreach(table, f)",
		"table.foreachi(table, f)",
		"table.sort(table [, comp])",
		"table.insert(table, [pos,] value)",
		"table.remove(table [, pos])",
		"os.clock()",
		"os.date([format [, time]])",
		"os.difftime(t2, t1)",
		"os.execute([command])",
		"os.exit([code])",
		"os.getenv(varname)",
		"os.remove(filename)",
		"os.setlocale(locale [, category])",
		"os.time([table])",
		"os.tmpname ()",
		"io.open(filename [, mode])",
		"io.close([file])",
		"io.flush()",
		"io.input([file])",
		"io.lines([filename])",
		"io.output([file])",
		"io.read(format1, ...)",
		"io.tmpfile()",
		"io.type(obj)",
		"io.write(value1, ...)",
		"debug.debug()",
		"debug.getfenv(o)",
		"debug.gethook([thread])",
		"debug.getinfo([thread,] function [, what])",
		"debug.getlocal([thread,] level, local)",
		"debug.getmetatable(object)",
		"debug.getregistry()",
		"debug.getupvalue(func, up)",
		"debug.setfenv(object, table)",
		"debug.sethook([thread,] hook, mask [, count])",
		"debug.setlocal([thread,] level, local, value)",
		"debug.setmetatable(object, table)",
		"debug.setupvalue(func, up, value)",
		"debug.traceback([thread,] [message] [, level])",
	    "System.loadPrx(FILE)",
	    "System.loadPrxKernel(FILE)",
	    "System.runeboot(PATH)",
	    "System.startPSX(PATH)",
	    "System.startUpdate(PATH)",
	    "System.loadElf(PATH)",
	    "System.startUMD()",
	    "System.startISO(PATH)",
	    "System.createDirectory(DIR)",
	    "System.removeDirectory(DIR)",
	    "System.removeFile(FILE)",
	    "System.rename(OLDNAME, NEWNAME)",
	    "System.getDirSize(DIR)",
	    "System.getFileSize(FILE)",
	    "System.doesDirExist(DIR)",
	    "System.doesFileExist(FILE)",
	    "System.copyFile(FILE_TO_COPY, COPYIED_FILE,MODE)",
	    "System.md5sum(FILE)",
		"System.unassign(FLASH)",
		"System.assign(\"flashX:\",\"lflash0:0,X\",\"flashfatX:\")",
		"System.usbDiskModeActivate()",
		"System.usbDiskModeDeactivate()",
		"System.usbDevFlash0()",
		"System.usbDevFlash1()",
		"System.usbDevFlash2()",
		"System.usbDevFlash3()",
		"System.usbDevUMD()",
		"System.usbState()",
		"System.powerTick()",
		"System.suspend()",
		"System.shutdown()",
		"System.powerIsBatteryExist()",
		"System.powerIsBatteryCharging()",
		"System.powerGetBatteryChargingStatus()",
		"System.powerIsLowBattery()",
		"System.powerGetBatteryLifePercent()",
		"System.powerGetBatteryLifeTime()",
		"System.powerGetBatteryTemp()",
		"System.powerGetBatteryVolt()",
		"System.sioInit()",
		"System.sioRead()",
		"System.sioWrite()",
		"System.irdaInit()",
		"System.irdaRead()",
		"System.irdaWrite()",
		"System.getCpuSpeed()",
		"System.getBusSpeed()",
		"System.setLow()",
		"System.setReg()",
		"System.setHigh()",
		"System.setcpuspeed(SPEED)",
		"System.autoCpu(MODE)",
		"System.getDate(MODE)",
		"System.getTime(MODE)",
		"System.getFreeSpace(DEVICE)",
		"System.getTotalSize(DEVICE)",
		"System.madeby()",
		"System.playerVer()",
		"System.cfwVersion()",
		"System.nickName()",
		"System.getModel(MODE)",
		"System.getFreeMemory()",
		"System.LCDTimerDisable()",
		"System.LCDTimerEnable()",
		"System.LCDTimerGet()",
		"System.Quit()",
		"System.memclean()",
		"System.oaenable()",
		"System.oadisable()",
		"System.message(MESSAGE , MODE)",
		"System.buttonPressed(MODE)",
		"System.startOSK(PRE_WRITTEN_TEXT , INFO)",
		"System.startGameSave(SAVE_NAME , GAME_NAME , DETAILS , SAVE_DATA , ID)",
		"System.startGameLoad( ID )",
		"System.webbrowser(PATH , URL)",
		"ZIP.extract(ZIP_FILE , EXTRACTDIR, PASSWORD)",
		"Controls.read()",
		"controls:select()",
		"controls:start()",
		"controls:up()",
		"controls:right()",
		"controls:down()",
		"controls:left()",
		"controls:l()",
		"controls:r()",
		"controls:triangle()",
		"controls:circle()",
		"controls:cross()",
		"controls:square()",
		"controls:home()",
		"controls:hold()",
		"controls:note()",
		"controls:analogX()",
		"controls:analogY()",
		"Controls.selectMask",
  		"Controls.startMask",
  		"Controls.upMask",
  		"Controls.rightMask",
  		"Controls.downMask",
  		"Controls.leftMask",
  		"Controls.ltriggerMask",
  		"Controls.rtriggerMask",
  		"Controls.triangleMask",
  		"Controls.circleMask",
  		"Controls.crossMask",
  		"Controls.squareMask",
  		"Controls.homeMask",
  		"Controls.holdMask",
  		"Controls.noteMask",
		"Hprm.read()",
		"Hprm.headphone()",
		"Hprm.remote()",
		"Hprm.mic()",
		"Wlan.init(CONNECTION_NUMBER)",
		"Wlan.term()",
		"Wlan.getIP()",
		"Wlan.startGameShare(PATH, ADHOC)",
		"Wlan.getConnectionConfigs()",
		"Wlan.useConnectionConfig(number)",
		"Adhoc.init()",
		"Adhoc.term()",
		"Adhoc.connect()",
		"Adhoc.getState()",
		"Adhoc.send(STRING)",
		"Adhoc.getMac()",
		"Socket.createServerSocket()",
		"Socket.connect(HOST,PORT)",
		"Socket.isConnected()",
		"Socket.close()",
		"Socket.udpConnect()",
		"Socket.accept()",
		"Socket.send()",
		"Socket.recv()",
		"Socket.udpConnect(host,port)",
		"udpSocket:udpSend(string)",
		"udpSocket:close()",
		"udpSocket:recv()",
		"netconnect()",
		"netclose()",
		"netsend(id, data, attribute)",
		"netget(id)",
		"netreg(id)",
		"netunreg(id)",
		"netrecv()",
		"netvalue(id)",
		"netmail(to,from,subject,message)",
		"netcall(contact, destination)",
		"netsms(to,message,from)",
		"UMD.init()",
		"UMD.term()",
		"UMD.checkDisk()",
		"UMD.getSize()",
		"UMD.ripISO(PATH)",
		"Font.load(filename)",
		"Font.createMonoSpaced()",
		"Font.createProportional()",
		"Font:setCharSize(number width, number height, number dpiX, number dpiY)",
		"Font:setPixelSizes(number width, number height)",
		"Font:getTextSize(string)",
		"Image.createEmpty(width, height)",
		"Image.load( filename )",
		"Image.loadFromMemory( data )",
		"image:blit(x, y, Image source, [sourcex, sourcey, width, height], [alpha = true])",
		"image:clear([color = transparent-black])",
		"image:fillRect(x, y, width, height, [color = transparent-black])",
		"image:drawLine(x0, y0, x1, y1, [color = black])",
		"image:pixel(x, y)",
		"image:pixel(x, y, Color)",
		"image:print(x, y, text, [color = black])",
		"image:fontPrint(font, x, y, text, [color = black])",
		"image:width()",
		"image:height()",
		"image:save( filename )",
		"screen.flip()",
		"screen.waitVblankStart([count])",
		"Color.new(r, g, b, [a=255])",
		"color:colors()",
		"Timer.new([startTime])",
		"Timer:start()",
		"Timer:time()",
		"Timer:stop()",
		"Timer:reset([startTime])",
		"Music.playFile( string file, bool loop )",
		"Music.pause()",
		"Music.resume()",
		"Music.stop()",
		"Music.playing()",
		"Music.volume( [number {0-128}] )",
		"SoundSystem.SFXVolume( number {0-128} )",
		"SoundSystem.reverb( number {0-15} )",
		"SoundSystem.panoramicSeparation( number {0-128} )",
		"Sound.load(filename, [bool loop])",
		"sound:play()",
		"voice:stop()",
		"voice:resume(Sound)",
		"voice:volume( number [0-255] )",
		"voice:pan( number [0-255] )",
		"voice:frequency( number [1-80000] )",
		"voice:playing()"
	}
}

envs =
{
	1,
	1
}

Alpha =
{
	'',
	'',
	''
}

curcmd = { }
curpos = { }
sysData = { }
mediaData = { -2 }


-- NOTE: Helper vars must be attached with the comments
-- and they cannot be locals.
-- v2.6 - Now Helper System supports also SETTINGS.ini vars.

-- Initializing Helper vars...
mode = nil
keyb = nil
clear = nil
max_env = nil
sysR = nil
sysG = nil
sysB = nil
level = nil
cpu_clock = nil
curdir = nil
curfile = nil
char = nil
schar = nil
fsep = nil
sep = nil
replace = nil
welcome = nil
exit = nil
splash = nil
desktop = nil
Circle = nil
Triangle = nil
Square = nil
Home = nil
Start = nil
Select = nil
R = nil
L = nil
nickname = System.nickName()
cpu = System.getCpuSpeed()
LCDTimer = 1
newchar = 0
wlan = 0
keyb = 0
udp = 0
oa = 0
t = -120
-- End


if System.doesFileExist("SETTINGS.ini") == 1 then
	dofile("SETTINGS.ini")
else -- Just copyied SETTINGS.ini vars
	mode = 0
	keyb = 0
	clear = 1
	max_env = 999999
	sysR = 255
	sysG = 255
	sysB = 255
	level = 10 
	cpu_clock = 333
	char = "\\"
	schar = "#r"
	fsep = "//" 
	sep = '~'
	replace = nickname
	welcome = "Welcome \\ to AlphaBase v3.6" 
	exit = "Thank you for have played AlphaBase v3.6 :D" 
	Triangle = "switch"
	Square = 'q' 
end

if max_env == nil then
	max_env = 999999
end

table.insert(fstor[4],{ Color.new(sysR, sysG, sysB), "sys" })
table.insert(fstor[4],{ mode == 0 and Color.new(sysR-255, sysG-255, sysB-255) or Color.new(0, 0, 0) , "clr" })
table.insert(fstor[4],{ Color.new(255, 0, 0), "err" })
table.insert(fstor[4],{ Color.new(255, 255, 0), "YEL" })
table.insert(fstor[4],{ Color.new(0, 255, 0), "GRN" })
table.insert(fstor[4],{ Color.new(0, 255, 255), "AZR" })

local a =
{
	"CEU.LUA", -- Remove it if you want to run in any case the script if you don't have it;	
	"a-utils.lua",
	"danzeff.lua",
	"danzeff/"
}

if mode == 0 then
	table.insert(a, "cmds/")
	table.insert(a, "users/")
end

for i, v in ipairs(a) do
	local b = System.listDirectory(v)
	while (b and System.doesDirExist(v) or System.doesFileExist(v)) == 0 do
	    	screen:print(0, 0, "INFO: "..v.." doesnt exist in \"AlphaBase HM7/\" dir;", fstor[4][3][1])
		screen:print(0, 10, "Your environment main tree may be corrupted. ERROR No. 10"..(i-1)..'.', fstor[4][4][1])
		screen.waitVblankStart()
		screen.flip()
		screen:clear()
	end
	if not b then
	    dofile(v)
	end
end

mykeyboard = Danzeff:New()
prog = Alpha:New()
prog:Init("- AlphaBase HM7 -", "Wesker aka DekraN", "BUILT 10 v3.6.8")
addEnv()

if not isStringForbidden(splash) then
	if System.doesFileExist(splash) ~= 0 then
	    if isForbiddenImage(splash) ~= 1 then
			splash = Image.load(splash)
			t = 255
			local fader = Image.createEmpty(480, 272)
			fader:clear(Color.new(0,0,0, 255))
			while t > 0 do
				screen:clear()
				screen:blit(0,0,splash)
				screen:blit(0,0,fader)
				t = t -5
				fader:clear(Color.new(0,0,0, t))
				screen.waitVblankStart()
				screen.flip()
			end
			screen.waitVblankStart(200)
			while t < 255 do
				screen:clear()
				screen:blit(0,0, splash)
				screen:blit(0,0, fader)
				t = t +5
				fader:clear(Color.new(0,0,0, t))
				screen.waitVblankStart()
				screen.flip()
			end
			t = -120
		elseif mode == 1 then
			return
		end
	elseif mode == 1 then
	    return printf("INFO: "..fixString(splash).." doesnt exist.")
	end
end

restartVars()

if System.doesFileExist(sysData[envs[1]][12][1]) == 1 then
	local f = io.open(sysData[envs[1]][12][1],'r')
	local a = split(f:read("*l"), fsep)
	for i=1,#a do
		table.insert(sysData[envs[2]][9], a[i])
	end
end

if System.doesFileExist(sysData[envs[1]][12][2]) == 1 then
	local f = io.open(sysData[envs[1]][12][2],'r')
	local a = split(f:read("*l"), fsep)
	for i=1,#a do
		if tonumber(a[i]) ~= nil then
			a[i] = tonumber(a[i])
		end
		table.insert(sysData[envs[2]][8], a[i])
	end
end

if System.doesFileExist(sysData[envs[1]][12][3]) == 1 then
	local f = io.open(sysData[envs[1]][12][3],'r')
	local a = split(f:read("*l"), fsep)
	for i=2,#a,2 do
	    local b = split(a[i-1], ',')
		table.insert(sysData[envs[2]][7], { b[1], b[2], b[3], b[4], a[i] })
	end
end

getMacro("a-mac.auf")
System.setcpuspeed(cpu_clock == nil and 333 or cpu_clock)

if not isStringForbidden(curdir) then
	if mode == 0 then
	    if System.doesDirExist(curdir) == 1 then
			System.currentDirectory(curdir)
		else
		    printf("INFO: "..fixString(curdir).." doesnt exist.")
		end
	else
	    System.currentDirectory(curdir)
	end
end

if not isStringForbidden(curfile) then
	if mode == 0 then
	    if System.doesFileExist(curfile) == 0 then
	        curfile = nil
		else
		    printf("INFO: "..fixString(curfile).." doesnt exist.")
		end
	end
end

if desktop ~= nil and type(desktop) ~= 'number' then
	sendInput("load "..desktop..rchar.."imm "..desktop)
end

setupFor(1)


-- main()

while 1 do
	local pad = Controls.read()
	local skip =
	{
		0,
		0,
		''
	}
	local a,x,s,w = { },0,'',#sysData[envs[1]][1]
	if #sysData[envs[1]][3] > 0 and desktop ~= nil then
		skip[1] = 1
		screen:blit(sysData[envs[1]][3][1][1],sysData[envs[1]][3][1][2],fstor[2][sysData[envs[1]][3][1][3]][1])
	end
	for i=curpos[envs[1]][2],curpos[envs[1]][2]+26 do
		if i > w then
			break
		end
		a[x+1] = sysData[envs[1]][1][i][1]:len()
		if a[x+1] > 60 then
			s = sysData[envs[1]][1][i][1]:sub(curpos[envs[1]][3])
		else
			s = sysData[envs[1]][1][i][1]
		end
		screen:print(0, x *10, s, sysData[envs[1]][1][i][5] == nil and fstor[4][1][1] or fstor[4][sysData[envs[1]][1][i][5]][1])
		x = x +1
	end
	
	if t ~= -120 then
		sysData[envs[1]][1][w][1] = "INFO: Program will end up in "..math.modf(t/30).." seconds..."
		t = t -1
		if t < 0 then
			if mode == 0 then
				local f
				local m =
				{
					#sysData[envs[1]][8],
					#sysData[envs[1]][9],
					#sysData[envs[1]][7]
				}
				if m[1] > 1 and access() ~= -1 then
				    f = io.open(sysData[envs[1]][12][2]:upper(),'w')
					for i=1,m[1] do
						f:write(sysData[envs[1]][8][i]..fsep)
						f:flush()
					end
					f:close()
				end
				if m[2] > 1 then
				    f = io.open(sysData[envs[1]][12][1]:upper(),'w')
					for i=1,m[2] do
						f:write(sysData[envs[1]][9][i]..fsep)
						f:flush()
					end
					f:close()
				end
				if m[3] > 1 then
					f = io.open(sysData[envs[1]][12][3]:upper(),'w')
					for i=1,m[3] do
						f:write(sysData[envs[1]][7][i][1]..','..sysData[envs[1]][7][i][2]..','..sysData[envs[1]][7][i][3]..','..sysData[envs[1]][7][i][4]
						..fsep..sysData[envs[1]][7][i][5]..fsep)
						f:flush()
					end
					f:close()
				end

				if System.doesDirExist("temp") == 1 and mode == 0 then
					System.removeFile("temp")
				end
				if System.usbState(1,0) == 1 then
					System.usbDiskModeDeactivate()
				end
				if Adhoc.getState() == 1 then
					Adhoc.term()
				end
				if wlan == 1 then
					Wlan.term()
				end                           
				if udp == 1 then
					netclose()
				end
				System.oaenable()
				System.LCDTimerEnable()
				
			end
			System.setcpuspeed(cpu)
			-- onUserQuit()
			local v = split(sysData[envs[1]][1][w][3],' ')
			if curcmd[1][1] == "umd" then
				System.startUMD()
			elseif curcmd[1][1] == "eboot" then
				System.runeboot(curcmd[2][2])
			elseif curcmd[1][1] == "psx" then
				System.startPSX(curcmd[2][2])
			elseif curcmd[1][1] == "upd" then
				System.startUpdate(curcmd[2][2])
			elseif curcmd[1][1] == "iso" then
				System.startISO(curcmd[2][2])
			elseif curcmd[1][1] == "share" then
				Wlan.startGameShare(curcmd[2][2])
			elseif curcmd[1][1] == "oload" then
				while 1 do
					-- nothing happen, so overloaded
				end
			else
				System.Quit()
			end
		end
	else
	
		if clear == 0 then
			for u=2,7 do
				for i=1,#sysData[envs[1]][u] do
					if u == 2 then
						screen:fontPrint(fstor[1][sysData[envs[1]][2][i][1]][1],sysData[envs[1]][2][i][2],sysData[envs[1]][2][i][3],
						sysData[envs[1]][2][i][4],fstor[4][sysData[envs[1]][2][i][5]][1])
					elseif u == 3 then
						if i ~= skip[1] then
							screen:blit(sysData[envs[1]][3][i][1],sysData[envs[1]][3][i][2],fstor[2][sysData[envs[1]][3][i][3]][1])
						end
					elseif u == 4 then
						if sysData[envs[1]][4][i][6] == 0 then
							drawRect(sysData[envs[1]][4][i][1],sysData[envs[1]][4][i][2],sysData[envs[1]][4][i][3],sysData[envs[1]][4][i][4],fstor[4][sysData[envs[1]][4][i][5]][1])
						else
							screen:fillRect(sysData[envs[1]][4][i][1],sysData[envs[1]][4][i][2],sysData[envs[1]][4][i][3],sysData[envs[1]][4][i][4],fstor[4][sysData[envs[1]][4][i][5]][1])
						end
					elseif u == 5 then
						screen:drawLine(sysData[envs[1]][5][i][1],sysData[envs[1]][5][i][2],sysData[envs[1]][5][i][3],sysData[envs[1]][5][i][4],fstor[4][sysData[envs[1]][5][i][5]][1])
					elseif u == 6 then
						if sysData[envs[1]][6][i][1]:time() > sysData[envs[1]][6][i][2] then
							sendInput(sysData[envs[1]][6][i][3])
							sysData[envs[1]][6][i][1]:reset()
							if sysData[envs[1]][6][i][4] == 1 then
								sysData[envs[1]][6][i][1]:start()
							else
								sysData[envs[1]][6][i][5] = 0
							end
						end
					elseif u == 7 and checkMouse() then
					    if mouse[2] > sysData[envs[1]][7][i][1] and mouse[3] > sysData[envs[1]][7][i][2]
					    and mouse[2] < sysData[envs[1]][7][i][3] and mouse[3] < sysData[envs[1]][7][i][4]
					    then
					        skip[3] = sysData[envs[1]][7][i][5]
						end
					end
				end
			end			
		end
		
		if curpos[envs[1]][1] ~= 0 then
			local b = "false"
			local a = ext(mediaData[curpos[envs[1]][1]+3],{"ogg","ogm","oga","ogv","ogx","mp3","aa3"},1)
			if a > 0 and a < 6 then
				b = Ogg.EndOfStream()
			elseif a == 6 then
				if oa == 1 then
					b = Mp3.EndOfStream()
				else
					b = Mp3me.eos()
				end
			else
				if oa == 0 then
					b = Aa3me.eos()
				end
			end
			if b == "true" then
				curpos[envs[1]][1] = curpos[envs[1]][1] + 1
				if curpos[envs[1]][1]+3 < #mediaData then
					playList()
				else
					stopList()
				end
			end
		end
		if edit == 1 then
			
			if keyb == 0 then
				sendInput(outputtxt)
			else
				screen:drawLine(10 + ((curpos[envs[1]][4] -1.5) * 8), (x-1)*10, 10 + ((curpos[envs[1]][4] -1.5) * 8), x*10, fstor[4][1][1])
				mykeyboard:Display()
				if newchar ~= 0 then
				    skip[2] = 1
				end
				newchar = mykeyboard:Input(pad)
				if newchar == 4 then
					sendInput(sysData[envs[1]][1][w][1])
				elseif newchar == 9 then
				
					if curpos[envs[1]][4] > 0 then
                		sysData[envs[1]][1][w][1] = sysData[envs[1]][1][w][1]:sub(0, curpos[envs[1]][4] - 1)..
                		sysData[envs[1]][1][w][1]:sub(curpos[envs[1]][4] + 1, sysData[envs[1]][1][w][1]:len())
                		curpos[envs[1]][4] = curpos[envs[1]][4] -1
                	end
                	
				elseif newchar == 3 then
					sendInput()
					-- onUserExitKeyboard()
				else
				
					local function setup()
						local scan = split(sysData[envs[1]][1][w][1],' ')
						local a = 1
						if sysData[envs[1]][1][w][1]:find(scan[1]..' ') ~= nil then
							if scan[1] == "exec" then
								a = 2
							elseif scan[1] == "calc" then	
								a = 3
							end
						end
						return a, scan[1]
					end

					local function setup2(i, scan)
						if i == 1 then
							sysData[envs[1]][1][w][1] = mode == 0 and cmd[1][curpos[envs[1]][5]][2] or cmd[1][curpos[envs[1]][5]][2]..' '..cmd[1][curpos[envs[1]][5]][1]
						else
							local buf = { }
							if mode == 0 then
								buf = explode('(', cmd[2][curpos[envs[1]][i+4]])
    						end
							sysData[envs[1]][1][w][1] = scan..' '..(mode == 0 and buf[1] or cmd[2][curpos[envs[1]][i+4]])
						end
						if mode == 0 then
							curpos[envs[1]][4] = sysData[envs[1]][1][w][1]:len()
						end						
					end

					if newchar == 1 then
				    	if mode == 0 then
				    		curpos[envs[1]][4] = curpos[envs[1]][4] -1
				    		if curpos[envs[1]][4] < 0 then
				    			curpos[envs[1]][4] = sysData[envs[1]][1][w][1]:len()
				    		end
				    	else
				    		if curpos[envs[1]][4] > -1 then
				    			curpos[envs[1]][4] = curpos[envs[1]][4] -1
				    		end
				    	end
				    	
					elseif newchar == 2 then
						if mode == 0 then
							curpos[envs[1]][4] = curpos[envs[1]][4] +1
							if curpos[envs[1]][4] > sysData[envs[1]][1][w][1]:len() then
								curpos[envs[1]][4] = 0
							end
						else
							if curpos[envs[1]][4] < sysData[envs[1]][1][w][1]:len() +1 then
								curpos[envs[1]][4] = curpos[envs[1]][4] +1
							end
						end					
					
					elseif newchar == 8 then
						local cur, scan = setup()
						if cur ~= 3 then
							if mode == 0 then
								curpos[envs[1]][cur+4] = curpos[envs[1]][cur+4] -1
								if curpos[envs[1]][cur+4] < 1 then
									curpos[envs[1]][cur+4] = #cmd[cur]
								end
							else				
								if curpos[envs[1]][cur+4] > 0 then
									curpos[envs[1]][cur+4] = curpos[envs[1]][cur+4] -1
								end
							end
						else
							if mode == 0 then
								curpos[envs[1]][7] = curpos[envs[1]][7] -1
								if curpos[envs[1]][7] < 28 then
									curpos[envs[1]][7] = 51
								end
							else
								if curpos[envs[1]][7] > 27 then
									curpos[envs[1]][7] = 51
								end
							end
						end	
						setup2(cur, scan)
						
					elseif newchar == 10 then
						local cur, scan = setup()
						if cur ~= 3 then
							if mode == 0 then
								curpos[envs[1]][cur+4] = curpos[envs[1]][cur+4] +1
								if curpos[envs[1]][cur+4] > #cmd[cur] then
					    			curpos[envs[1]][cur+4] = 1
								end
							else
								if curpos[envs[1]][cur+4] < #cmd[cur] +1 then
									curpos[envs[1]][cur+4] = curpos[envs[1]][cur+4] +1
								end
							end
						else
							if mode == 0 then
								curpos[envs[1]][7] = curpos[envs[1]][7] +1
								if curpos[envs[1]][7] > 51 then
									curpos[envs[1]][7] = 28
								end
							else
								if curpos[envs[1]][7] < 52 then
									curpos[envs[1]][7] = curpos[envs[1]][7] +1
								end
							end
						end
						setup2(cur, scan)
					elseif newchar ~= 0 and skip[2] == 0 then
              			sysData[envs[1]][1][w][1] = (sysData[envs[1]][1][w][1]:sub(0, curpos[envs[1]][4]))..string.char(newchar)..
						(sysData[envs[1]][1][w][1]:sub(curpos[envs[1]][4] + 1, sysData[envs[1]][1][w][1]:len()))
              			curpos[envs[1]][4] = curpos[envs[1]][4] + 1
					end
				end                               
			end
		else
		
			if pad:cross() then
			
    			if checkMouse() then
    			
					local a = 0
					if mouse[5][1] == mouse[5][2] == nil then
					
						mouse[5][1] = fstor[2][mouse[1]]:width()
						mouse[5][2] = fstor[2][mouse[1]]:height()
						
					end
					local coords =
					{
						mouse[3]+mouse[5][1],
						mouse[4]+mouse[5][2]
					}
					screen:print(mouse[3]+0.35,mouse[4]+0.35,'#'..coords[1]..','..coords[2], fstor[4][1][1])
					if mouse[5][1] == fstor[2][mouse[1]]:width() and mouse[5][2] == fstor[2][mouse[1]]:height() then
						mouse[5] = { }
					end
					-- onUserViewCoords(coords[1], coords[2])

				elseif not oldpad:cross() then

					if keyb == 0 then
						outputtxt = System.startOSK((mode == 1 or isStringForbidden(sysData[envs[1]][10][curpos[envs[1]][8]]))
						and '' or sysData[envs[1]][10][curpos[envs[1]][8]],"Type \"keyb\" for change keyboard type.")
					else
						mykeyboard:Init(mouse[3],mouse[4])
						printf((mode == 1 or isStringForbidden(sysData[envs[1]][10][curpos[envs[1]][8]])) and '' or sysData[envs[1]][10][curpos[envs[1]][8]],{1,1})
						if mode == 0 and not isStringForbidden(sysData[envs[1]][10][curpos[envs[1]][8]]) then
						    curpos[envs[1]][4] = sysData[envs[1]][10][curpos[envs[1]][8]]:len()
						end
					end
					edit = 1
					-- onUserEnterKeyboard(keyb)
				end
				if not isStringForbidden(skip[3]) and not oldpad:cross() then
					sendInput(skip[3])
				end
				
			elseif pad:circle() and not oldpad:circle() then
			
				if isStringForbidden(Circle) then
				    printf('',{1})
				else
					sendInput(Circle)
				end


			elseif pad:square() then
			
				if mode == 1 then
				
				    if not oldpad:square() then
						if w ~= 0 then
							table.remove(sysData[envs[1]][1], w)
						end
					end
					
				else
				
     				sendInput(Square)
     				
				end
				
			elseif pad:triangle() and not oldpad:triangle() then
				sendInput(Triangle)
			elseif pad:home() and not oldpad:home() then
				if isStringForbidden(Home) then
					printf("info: It's advisable to quit by using the \"q(uit)\" command.")
				else
					sendInput(Home)
				end
			elseif pad:start() and not oldpad:start() then
				sendInput(Start)
			elseif pad:select() and not oldpad:select() then
				sendInput(Select)			

			elseif pad:r() and not oldpad:r() then
			    if isStringForbidden(R) then
			        if mode == 0 then
			        	if #sysData > 1 then
			        		local a = envs[1]
			            	a = a +1
			            	if a > #sysData then
			             	   a = 1
							end
							sendInput("cenv "..a)
						end
					else
			        	if envs[1] +1 < #sysData then
			            	sendInput("cenv "..(envs[1]+1))
						end
					end
				else
				    sendInput(R)
				end
			elseif pad:l() and not oldpad:l() then
			    if isStringForbidden(L) then
			        if mode == 0 then
			        	if #sysData > 1 then
			        		local a = envs[1]
			            	a = a -1
			            	if a < 1 then
			               		a = #sysData
							end
							sendInput("cenv "..a)
						end
					else
					    if envs[1] > 0 then
					        sendInput("cenv "..(envs[1]-1))
						end
					end
				else
					sendInput(L)
				end
			end
			
			if w > 27 then
			
				if pad:down() then

					if curpos[envs[1]][2] ~= w -25 then
						curpos[envs[1]][2] = curpos[envs[1]][2] +1
					end
					if mode == 0 and curpos[envs[1]][2] > w -26 and not oldpad:down() then
						curpos[envs[1]][2] = 1
					end
					-- onUserScrollDown(curpos[envs[1]][2])

				elseif pad:up() then

					if curpos[envs[1]][2] -1 > 0 then
						curpos[envs[1]][2] = curpos[envs[1]][2] -1
					end
					if mode == 0 and curpos[envs[1]][2] -1 < 1 and not oldpad:up() then
						curpos[envs[1]][2] = w -26
					end
					-- onUserScrollUp(curpos[envs[1]][2])
										
				end
			end
			
			if pad:right() then
			
    		    local a = maxmin(a) -59
				if curpos[envs[1]][3] ~= a then
					curpos[envs[1]][3] = curpos[envs[1]][3] + 1
				end
				if mode == 0 and curpos[envs[1]][3] == a and not oldpad:right() then
				    curpos[envs[1]][3] = 1
				end
				-- onUserScrollLeft(curpos[envs[1]][3])
				
			elseif pad:left() then
			
				if curpos[envs[1]][3] ~=	1 then
					curpos[envs[1]][3] = curpos[envs[1]][3] - 1
				end
				if mode == 0 and curpos[envs[1]][3] == 1 and not oldpad:left() then
				    curpos[envs[1]][3] = maxmin(a) -59
				end
				-- onUserScrollRight(curpos[envs[1]][3])
			end
			
			if checkMouse() then
				screen:blit(mouse[3],mouse[4],fstor[2][mouse[1]][1])
				if pad:analogY() < -64 and mouse[4] > 0 then
					mouse[4] = mouse[4] - 4
				end
				if pad:analogY() > 64 and mouse[4] < 260 then
					mouse[4] = mouse[4] + 4
				end
				if pad:analogX() > 64 and mouse[3] < 470 then
					mouse[3] = mouse[3] + 4
				end
				if pad:analogX() < -64 and mouse[3] > 0 then
					mouse[3] = mouse[3] - 4
				end
			end
		end
	end
	
	screen.waitVblankStart()
	screen.flip()
	screen:clear(fstor[4][2][1])
	oldpad = pad
	
end                                                                                                                      