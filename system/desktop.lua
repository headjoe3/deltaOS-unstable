--[[
Give all multitasking thanks to AssossaGPG, who coded the Tabbed Multitasking API.
Thank you, AssossaGPG :D
]]--

local w, h = term.getSize()

os.pullEvent = os.pullEventRaw

os.loadAPI("/apis/kernel")
os.loadAPI("/apis/tabmulti")
term.setBackgroundColor(colors.lightBlue)
kernel.reset()

function tabRun(program, name)
	tabmulti.newTab(shell.run(program), name)
end

local function paintDesktop()
	kernel.drawLine(kernel.y, colors.lightGray)
	term.setCursorPos(1, h)
	write("Term")
	while true do
		if kernel.spanClickEvent(1, h, 4, h, 1) then
			tabRun("/rom/programs/shell", "Shell")
		end
	end
end


--[ Tabbed MultiTasking Gui ]--
local tabScroll = 0

function drawArrows()
	term.setCursorPos(1,1)
	term.setBackgroundColor(colors.gray)
	term.setTextColor(colors.black)
	term.write("<")
	term.setCursorPos(kernel.x,1)
	term.setBackgroundColor(colors.gray)
	term.setTextColor(colors.black)
	term.write(">")
end

function drawTabs()
	local tabNames = tabmulti.getTabNames()
	local currentTab = tabmulti.getCurrentTab()
	
	for i,v in pairs(tabNames) do
		term.setCursorPos(i*5,1)
		term.setBackgroundColor(colors.white)
		term.setTextColor(colors.black)
		term.write(v:sub(1,4).."|")
	end
	
	drawArrows()
	
	if #tabNames <= math.floor(kernel.x / 5) then
		tabScroll = 0
	end
end

function tabClick()
	local lArrow = kernel.spanClickEvent(1,1,1,1,"left")
	local rArrow = kernel.spanClickEvent(kernel.x,1,kernel.x,1,"left")
	local tabClicks = {}
	
	for i=0,math.floor(kernel.x/5) do
		tabClicks[i+1] = kernel.spanClickEvent((i*5)+1, 1, (i*5)+6, 1, "left")
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
	tabmulti.newTab( paintDesktop, "DeltaOS" )
	tabmulti.switchTab("DeltaOS")
	while true do
		drawTabs()
		tabClick()
		tabmulti.runCurrentTab()
	end
end

basicMultitaskingCrap()
