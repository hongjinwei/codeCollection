local socket = require 'socket'
local round = 100000000
local x = 0
local time = socket.gettime()
for i=1,round do
    x = x + 1
end

print("x = x + 1 :" .. (socket.gettime()-time)*1000 .. "ms")

local time = socket.gettime()
for i=1,round do
    x = 1 + x 
end

print("x = 1 + x  :" .. (socket.gettime()-time)*1000 .. "ms")




