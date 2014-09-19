local socket = require 'socket'
local round = 100000000
local x = 11000
local time = socket.gettime()
local num = 0.3333333333333
for i=1,round do
    x = x * num
end

print("x = x * (1/3)  :" .. (socket.gettime()-time)*1000 .. "ms")

local time = socket.gettime()
local num = 3
for i=1,round do
    x =  x / num 
end

print("x =  x / 3 :" .. (socket.gettime()-time)*1000 .. "ms")




