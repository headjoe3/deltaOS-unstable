os.pullEvent = os.pullEventRaw

dofile("/system/sApi/dialog")

local function draw()
graphics.reset(colors.lightBlue)
term.setCursorPos(1, kernel.y)

graphics.drawLine(kernel.y, colors.lightGray)

term.setCursorPos(1, kernel.y)

write("D")
end
--os.loadAPI("/system/tabserv")

draw()


local function sleep()
 for i=1, kernel.y do
  graphics.drawLine(i, colors.black)
  sleep(0.6)
 end
end


local function PtF(file)
 local data = fs.open(file, "r")
 dataA = data:readAll()
 data.close()
 return dataA
end

local function shellServ() 
while true do
	if kernel.clickEvent(1, kernel.y, 2) then
		local d = Dialog.new(nil, nil, nil, nil, "DeltaOS", {"Do you want to", "launch the shell?"}, true,true)
		if d:autoCaptureEvents() == "ok" then
			graphics.reset(colors.black, colors.white)
			print("Run 'exit' to go back to deltaOS")
			shell.run("/rom/programs/shell")
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
 		sleep()
 		local event = os.pullEvent()
 		if event == "key" or event == "mouse_click" then
 			draw()
 		end
 	end
 end
end

parallel.waitForAll(sleepServ, shellServ)














