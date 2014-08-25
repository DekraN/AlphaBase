-- net.lua by Wesker aka DekraN for AlphaBase HM7
-- UPDATED at 09/10/2009, version 1.0.0


function ab_wlan()
	if wlan == 0 then
		if isStringForbidden(curcmd[1][2]) then
			return usage()
		end
		wlan = 1
		Wlan.init(curcmd[1][2])
	else
		wlan = 0
		Wlan.term()
	end
	print2("Successfully "..wlan == 1 and ("connected to "..curcmd[1][2] or "unconnected")..'.')
end
addCommand({ "wlan" }, "[CONNECTION_NUMBER]")

function ab_share()
	if wlan == 0 then
		return print2("INFO: Wlan Connection must be already started.")
	end
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
	print2("START SHARING: "..fixString(curcmd[2][2]))
	setupFor(curcmd[2][2])
end
addCommand({ "share" }, "[PATH]")

function ab_ahs()
	if Adhoc.getState() == 0 then
		return print2("INFO: Adhoc Connection must be already started.")
	end
	if isStringForbidden(curcmd[2][2]) then
		if curfile == nil then
			return usage()
		else
			curcmd[2][2] = curfile
		end
	end
	if System.doesFileExist(curcmd[2][2]) == 0 then
		return print2("INFO: "..fixString(curcmd[2][2]).." doesnt exist.")
	end
	local getname = curcmd[2][2]:len()-5
	while 1 do
		local letter = curcmd[2][2]:sub(getname, getname)
		if letter == "/" then
			start_pos = getname + 1
			break
		else
			getname = getname -1
		end
	end
	local NAME = curcmd[2][2]:sub(-( curcmd[2][2]:len()-start_pos))
	local File = io.open(curcmd[2][2])
	local STRING = File:read("*a")
	Adhoc.send(STRING)
	Adhoc.send("*_*_*_*_*_*_*_")
	Adhoc.send(NAME)
	File:close()
	print2(fixString(curcmd[2][2]).." successfully sent.")
end
addCommand({ "ahs" }, "[PATH]")

function ab_ahr()
	if Adhoc.getState() == 0 then
		return print2("INFO: Adhoc Connection must be already started.")
	end
	if isStringForbidden(curcmd[2][2]) then
		if curfile == nil then
			return usage()
		else
			curcmd[2][2] = curfile
		end
	end
	if System.doesDirExist(curcmd[2][2]) == 0 then
		return print2("INFO: "..curcmd[2][2].." doesnt exist.")
	end
	local FILE
	while 1 do
		if Adhoc.recv() ~= "*_*_*_*_*_*_*_" then
			if Adhoc.recv() ~= "" then
				FILE = Adhoc.recv()
			end
		else
			break
		end
	end
	while 1 do
		if Adhoc.recv() ~= "*_*_*_*_*_*_*_" and Adhoc.recv() ~= "" then
			local NAME = Adhoc.recv()
			break
		end
	end
	local write_file = io.open(curcmd[2][2].."/"..NAME)
	write_file:write(FILE)
	write_file:close()
	print2("Data successfully received in: "..curcmd[2][2])
end
addCommand({ "ahr" }, "[PATH]")

function ab_server()
	if wlan == 0 then
		return print2("INFO: WLAN must be already initialized to do this.")
	end
	if isStringForbidden(curcmd[3][1]) then
		return usage()
	end
	local a = isStringForbidden(curcmd[3][2]) and 80 or tonumber(curcmd[3][2])
	if a == nil then
		return print2("INFO: PORT must be an integer.")
	end
	local b = ifind(curcmd[3][1],3)
	if b == nil then
		return print2("INFO: SOCKET/ID not found.")
	end
	fstor[3][b][1]:createServerSocket(a)
	print2("Successfully created a new server as socket: "..curcmd[3][1].." and PORT: "..a)
end
addCommand({ "server" }, "[SOCKET/ID]~(PORT)")

function ab_udp()
	if wlan == 0 then
		return print2("INFO: WLAN must be already initialized to do this.")
	end
	if udp == 0 then
		udp = 1
		netconnect()
		print2("Successfully socket-connected to the standard netlib UDP server for netlib 2.0")
	else
		udp = 0
		netclose()
		print2("Successfully closed connection to any UDP socket opened.")
		for i=#fstor[3],1,-1 do
			table.remove(fstor[3],i)
		end
	end
end
addCommand({ "udp" })

function ab_net()
	if wlan == 0 then
		return print2("INFO: WLAN must be already initialized to do this.")
	end
	if udp == 0 then
		return print2("INFO: Must be connected to an UDP Server Socket.")
	end
	if isStringForbidden(curcmd[3][1]) or isStringForbidden(curcmd[3][2]) then
		return usage()
	end
	local a =
	{
		'w',
		'a'
	}
	local b = isStringForbidden(curcmd[3][3]) and 0 or tonumber(curcmd[3][3])
	if b == nil or (b ~= 0 and b ~= 1) then
		return print2("INFO: MODE must be a boolean value (0 for write, 1 for append).")
	end
	netsend(curcmd[3][1],curcmd[3][2],a[b+1])
	print2("OUTPUT: "..netrecv().." INPUT: "..curcmd[3][2])
	print2(curcmd[3][1].." File Content: "..netget(curcmd[3][1]))
end
addCommand({ "net" }, "[DATA]~[ID]~(MODE)")

function ab_ninfo()
	if wlan == 0 then
		return print2("INFO: WLAN must be already initialized to do this.")
	end
	if udp == 0 then
		return print2("INFO: Must be connected to an UDP Server Socket.")
	end
	if isStringForbidden(curcmd[1][2]) then
		return usage()
	end
	local a = isStringForbidden(curcmd[1][2]) and 0 or tonumber(curcmd[1][2])
	if a == nil or (a ~= 0 and a ~= 1) then
		return print2("INFO: MODE must be a boolean value (0 for reg, 1 for unreg).")
	end
	if a == 0 then
		netreg(curcmd[1][2])
	else
		netunreg(curcmd[1][2])
	end
	print2(scurcmd[1][2].." Sending File Info process successfully "..
	(a == 0 and "enabled" or "disabled")..'.')
end
addCommand({ "ninfo" }, "[ID] (MODE)")

function ab_mail()
	if wlan == 0 then
		return print2("INFO: WLAN must be already initialized to do this.")
	end
	if udp == 0 then
		return print2("INFO: Must be connected to an UDP Server Socket.")
	end
	if isStringForbidden(curcmd[3][1]) or isStringForbidden(curcmd[3][2]) then
		return usage()
	end
	if isStringForbidden(curcmd[3][3]) then
		curcmd[3][3] = "text"
	end
	if isStringForbidden(curcmd[3][4]) then
		curcmd[3][4] = "subject"
	end
	netmail(curcmd[3][1],curcmd[3][2],curcmd[3][3],curcmd[3][4])
	print2("Mail sent to: "..curcmd[3][1]..", from: "..curcmd[3][2],{1})
	print2(mode == 1 and "info: MESSAGE: "..curcmd[3][3].." CONTENT: "..curcmd[3][4] or '',{non(mode),1})
end
addCommand({ "mail" }, "[TO]~[FROM]~(MESSAGE)~(SUBJECT)")

function ab_call()
	if wlan == 0 then
		return print2("INFO: WLAN must be already initialized to do this.")
	end
	if udp == 0 then
		return print2("INFO: Must be connected to an UDP Server Socket.")
	end
	if isStringForbidden(curcmd[1][2]) then
		return usage()
	end
	netcall(curcmd[1][2],curcmd[1][3])
	print2("Successfully set up a call with: "..curcmd[1][2].." as: "..curcmd[1][3])
end
addCommand({ "call" }, "[CONTACT]~[DESTINATION]")

function ab_sms()
	if wlan == 0 then
		return print2("INFO: WLAN must be already initialized to do this.")
	end
	if udp == 0 then
		return print2("INFO: Must be connected to an UDP Server Socket.")
	end
	if isStringForbidden(curcmd[3][1]) or isStringForbidden(curcmd[3][2]) then
		return usage()
	end
	if isStringForbidden(curcmd[3][3]) then
		curcmd[3][3] = "text"
	end
	netsms(curcmd[3][1],curcmd[3][3],curcmd[3][2])
	print2("To: "..curcmd[3][1].." MESSAGE: "..curcmd[3][3]..mode == 1 and " From: "..curcmd[3][2] or '.')
end
addCommand({ "sms" }, "[TO]~[FROM]~(MESSAGE)")