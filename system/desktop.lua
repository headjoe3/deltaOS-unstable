os.pullEvent = os.pullEventRaw


local function clear()
term.setBackgroundColor(colors.lightBlue)
term.setTextColor(colors.black)
term.clear()
term.setCursorPos(1,1)
end
local function makeUI()
  w,h = term.getSize()
  local lucx = w/2-7
  local lucy = (h/2)-2
  term.setCursorPos(lucx,lucy)
  term.write("Login to DeltaOS:")
  term.setCursorPos(lucx,lucy+1)
  term.write("Username:")
  term.setCursorPos(lucx,lucy+3)
  term.write("Password:")
  term.setCursorPos(lucx,lucy+2)
  term.setBackgroundColor(colors.white)
  term.write("              ")
  term.setCursorPos(lucx,lucy+4)
  term.write("              ")
  return lucx,lucy
end
local function login_main()
while true do
clear()
local lucx,lucy = makeUI()
term.setCursorPos(lucx+1,lucy+2)
local name = read()
if not users.isUser(name) then
clear()
term.setCursorPos(lucx,lucy)
term.write("Not valid username")
sleep(3)
os.reboot()
end
term.setCursorPos(lucx+1,lucy+4)
local pass = read()
local realpass = users.getPassword(name)
if realpass ~= pass then
clear()
term.setCursorPos(lucx,lucy)
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
graphics.reset(colors.lightBlue)
term.setCursorPos(1, kernel.y)

graphics.drawLine(1, colors.lightGray)

term.setCursorPos(1, 1)

write("D")
end








--os.loadAPI("/system/tabserv")

draw()




local function PtF(file)
 local data = fs.open(file, "r")
 dataA = data:readAll()
 data.close()
 return dataA
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
			shell.run("/rom/programs/shell")
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
 		if event == "key" or event == "mouse_click" then
 			os.sleep(0.1)
 			animations.wake()
 			os.sleep(0.1)
 			draw()
 		end
 	end
 end
end

parallel.waitForAll(sleepServ, shellServ)














