 bar = {}
local foo = foo or require 'foo'


bar.name = "bar"
function bar:getname()
    return foo.name .. bar.name
end


return bar
