os.pullEvent = os.pullEventRaw


local function mainDesktop()

isUnstable = true
build = "7"
fullBuildName = "DeltaOS Unstable(build "..build..")"

os.loadAPI("/apis/users")

local function clear()
term.current().setBackgroundColor(colors.lightBlue)
term.current().setTextColor(colors.black)
term.current().clear()
term.current().setCursorPos(1,1)
end
local function makeUI()
  w,h = term.current().getSize()
  local lucx = w/2-7
  local lucy = (h/2)-2
  term.current().setCursorPos(lucx,lucy)
  term.current().write("Login to DeltaOS:")
  term.current().setCursorPos(lucx,lucy+1)
  term.current().write("Username:")
  term.current().setCursorPos(lucx,lucy+3)
  term.current().write("Password:")
  term.current().setCursorPos(lucx,lucy+2)
  term.current().setBackgroundColor(colors.white)
  term.current().write("              ")
  term.current().setCursorPos(lucx,lucy+4)
  term.current().write("              ")
  return lucx,lucy
end
local function login_main()
while true do
clear()
local lucx,lucy = makeUI()
term.current().setCursorPos(lucx+1,lucy+2)
local name = read()
if not users.isUser(name) then
clear()
term.current().setCursorPos(lucx,lucy)
term.current().write("Not valid username")
sleep(3)
os.reboot()
end
term.current().setCursorPos(lucx+1,lucy+4)
local pass = read("*")
local realpass = users.getPassword(name)
if realpass ~= pass then
clear()
term.current().setCursorPos(lucx,lucy)
term.write("Password incorrect")
sleep(3)
os.reboot()
else
users.login(name)
return
end
end
end
login_main()
dofile("/system/sApi/dialog")

local function draw()
graphics.reset( colors.lightBlue )
term.current().setCursorPos(1, kernel.y)

graphics.drawLine(1, colors.lightGray)

term.current().setCursorPos(1, 1)

write("D")

if isUnstable then
 term.current().setBackgroundColor( colors.lightBlue )
 term.current().setCursorPos(kernel.x-string.len(fullBuildName), kernel.y)
 write(fullBuildName)
 term.current().setCursorPos(1, 1)
end

end







--os.loadAPI("/system/tabserv")

draw()




local function PtF(file)
 local data = fs.open(file, "r")
 dataA = data:readAll()
 data.close()
 loadfile(PtF)
end

local function shellPTF()
	 loadfile( "/rom/programs/shell" )
end


local function shellServ() 
while true do
	if kernel.clickEvent(1, 1, 2) then
		local d = Dialog.new(nil, nil, nil, nil, "DeltaOS", {"Do you want to", "launch the shell?"}, true,true)
		if d:autoCaptureEvents() == "ok" then
			draw()
			animations.closeIn()
			graphics.reset(colors.black, colors.white)
			
			print("Run 'exit' to go back to deltaOS")
			local err = kernel.catnip(shellPTF)
			if err ~= "noErr" then
				delta.bsod(err)
			end
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

parallel.waitForAll(sleepServ, shellServ)


end

local x = kernel.catnip(mainDesktop)
if x ~= "noErr" then 
  graphics.reset(colors.blue, colors.white)
  print("")
  term.setTextColor(colors.black)
  term.setBackgroundColor(colors.white)
  graphics.cPrint("DeltaOS")
  term.setBackgroundColor(colors.blue)
  term.setTextColor(colors.white)
  print("")
  graphics.cPrint("An error has occured.")
  graphics.cPrint("The error is: "..x)
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
  











