local func_tbl = {  }


local af = function()
    print "a"
end
local bf = function()
    print "b"
end


table.insert(func_tbl,af)

table.insert(func_tbl,bf)

for _,func in pairs(func_tbl) do
    func()
end
