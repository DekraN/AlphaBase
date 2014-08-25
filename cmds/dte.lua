-- dte.lua by Wesker aka DekraN for AlphaBase HM7
-- UPDATED at 09/10/2009, version 1.0.0


function ab_exec()
	if isStringForbidden(curcmd[2][2]) then
		return
		usage({1}),
		sendInput(mode == 1
		and "print INFO: http://wiki.ps2dev.org/psp:lua_player:functions" or "help 1")
	end
	if mode == 0 then
		if access() == -1 then
			curcmd[2][2] = curcmd[2][2]:gsub("sysData",'')
		end
	else
		print2("INPUT: "..curcmd[2][2])
	end
	loadstring(curcmd[2][2])()
end
addCommand({ "exec" }, "[EXPRESSION]")

function ab_asrt()
	if isStringForbidden(curcmd[3][1]) then
		return usage()
	end
	if mode == 1 then
		print2("ASSERT: \""..curcmd[3][1].."\"")
	end
	local a = isStringForbidden(curcmd[3][2]) and 0 or tonumber(curcmd[3][2])
	if a == nil or (a ~= 0 and a ~= 1) then
		return print2("INFO: MODE must be a boolean value (0 for Light Assert, 1 for Heavy Assert).")
	end
	loadstring[3](a == 0 and
	"printf(\"RESULT: \"..("..curcmd[3][1].." == true and \"true\" or \"false\")..'.',{0,mode})"
	or "assert("..curcmd[3][1]..(isStringForbidden(curcmd[3][3]) and ')' or ",\""..curcmd[3][3].."\")"))()
end
addCommand({ "asrt" }, "[EXPRESSION]~(MODE)~(STRING)")

function ab_calc()
	if isStringForbidden(curcmd[2][2]) then
		return usage()
	end
  	loadstring("printf(\"RESULT: \"..parse("..curcmd[2][2].."),{0,mode})")()
end
addCommand({ "calc" }, "[EXPRESSION]")