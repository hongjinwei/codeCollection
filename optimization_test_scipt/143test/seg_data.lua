local md5 = require 'md5' 
data = {domain="baidu3.com",cookie="a548f7ee-052a-4ec7-cebd-040fb432a571",url="www.baidu3.com"}

print("domian: " .. md5.sumhexa(data.domain))
print("url   : " .. md5.sumhexa(data.url))
print("cookie: " .. data.cookie)

