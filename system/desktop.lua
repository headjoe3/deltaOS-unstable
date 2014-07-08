os.pullEvent = os.pullEventRaw




local function mainDesktop()

n = {  }
local isAppOpen = false
local redraw = false


isUnstable = true
build = "26"
fullBuildName = "DeltaOS Unstable(build "..build..")"

os.loadAPI("/apis/users")


local function getC()
 return term.current()
 
end

local gc = getC()



graphics.drawImage("/system/delta.nfp", 1, 1)


local lw = window.create( term.current(), kernel.x/2-30/2, kernel.y/2-10/2, 30, 10, true )

term.redirect(lw)


local latestBuild = http.get("https://raw.githubusercontent.com/FlareHAX0R/deltaOS-unstable/master/version")
if latestBuild:readAll() ~= build then
	shell.run("/system/update")
end

while true do
graphics.reset(colors.white, colors.black)

graphics.cPrint("DeltaOS login")
print("")
graphics.cPrint("Username:")

local ww, wh = lw.getSize()

paintutils.drawLine( 2, 4, ww-1, 4, colors.lightGray )

print("")
lw.setBackgroundColor(colors.white)
term.setCursorPos(1, 7)
graphics.cPrint("Password: ")
paintutils.drawLine( 2, 9, ww-1, 9, colors.lightGray )

term.setCursorPos(2, 4)
local user = tostring( read() )


term.setCursorPos(2, 9)
local pass = tostring( sha256.hash(read("*")) )


if users.isUser(user) == true and pass == users.getPassword(user) then
	local cw, ch = lw.getSize()
	graphics.reset(colors.white, colors.black)
	lw.setCursorPos(1, ch/2)
	graphics.cPrint("Logging in user")
	graphics.cPrint(user.."...")
	sleep(0.6)
	users.login(user)
	lw.setVisible(false)
	term.redirect( term.native() )
	animations.wake()
else
	local cw, ch = lw.getSize()
	graphics.reset(colors.white, colors.black)
	lw.setCursorPos(1, 2)
	graphics.cPrint("Login failed.")
	print("")
	lw.setCursorPos(1, ch/2)
	if users.isUser(user) and users.getPassword(user) == false then
		graphics.cPrint("Password incorrect.")
		sleep(0.6)
		os.reboot()
	elseif users.isUser(user) == false then
		graphics.cPrint("No such user.")
		sleep(0.6)
		os.reboot()
	else
		graphics.cPrint("Unknown Error.")
		sleep(0.6)
		os.reboot()
	end
end
--end
	




dofile("/system/sApi/dialog")


local function drawBar()
	graphics.drawLine(1, colors.lightGray)

	term.current().setCursorPos( kernel.x-(kernel.x-1), kernel.y-(kernel.y-1))

	term.current().write("D")
end

local function draw()
graphics.reset( colors.lightBlue, colors.black )
term.current().setCursorPos(kernel.x-(kernel.x-1), 1)

drawBar()

if isUnstable then
 term.current().setBackgroundColor( colors.lightBlue )
 term.current().setCursorPos(kernel.x-string.len(fullBuildName), kernel.y)
 write(fullBuildName)
 term.current().setCursorPos(1, 1)
end

end







--os.loadAPI("/system/tabserv")

draw()




local function shellServ() 
while true do
	if kernel.clickEvent(kernel.x-(kernel.x-1), kernel.y-(kernel.y-1), 2) then
		local d = Dialog.new(nil, nil, nil, nil, "DeltaOS", {"Do you want to", "launch the shell?"}, true,true)
		if d:autoCaptureEvents() == "ok" then
			draw()
			animations.closeIn()
			graphics.reset(colors.black, colors.white)
			--term.setCursorPos(1, 2)
			--isAppOpen = true
			print("Run 'exit' to go back to deltaOS")
			shell.run("/rom/programs/shell")
			--isAppOpen = false
			animations.wake()
			draw()
		else
			
			draw()
		end
	end
end
end



local function sleepServ()
 while true do
 	local event, key = os.pullEvent("key")
 	if key == 59 then
 		animations.sleep()
 		local event = os.pullEvent()
 		if event == "key" or event == "mouse_click" or event == "monitor_touch" then
 			os.sleep(0.1)
 			animations.wake()
 			os.sleep(0.1)
 			draw()
 		end
 	end
 end
end



local function rServ()
	while true do
		local event = os.pullEvent()
		if event == "term_resize" or event == "monitor_resize" then
			draw()
		end
	end
end






parallel.waitForAll(sleepServ, shellServ, rServ)
end

end

local err = kernel.catnip(mainDesktop)
if err ~= "noErr" then 
  graphics.reset(colors.blue, colors.white)
  print("")
  term.current().setTextColor(colors.black)
  term.current().setBackgroundColor(colors.white)
  graphics.cPrint("DeltaOS")
  term.current().setBackgroundColor(colors.blue)
  term.current().setTextColor(colors.white)
  print("")
  graphics.cPrint("An error has occured.")
  graphics.cPrint("The error is: "..tostring(x))
  print("")
  graphics.cPrint("Please report this error to ")
  graphics.cPrint("the deltaOS repo.")
  print("")
  graphics.cPrint("DeltaOS Unstable repo: ")
  graphics.cPrint("https://github.com/FlareHAX0R/deltaOS-unstable")
  print("")
  graphics.cPrint("DeltaOS Stable repo: ")
  graphics.cPrint("https://github.com/FlareHAX0R/deltaOS")
  print("")
  graphics.cPrint("Press any key to continue.")
  while true do
     local event = os.pullEvent()
     if event == "key" or "mouse_click" or "monitor_touch" then
       os.reboot()
     end
  end
end
  





