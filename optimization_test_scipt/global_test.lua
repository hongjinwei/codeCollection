local socket = require 'socket'
local round = 10000000
x = {}
y={nil,nil,nil}
z= {a=nil,b=nil,c=nil}

local time = socket.gettime()
for i=1,round do
    if i % 3 == 0 then
        x.a = 1
    elseif i % 3 == 1 then
        x.b = 1
    else 
        x.c = 1
    end
end

print("{} time:" .. (socket.gettime()-time)*1000 .. "ms")

local time = socket.gettime()
for i=1,round do
    if i % 3 == 0 then
        y.a = 1
    elseif i % 3 == 1 then
        y.b = 1
    else 
        y.c = 1
    end
end

print("{nil,nil,nil} time:" .. (socket.gettime()-time)*1000 .. "ms")

local time = socket.gettime()
for i=1,round do
    if i % 3 == 0 then
        z.a = 1
    elseif i % 3 == 1 then
        z.b = 1
    else 
        z.c = 1
    end
end

print("{a=nil,b=nil,c=nil} time:" .. (socket.gettime()-time)*1000 .. "ms")







