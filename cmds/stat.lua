-- stat.lua by Wesker aka DekraN for AlphaBase HM7
-- UPDATED at 09/10/2009, version 1.0.0


function ab_sby()
	print2("*** STANDBY MODE ***")
	System.suspend()
end
addCommand({ "sby" })

function ab_sdown()
	print2("*** SHUTDOWN ***")
	System.shutdown()
end
addCommand({ "sdown" })

function ab_sleep()
	if isStringForbidden(curcmd[1][2]) then
		return usage()
	end
	local a = tonumber(curcmd[1][2])
	if a == nil or a < 0 then
		return print2("INFO: SECONDS must be an integer.")
	end
	print2("*** SLEEP FOR "..a.." SECONDS ***")
	System.sleep(a*1000)
end
addCommand({ "sleep" }, "(SECONDS)")

function ab_quit()
	setupFor()
end
addCommand({ "quit", 'q' })

function ab_oload()
	print2("*** OVERLOAD ***")
	setupFor()
end
addCommand({ "oload" })
