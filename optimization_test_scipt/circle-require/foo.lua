 foo = {}
local  bar = bar or require 'bar'

foo.name = "foo"
function foo:getname()
    return bar.name .. foo.name 
end

return foo
