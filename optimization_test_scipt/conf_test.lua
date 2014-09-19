require 'conf_notbl'
local conf = require 'conf_table'

local socket = require 'socket'
local round = 10000000
local time = socket.gettime()
for i=1,round do
    local x = A
    local y = B
    local z = C
end

print("conf before :" .. (socket.gettime()-time)*1000 .. "ms")

local time = socket.gettime()
for i=1,round do
     local x = conf.A
    local y = conf.B
    local z = conf.C
end

print("conf table  :" .. (socket.gettime()-time)*1000 .. "ms")




