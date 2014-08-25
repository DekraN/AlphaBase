-- io.lua by Wesker aka DekraN for AlphaBase HM7
-- UPDATED at 09/10/2009, version 1.0.0


function ab_msg()
	if isStringForbidden(curcmd[3][1]) then
		return usage()
	end
	local a = isStringForbidden(curcmd[3][2]) and 0 or tonumber(curcmd[3][2])
	if a == nil or (a ~= 0 and a ~= 1) then
		return print2("INFO: MODE must be a boolean value (0 for back option, 1 for yes, no and back options).")
	end
	System.message(curcmd[3],a)
	if mode == 1 then
		print2("OUTPUT: "..curcmd[3][1].." INPUT: "..System.buttonPressed(1))
	end
end
addCommand({ "msg" }, "[STRING]~(MODE)")

function ab_sio()
	if tonumber(System.cfwVersion()) > 1.51 then
		return print2("INFO: Only for FW 1.51 and lower.")
	end
	System.sioInit()
	if isStringForbidden(curcmd[3][1]) then
		return
		usage({1}),
		print2("Port Output: "..fixString(System.sioRead()),{0,1})
	end
	local a = not isStringForbidden(curcmd[3][2]) and curcmd[3][2] or nil
	System.sioInit(a)
	System.sioWrite(curcmd[3][1])
	print2("Port input: "..fixString(curcmd[3][1],1))
end
addCommand({ "sio" }, "[STRING]~(BAUD)")

function ab_irda()
	if System.getModel(1) ~= "PHAT" then
		return print2("INFO: Invalid PSP model.")
	end
	System.irdaInit()
	if isStringForbidden(curcmd[2][2]) then
		return
		usage({1}),
		print2("Port Output: "..fixString(System.irdaRead()),{0,1})
	end
	System.irdaWrite(curcmd[2][2])
	print2("Port input: "..fixString(curcmd[2][2],1))
end
addCommand({ "irda" }, "[STRING]")

function ab_ah()
	Adhoc.init()
	local a = Adhoc.getState()
	if a == 0 then
		Adhoc.connect()
	else
		Adhoc.term()
	end
	a = Adhoc.getState()
	if isStringForbidden(curcmd[2][2]) then
		return
		usage({1}),
		print2("CS: "..a == 1 and "CONNECTED" or "DISCONNECTED",{1,1}),
		print2("MAC: "..fixString(Adhoc.getMac(),1),{0,1})
	end
	Adhoc.send(curcmd[2][2])
	print2("OUTPUT: "..Adhoc.recv().." INPUT: "..curcmd[2][2])
end
addCommand({ "ah" }, "[STRING]")

function ab_sacc()
	if isStringForbidden(curcmd[3][1]) then
		return usage()
	end
	local a = ifind(curcmd[3][1],3)
	if isStringForbidden(curcmd[3][2]) then
		return
		fstor[3][a][1]:accept(),
		print2("*** SOCKET-CONNECTED ***")
	end
	fstor[3][a][1]:send(curcmd[3][2])
	print2("OUTPUT: "..fstor[3][a][1]:recv().." INPUT: "..curcmd[3][2])
end
addCommand({ "sacc" }, "[SOCKET]~(STRING)")

function ab_udps()
	if udp == 0 then
		return print2("INFO: Must be connected to an UDP Server Socket.")
	end
	if isStringForbidden(curcmd[3][1]) then
		return usage()
	end
	local a = ifind(curcmd[3][1],3)
	if isStringForbidden(curcmd[3][2]) then
		curcmd[3][2] = ''
	else
		fstor[8][a][1]:udpSend(curcmd[3][2])
	end
	print2("OUTPUT: "..fstor[8][a][1]:recv().." INPUT: "..curcmd[3][2])
end
addCommand({ "udps" }, "[SOCKET]~(STRING)")