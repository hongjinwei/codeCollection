local socket = require 'socket'
local round = 1000000
local tbl = {s=11000}
local time = socket.gettime()
for i=1,round do
    table.insert(tbl,1)
end

print("table.insert time :" .. (socket.gettime()-time)*1000 .. "ms")


local tbl = {s=11000}
local time = socket.gettime()
for i=1,round do
    tbl[#tbl+1] = 1
end

print("tbl[#tbl+1] time :" .. (socket.gettime()-time)*1000 .. "ms")


local tbl = {s=11000}
local insert = table.insert
local time = socket.gettime()
for i=1,round do
    insert(tbl,1) 
end

print("local insert time :" .. (socket.gettime()-time)*1000 .. "ms")





