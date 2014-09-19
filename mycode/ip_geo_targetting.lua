--local redis = require 'redis'
local modf = math.modf
local gsub = string.gsub
local insert = table.insert
local bit = require 'bit'
--client = redis.connect('unix:///tmp/redis.sock')

local ip = {}
MAX = 32
MIN = 16
MASK = {
    ['128.0.0.0'] = 1 , 
    ['192.0.0.0'] = 2 ,
    ['224.0.0.0'] = 3 ,
    ['240.0.0.0'] = 4 ,
    ['248.0.0.0'] = 5 ,
    ['252.0.0.0'] = 6 ,
    ['254.0.0.0'] = 7 ,
    ['255.0.0.0'] = 8 ,
    ['255.128.0.0'] = 9 ,  
    ['255.192.0.0'] = 10,
    ['255.224.0.0'] = 11,
    ['255.240.0.0'] = 12,
    ['255.248.0.0'] = 13,
    ['255.252.0.0'] = 14,
    ['255.254.0.0'] = 15,
    ['255.255.0.0'] = 16,
    ['255.255.128.0'] = 17,
    ['255.255.192.0'] = 18,
    ['255.255.224.0'] = 19,
    ['255.255.240.0'] = 20,
    ['255.255.248.0'] = 21,
    ['255.255.252.0'] = 22,
    ['255.255.254.0'] = 23,
    ['255.255.255.0'] = 24,
    ['255.255.255.128'] = 25,
    ['255.255.255.192'] = 26,
    ['255.255.255.224'] = 27,
    ['255.255.255.240'] = 28,
    ['255.255.255.248'] = 29,
    ['255.255.255.252'] = 30,
    ['255.255.255.254'] = 31,
    ['255.255.255.255'] = 32
}

local function roof(num)
    local int = modf(num)    
    return int + 1
end

local function floor(num)
    local int = modf(num)
    return int
end

local function split(str, sep)
    if not str then return nil end
    local t = {}
    gsub(str,'[^'..sep..']+', function(w) insert(t,tonumber(w)) end )
    return t
end

local function zoom(ip_part, i)
    return ip_part * (256 ^ (4 - i))
end
--given 192, 4 means cut the bit 1100 0000 
--return 1100 's hex 'C0'
local function tail_key(ip_part, tail_len)
    if tail_len > 0 then 
        return bit.arshift(ip_part,tail_len)
    else
        return 0
    end
end

--return ip2netid,
--1111 1111 1001 1101 1101 0011 0001 0001
--                            ^
--                            p  = 24
--return tonumber(1111 1111 1001 1101 1101 0011,2)
local function ip2netid(ip, p)
    local head_part = modf(p / 8)
    local tail_len = p - head_part * 8
    local key = 0
    for i=1, head_part do 
        key = key + zoom(ip[i], i)
    end
    local j = head_part + 1 
    if j > 4 then 
        return key
    end
    return key + tail_key(ip[j], tail_len)
end

--given an ip and maskcode, return network id
local function ip2key(ip, mask)
    if not ip or not mask then 
        return nil, 'lack of arguments'
    end
    p = MASK[mask] 
    if not p then 
        return nil, "error shelter"
    end
    local ip = split(ip, '.')
    return ip2netid(ip, p)
end

local function get(ip, p)
    local key = ip2netid(ip, p)
    geo_info = redis:get(key)
    return geo_info
end
--print(MASK['255.255.0.0'])
--print(ip2key('192.168.0.1','255.255.128.0'))
--print(zoom(192,1))
function ip.set(ip, mask, geo_info)
    if not ip or not geo_info then 
        return nil, 'empty arguments'
    end
    key = ip2key(ip, mask)
    redis:set(key, geo_info)
end


function ip.consult(ip)
    local head, tail = MAX, MIN
    local p = floor((head + tail)/2)
    ip = split(ip)
    while(head >= tail) do
        local geo_info = get(ip, p)
        if geo_info then 
            head = p
            if head == tail then 
                return geo_info 
            end
            p = roof((tail + head)/2)
        else
            tail = p - 1
            p = floor((tail+head)/2)
        end
    end 
    return nil
end

sip = {1,2,3,4,5,6,7,8}
function consult(ip)
    local head, tail = 1,8
    local p = floor((head + tail)/2)
    print(p)
    while(tail >= head ) do 
        local n = (sip[p] == ip )
        print('p:',p)
        if n then 
            head = p
            if head == tail then 
               return sip[p]
            end
            p = roof((tail + head)/2)
        else
            tail = p - 1
            p = floor((tail+head)/2)
        end 
    end
    return nil
end

print(consult(3))
