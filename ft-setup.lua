
local function setup()
graphics.reset(colors.lightGray, colors.black)
graphics.cPrint("DeltaOS first-time setup")


print("")
graphics.cPrint("I. User setup")
print("")

paintutils.drawLine(2, kernel.y/2, kernel.x-1, kernel.y/2, colors.gray)

paintutils.drawLine(2, kernel.y/2+4, kernel.x-1, kernel.y/2+4, colors.gray)

term.setCursorPos(1, kernel.y/2-1)
term.setBackgroundColor(colors.lightGray)


graphics.cPrint("Username:")

term.setCursorPos(1, kernel.y/2+3)

graphics.cPrint("Password: ")

term.setCursorPos(2, kernel.y/2)
term.setBackgroundColor(colors.gray)
local user = read()

term.setCursorPos(2, kernel.y/2+4)

local pass = sha256.hash( read("*") )

users.newUser(user, pass)

graphics.reset(colors.lightGray, colors.black)

graphics.cPrint("DeltaOS first-time setup")
print("")
graphics.cPrint("II. Computer name")

paintutils.drawLine(2, kernel.y/2, kernel.x-1, kernel.y/2, colors.gray)


term.setCursorPos(1, kernel.y/2-2)

term.setBackgroundColor(colors.lightGray)

graphics.cPrint("Computer label/name: ")

term.setCursorPos(2, kernel.y/2)

term.setBackgroundColor(colors.gray)

local label = read()

os.setComputerLabel(label)

graphics.reset(colors.lightGray, colors.black)

graphics.reset(colors.lightGray, colors.black)



graphics.reset(colors.lightGray, colors.black)
graphics.cPrint("First time setup is finished.")
graphics.cPrint("DeltaOS will reboot.")
sleep(0.6)
fs.delete("/system/.setup_trigger")
os.reboot()
end

local x = kernel.catnip(setup)
if x ~= "noErr" then 
  graphics.reset(colors.blue, colors.white)
  print("")
  term.setBackgroundColor(colors.white)
  term.setBackgroundColor(colors.black)
  graphics.cPrint("DeltaOS")
  term.setBackgroundColor(colors.blue)
  term.setTextColor(colors.black)
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
  
  
  


