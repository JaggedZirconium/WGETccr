if not fs.exists(".settings") then
    shell.run("set shell.allow_disk_startup false")
end
if fs.exists("end") then
    fs.delete("end")
end
if fs.exists("recrosh") then
    fs.delete("recrosh")
end
local h = 0
if fs.exists("socket/main.lua") then
    tester = fs.open("socket/main.lua","r")
    tex = tester.readAll()
    tester.close()
    if fs.exists("blank.txt") then
        fs.delete("blank.txt")
    end
    shell.run("wget https://raw.githubusercontent.com/JaggedZirconium/WGETccr/main/socket/main.lua blank.txt")
    teste = fs.open("blank.txt","r")
    te = teste.readAll()
    teste.close()
    if tex ~= te then
        h = 1
        fs.delete("socket/main.lua")
        shell.run("wget https://raw.githubusercontent.com/JaggedZirconium/WGETccr/main/socket/main.lua socket/main.lua")
    end
end
tester = fs.open("startup/re.lua","r")
tex = tester.readAll()
tester.close()
if fs.exists("blank.txt") then
    fs.delete("blank.txt")
end
shell.run("wget https://raw.githubusercontent.com/JaggedZirconium/WGETccr/main/startup/re.lua blank.txt")
teste = fs.open("blank.txt","r")
te = teste.readAll()
teste.close()
if tex ~= te then
    h = 1
    fs.delete("startup/re.lua")
    shell.run("wget https://raw.githubusercontent.com/JaggedZirconium/WGETccr/main/startup/re.lua startup/re.lua")
end
if h = 1 then
    os.reboot()
end
function c1()
    webco.exec()
end
function c2()
    ws = webco.wsc()
end
function c3()
    webco.errorchecker()
end
function t()
    local sentim = 0
    local tim = os.startTimer(5)
    while true do
        sleep(0.1)
        local event, timeid = os.pullEvent()
        if event == "timer" and timeid == tim then
            sentim = sentim + 1;
            if sentim == 5 and ws then
                ws.send(' ')
                sentim = 0
            end
            tim = os.startTimer(5)
        end
    end
end
function start()
    webco = require("../socket/main")
    parallel.waitForAny(c2,c3)
    parallel.waitForAny(c1,t)
end
local ndone = true
function crosh()
    while true do
        if ndone then
            term.clear()
            term.setCursorPos(1,1)
            ndone = false
            shell.run("shell")
        end
        sleep(0.1)
    end
end

function en()
    while true do
        sleep(1)
        if fs.exists("end") then
            break
        end
    end
end
function shel()
    parallel.waitForAny(crosh,en)
end
function re()
    while true do
        if fs.exists("recrosh") then
            fs.delete("end")
            fs.delete("recrosh")
            term.clear()
            term.setCursorPos(1,1)
            shell.run("shell")
        end
        sleep(0.1)
    end
end
parallel.waitForAll(start,shel,re)
os.reboot()