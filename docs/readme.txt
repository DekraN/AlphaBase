AlphaBase HM7 v3.6 by Wesker aka DekraN
this is a simple homebrew which may help you for debugging your PSP

Installation:
Just copy this folder (AlphaBase HM7) in PSP/GAME/
and if you want, look up for set main vars into	SETTINGS.ini

A-Base is a lua-well-coded PSP Bash, made just for
debug all PSP Parts (or almost...), even if initially
it would be another PSP IDE...
I've personally tested a lot of function,
even if not all and they work perfectly ;D
I've performed the "plist" command,
it's now more powerful and lua-readable
(it tooks me one week to finish this...).
The P.S.E.R. parameters (Path Single Extension Requires)
have the noextension proof system, so, you can safely
omit the extension; however, it's highly recommended
to put it in any case to increase the execution speed.
Commands Helper: if you forgot the usage of a command,
just type it without parameters and A.B. will provide
to display you the usageprint and more informations
about the interested PSP parts; somehow just be careful that
some commands have the shortcut system (pre-imposted parameters) 
so they can execute unappropriate code for you.

A-Base is an object-based environment, so you can easily load
any element by typing "load [ELEMENT]" and use it for example
fontprinting a string using the font loaded.
'unload' command doesnt guarantee the effective unloading of
the elements (because some elements cannot be unloaded in any case),
but it just free the memory from the element-address.
You can simply get more information about the elements used
by typing "input (ID) (ID2)" where ID is the ID of the group
(0 for AlphaBase prints, 1 for User prints, 2 for Images,
3 for Rectangles (which aren't considered lines), 4 for Lines,
and 5 for Timers). You can also delete an User Execution
(did by imm, print, ... commands) by typing "res (ID) (ID2)"
If command gets no param, it will provide to reset all the groups,
else if it gets only one param, it will reset only the ID group
(look up from the ID's list).
To get PSP Information and all, just type 'info'. For cmdlist
type 'cmd'. Other useful stuffs are the current file system
and the current directory, respectively the one can be set by
'file' cmd, while the second by 'dir'. So, if current file is
'example.pbp', if you do 'eboot' AB will setup the first parameter
as the current file, while the Current Directory
just sets the working folder. You can also set the programme mode
right the normal and the extended. The normal mode is more powerful
and has a lot of function, while the extended gives more information
in AlphaBase prints. For the detailed COMMANDS LIST just see cmdlist.txt


							Regards, Wesker.



