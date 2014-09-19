local socket = require 'socket'

local time = socket.gettime()
local  Dad = {}

func_tbl = { 
        Dad.son1,
        Dad.son2
    }



 Dad.son1 = function()
    --print "a"
end
 Dad.son2 = function()
   -- print "b"
end

--table.insert(func_tbl,af)

--table.insert(func_tbl,bf)
for i=1,10000 do 
    for _,func in ipairs(func_tbl) do 
        func_tbl()
    end
end


print("before" .. (socket.gettime()-time)*1000  .. "ms")
local socket = require 'socket'

local time = socket.gettime()
local  Dad = {}



 Dad.son1 = function()
    --print "a"
end
 Dad.son2 = function()
   -- print "b"
end
func_tbl1 = { 
        Dad.son1,
        Dad.son2
    }


--table.insert(func_tbl,af)

--table.insert(func_tbl,bf)
for i=1,10000 do 
    for _func in ipairs(func_tbl) do 
        func()
    end
end


print("after" .. (socket.gettime()-time)*1000  .. "ms")
