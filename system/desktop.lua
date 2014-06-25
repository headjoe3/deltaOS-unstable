os.pullEvent = os.pullEventRaw

dofile("/apis/dialog")

local function draw()
term.setBackgroundColor(colors.lightBlue)
term.clear()
term.setCursorPos(1, kernel.y)

kernel.drawLine(kernel.y, colors.lightGray)

term.setCursorPos(1, kernel.y)

write("D")
end
--os.loadAPI("/system/tabserv")

while true do
	if kernel.clickEvent(1, kernel.y, 2) then
		local d = dialog.new(nil, nil, nil, nil, "DeltaOS", {"Do you want to", "launch the shell?"}, true, false)
		if d:autoCaptureEvents() == true or d:autoCaptureEvents() == "ok" then
			term.clear()
			term.setCursorPos(1, 1)
			print("Type 'exit' to go back to deltaOS")
			shell.run("/rom/programs/shell")
			draw()
		end
	end
end



