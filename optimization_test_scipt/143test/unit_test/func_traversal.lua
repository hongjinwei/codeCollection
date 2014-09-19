local socket = require 'socket'
local pairs = pairs
local ipairs = ipairs
local loop = 1000000

local func_tbl = { type1 = {}, 
                   type2 = {},
                   type3 = {}
       }


func_list_tbl = {
 func_tbl.type2.t1,
 func_tbl.type2.t2,
 func_tbl.type2.t3,
 func_tbl.type2.t4,
 func_tbl.type2.t5,
 func_tbl.type2.t6,
 func_tbl.type2.t7,
 func_tbl.type2.t8 
}
func_name_list = {'t1','t2','t3','t4','t5','t6','t7','t8'}

func_tbl.type1.t1 = function()
end


func_tbl.type1.t2 = function()
end


func_tbl.type1.t3 = function()
end



func_tbl.type2.t1 = function()
end

func_tbl.type2.t2 = function()
end


func_tbl.type2.t3 = function()
end

func_tbl.type2.t4 = function()
end


func_tbl.type2.t5 = function()
end


func_tbl.type2.t6 = function()
end


func_tbl.type2.t7 = function()
end


func_tbl.type2.t8 = function()
end



func_tbl.type3.t1 = function()
end


func_tbl.type3.t1 = function()
end


func_tbl.type3.t1 = function()
end


func_tbl.type3.t1 = function()
end

func_tbl.type3.t1 = function()
end


function func_tbl.type2_traversal()
    for k,func in pairs(func_tbl.type2) do
        if type(func) == 'function' then
            func()
        end

    end
end

function func_tbl.doeach()
    func_tbl.type2.t1()
    func_tbl.type2.t2()
    func_tbl.type2.t3()
    func_tbl.type2.t4()
    func_tbl.type2.t5()
    func_tbl.type2.t6()
    func_tbl.type2.t7()
    func_tbl.type2.t8()
end
local time = socket.gettime()

for i=1,loop do
    func_tbl.type2_traversal()
end

print("traversal time:" .. (socket.gettime()-time)*1000 .. "ms")

print("per time:" .. (socket.gettime()-time)*1000/loop .. "ms")

local time = socket.gettime()

for i=1,loop do
    func_tbl.doeach()
end

print("doeach time:" .. (socket.gettime()-time)*1000 .. "ms")

print("per time:" .. (socket.gettime()-time)*1000/loop .. "ms")


local time = socket.gettime()
local t = #func_name_list
for i=1,loop do
    
    for i=1,t do--#func_name_list do
        func_tbl.type2[func_name_list[i]]()
    end
end

print("num  name list time:" .. (socket.gettime()-time)*1000 .. "ms")

print("per name list time:" .. (socket.gettime()-time)*1000/loop .. "ms")


local time = socket.gettime()

for i=1,loop do
    for i=1,#func_name_list do
        func_tbl.type2[func_name_list[i]]()
    end
end

print("# name list time:" .. (socket.gettime()-time)*1000 .. "ms")

print("per name list time:" .. (socket.gettime()-time)*1000/loop .. "ms")


local time = socket.gettime()
local t = #func_name_list
for i=1,loop do
    
    for _,v in ipairs(func_name_list) do--#func_name_list do
        func_tbl.type2[v]()
    end
end

print("func pairs time:" .. (socket.gettime()-time)*1000 .. "ms")

print("per  time:" .. (socket.gettime()-time)*1000/loop .. "ms")


local time = socket.gettime()
for i=1,loop do
    
    for _,func in ipairs(func_list_tbl) do--#func_name_list do
        func()
    end
end

print("func table time:" .. (socket.gettime()-time)*1000 .. "ms")

print("per  time:" .. (socket.gettime()-time)*1000/loop .. "ms")


