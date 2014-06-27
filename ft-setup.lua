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

local pass = read("*")

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

graphics.cPrint("First time setup is finished.")
graphics.cPrint("DeltaOS will reboot.")




