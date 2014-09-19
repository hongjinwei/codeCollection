local socket = require 'socket'
loop = 1000000

function func1() 
local Dad = {}

local son1 = function()
    local x = 1
end

local son2 = function()
    local x = 2
end

local Dad = {
        son1,
        son2
    }

for i=1,2 do
   Dad[i]()
end
end


function func2() 
local Daddy = {}

Daddy.sonny1 = function()
    local x = 1
end

Daddy.sonny2 = function()
    local x = 2
end

local func_tbl = {
        Daddy.sonny1,
        Daddy.sonny2
    }

for i=1,2 do
    func_tbl[i]()  
end
end

local time = socket.gettime()
for i=1,loop do
    func1()
end
print((socket.gettime()-time)*1000)

local time = socket.gettime()
for i=1,loop do
    func2()
end


print((socket.gettime()-time)*1000)




