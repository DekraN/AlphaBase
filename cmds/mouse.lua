-- mouse.lua by Wesker aka DekraN for AlphaBase HM7
-- UPDATED at 09/10/2009, version 1.0.0


function ab_mouse()
	if isStringForbidden(curcmd[2][2]) then
		return usage()
	end
	local a = ifind(curcmd[2][2],2)
	if a == nil then
		return print2("INFO: NAME/ID not found.")
	end
	mouse[1] = a
	printf(curcmd[2][2].." successfully set as mouse.", nil, "MOUSE")
	if mode == 0 and not mouse[2] then
		sendInput("switch")
	end
end
addCommand({ "mouse" }, "[NAME/ID]")

function ab_switch()
	mouse[2] = not mouse[2]
	printf("info: Mouse successfully "..(mouse[2] == true and "enabled" or "disabled")..'.',nil,"MOUSE")
	if mouse[1] ~= nil then
		print2("Current Cursor: "..fstor[2][mouse[1]][2])
	end
	-- onUserEnableDisableCursor(mouse[1], mouse[2])
end
addCommand({ "switch" })

function ab_sens()
	local a = { }
	local b = "righthead"
	if not isStringForbidden(curcmd[1][2]) then
		a = split(curcmd[1][2],',')
		a =
		{
			tonumber(a[1]),
			tonumber(a[2])
		}
		if a[1] == nil or a[2] == nil then
			return print2("INFO: X,Y must be a float array.")
		end
		b = a[1]..','..a[2]
	else
   		usage()
	end
	mouse[5] = a
	print2("Successfully sens-set to: ("..a[1]..','..a[2]..").")
end
addCommand({ "sens" }, "(X,Y)")