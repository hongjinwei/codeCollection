local t = {}

function t.is1(x)
    if x == 1 then
        print("true")
    else 
        print("false")
    end
end


t:is1(1)
t.is1(1)
self:is1(1)
function a()
    print(t:is1(1))

end

a()
--self:is1(1)
--self.is1(1)

