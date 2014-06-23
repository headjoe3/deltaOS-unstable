--[[

Give all multitasking thanks to AssossaGPG, who coded the Multitasking API.
Thank you, AssossaGPG :D

]]--

os.pullEvent = os.pullEventRaw




os.loadAPI("kernel")
os.loadAPI("tabmulti")
term.setBackgroundColor(colors.lightBlue)
kernel.reset()

function tabRun(program, name)
	tabmulti.newTab( shell.run(program), name )
end


local function drawDesktop()
	kernel.drawLine(kernel.y, colors.lightGray)
	term.setCursorPos(1, kernel.y)
	write("Term")
	while true do
		--if tabmulti.getCurrentTab() == "DeltaOS"
		if kernel.spanClickEvent(1, kernel.y, 4, kernel.y, 1) then
			tabRun("/rom/programs/shell", "Shell")
		end
	    --end
	end

end


--[ Tabbed MultiTasking Gui ]--
local tabScroll = 0

function drawArrows()
	term.setCursorPos(1,kernel.y)
	term.setBackgroundColor(colors.gray)
	term.write("<")
	term.setCursorPos(kernel.x,kernel.y)
	term.setBackgroundColor(colors.gray)
	term.write(">")
end

function drawTabs()
	local tabNames = tabmulti.getTabNames()
	local currentTab = tabmulti.getCurrentTab()
	
	for i,v in pairs(tabNames) do
		term.setCursorPos(i*5,kernel.y)
		term.setBackgroundColor(colors.white)
		term.write(v:sub(1,4).."|")
	end
	
	if #tabNames >= math.floor(kernel.x / 5) then
		drawArrows()
	else
		tabScroll = 0
	end
end

function tabClick()
	local lArrow = kernel.spanClickEvent(1,kernel.y,1,kernel.y,"left")
	local rArrow = kernel.spanClickEvent(kernel.x,kernel.y,kernel.x,kernel.y,"left")
	local tabClicks = {}
	
	for i=0,math.floor(kernel.x/5) do
		tabClicks[i+1] = kernel.spanClickEvent((i*5)+1, (i*5)+6, (i*5)+1, (i*5)+6, "left")
	end
	
	if lArrow and tabScroll > 0 then
		tabScroll = tabScroll - 1
	end
	if rArrow and tabScroll < #tabmulti.getTabs() * 5 then
		tabScroll = tabScroll + 1
	end
	for i,v in pairs(tabClicks) do
		if v then
			tabmulti.switchTab(i+math.floor(tabScroll/5))
		end
	end
end




local function basicMultitaskingCrap()
 tabmulti.newTab( drawDesktop, "DeltaOS" )
 while true do
 	drawTabs()
 	tabClick()
 	tabmulti.runCurrentTab()
 end
end





basicMultitaskingCrap()





