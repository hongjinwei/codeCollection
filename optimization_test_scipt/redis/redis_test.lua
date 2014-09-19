local redis = require 'resty.redis'
local red = redis:new()
local HOST = "r1.bilintechnology.net" 
local PORT = 6379

red:set_timeout(1000) -- 1sec
local ok, err = red:connect(HOST,PORT) 
if not ok then 
    print("connect fail:" ..  err)
    return
end
    ok,err = red:set("dog","an animal")

if not ok then 
    print("set fail:" .. err)
    return 
end

print("set result:" .. ok)

local res,err = red:get("dog")

if not res then 
    print("failed to get dog:" .. err)
    return 
end

if res == nil then 
    print("nil response")
else
    print("dog:" .. res)
end
