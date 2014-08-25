-- utility.lua by Wesker aka DekraN for AlphaBase HM7
-- UPDATED at 09/10/2009, version 1.0.0


function ab_flash()
	if isStringForbidden(curcmd[1][2]) then
		return usage()
	end
	local a = tonumber(curcmd[1][2])
	if a == nil or (a ~= 0 and a ~= 1 and a ~= 2 and a ~= 3) then
		return print2("INFO: FLASH must be 0, 1, 2 or 3.")
	end
	if flash[a+1] == 0 then
		flash[a+1] = 1
		System.assign("flash"..a..':',"lflash0:0,"..a,"flashfat"..a..':')
	else
		flash[a+1] = 0 System.unassign("flash"..a..':')
	end
	print2("flash"..a.." successfully "..(flash[a+1] == 1 and "assigned" or "unassigned")..'.')
end
addCommand({ "flash" }, "[FLASH]")

function ab_usb()
	if isStringForbidden(curcmd[1][2]) then
		usage({1})
		print2("INFO: Use something else for establish an USB/UMD connection.",{1,1})
		if System.usbState(1,0) == 0 then
			System.usbDiskModeActivate()
		else
			System.usbDiskModeDeactivate()
		end
		return print2("USB Status: "..System.usbState(1,1).." ("..System.usbState(1,0)..')')
	end
	local a = tonumber(curcmd[1][2])
	if a == nil then
		return print2("INFO: FLASH must be an integer.")
	elseif a == 0 then
		System.usbDevFlash0()
	elseif a == 1 then
		System.usbDevFlash1()
	elseif a == 2 then
		System.usbDevFlash2()
	elseif a == 3 then
		System.usbDevFlash3()
	else
		return
		System.usbDevUMD(),
		print2("USB/UMD connection successfully established.")
	end
	print2("USB/flash"..a.." connection successfully established.")
end
addCommand({ "usb" }, "(FLASH)")

function ab_tick()
	System.powerTick()
	if mode == 1 then
		print2("Power tick successfully sent to PSP.")
	end
end
addCommand({ "tick" })

function ab_mem()
	print2("*** MEMORY CLEANED ***")
	System.memclean()
end
addCommand({ "mem" })

function ab_lcd()
	if lcd == 0 then
		lcd = 1
		System.LCDTimerEnable()
	else
		lcd = 0
		System.LCDTimerDisable()
	end
	print2("LCD Timer successfully "..(lcd == 1 and "enabled" or "disabled")..
	" - Time Remaining. "..System.LCDTimerGet()..'.')
end
addCommand({ "lcd" })

function ab_oa()
	if oa == 0 then
		oa = 1
		System.oaenable()
	else
		oa = 0
		System.oadisable()
	end
	print2("OA successfully "..(oa == 1 and "enabled" or "disabled")..'.')
end
addCommand({ "oa" })

function ab_cpu()
	local a = isStringForbidden(curcmd[1][2]) and cpu_clock or tonumber(curcmd[1][2])
	if a == nil or a < 0 or a > 333 then
		return print2("INFO: SPEED must be an integer between 0 and 333.")
	end
	System.setcpuspeed(a)
	print2("CPU Speed successfully set to: "..a.."MHz.")
end
addCommand({ "cpu" }, "(SPEED)")

function ab_cpu2()
	local a = isStringForbidden(curcmd[1][2]) and 0 or tonumber(curcmd[1][2])
	local b =
	{
		{
		    333,
		    "High"
		},
		{
		    266,
		    "Reg"
		},
		{
		    133,
		    "Low"
		}
	}
	if a == nil or (a ~= 0 and a ~= 1 and a ~= 2) then
		return
		print2("INFO: Invalid MODE. It must be: 0 for High, 1 for Reg, 2 for Low.",{1}),
		usage({0,1})
	end
	if a == 0 then
		System.setHigh()
	elseif a == 1 then
		System.setReg()
	else
		System.setLow()
	end
	print2("CPU Speed successfully set to: "..b[a+1][2].." ("..b[a+1][1].."MHz).")
end
addCommand({ "cpu2" }, "(MODE)")