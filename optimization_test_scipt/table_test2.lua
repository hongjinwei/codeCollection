local socket = require 'socket'
local round = 10000000
local time = socket.gettime()
local s1 = {}
for i=1,round do
    s1.a = 1
    s1.b = 2
    s1.c = 3
end

print("s = {} :" .. (socket.gettime()-time)*1000 .. "ms")

local s2 = {nil, nil ,nil}
local time = socket.gettime()
for i=1,round do
    s2.a = 1
    s2.b = 2
    s2.c = 3
end

print("s = {nil,nil,nil}  :" .. (socket.gettime()-time)*1000 .. "ms")

local s3 = {}
s3[3] = true
s3[3] = nil
local time = socket.gettime()
for i=1,round do
    s3.a = 1
    s3.b = 2
    s3.c = 3
end

print("s[3] =nil  :" .. (socket.gettime()-time)*1000 .. "ms")



