os.pullEvent = os.pullEventRaw




dofile("/system/sApi/dialog")

local function draw()
graphics.reset(colors.lightBlue)
term.setCursorPos(1, kernel.y)

graphics.drawLine(1, colors.lightGray)

term.setCursorPos(1, 1)

write("D")
end


local function shellDialog()
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


local function sleepX()
 animations.sleep()
 while true do
 		local event = os.pullEvent()
 		if event == "key" or event == "mouse_click" then
 			os.sleep(0.1)
 			animations.wake()
 			os.sleep(0.1)
 			draw()
 		end
 end
end

local menuData = {

[1] = { text = "Shut Down", handler = function() animations.sleep() os.shutdown() end },
[2] = { text = "Reboot", handler = function() animations.sleep() os.reboot() end },
[3] = { text = "Sleep", handler = function() sleepX() end },
[4] = { text = "Shell", handler = function() shellDialog() end }

}


--os.loadAPI("/system/tabserv")

draw()




local function PtF(file)
 local data = fs.open(file, "r")
 dataA = data:readAll()
 data.close()
 return dataA
end

--[[
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
]]--

local function menuServ()
	while true do
		if kernel.clickEvent(1, 1, 1 ) then
			term.setCursorPos(1, 1)
			menu.runMenu(menuData)
			menu.stopMenu()
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

parallel.waitForAll(sleepServ, menuServ)














