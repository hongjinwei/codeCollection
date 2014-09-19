local socket = require 'socket'

local loop = 100000
local tbl = {}
for i=1,1000 do 
   table.insert(tbl,i)
end

local t_len = table.getn(tbl)
---------------
local for_func = function()
    for i=1,t_len do 
        local s = (s or 0 )+ tbl[i]
    end
end

local ipairs_func = function()
    for i in ipairs(tbl) do
       local s = (s or 0) + tbl[i]
    end
end

local time = socket.gettime()

for j=1,loop do
    for_func()
end

print("for_func time:" .. (socket.gettime()-time)*1000 .. "ms")

local time = socket.gettime()

for j=1,loop do
    ipairs_func()
end

print("ipairs_func time:" .. (socket.gettime() - time)*1000 .. "ms")



