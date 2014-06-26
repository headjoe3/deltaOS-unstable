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

shellServ()
