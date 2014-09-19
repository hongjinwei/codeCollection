
local socket = require 'socket'
local a = {1}
loop = 100000
local next = next 
local getn = table.getn


local time = socket.gettime()
for i=1,loop do
    if next(a) then 
       -- print("next")
    end
end
print((socket.gettime()-time)*1000)


local time = socket.gettime()
for i=1,loop do
    if getn(a) > 0 then 
        --print("getn")
    end
end

print((socket.gettime()-time)*1000)
