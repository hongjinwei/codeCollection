local t = {}
function t.write()
local redis = require 'resty.redis'

local cookie_key = "c_a548f7ee-052a-4ec7-cebd-040fb432a571"
local cookie_value = "{segments={s1234={ttl=24,ct=23910}, s2314={ttl=36, ct=23145}, bk_1345={ttl=72, ct=25789}}, freq={total={c23456=1234,c34132=2345,c87930=131},daily={d1215={c23456=12,c34132=34}}},pbid={c23456=1.34,c34132=7.8,c87930=3.4},imp={c23456={win=1.2, bid=1.5, time=23456}, c34132={win=3.5, bid=4.2, time=23440}, c87930={win=4.5, bid=8.4, time=23395}}}"


local domain_key = "d_8aa40152139b0a90fddfb3975df2db92"
local domain_value ="{segments={d1234={ttl=240, ct=25789}, d1387={ttl=480, ct=25890}}}"


local url_key = "46754b0e034383309ea696be776ae40f"
local url_value = "{segments={u2234={ttl=240, ct=25789}, u2387={ttl=480, ct=25890}}}"


local URLS = {'172.18.0.175','172.18.0.180','172.18.0.216'}

for _,url in pairs(URLS) do

    local red,err = redis:new()

    if not red then 
        print("error create an object")
        return 
    end

    ok,err = red:connect(url,6379)
    if not ok then 
        print("failed to connect")
        return 
    end

    red:set(cookie_key,cookie_value)
    red:set(domain_key,domain_value)
    red:set(url_key,url_value)
end

end

return t
