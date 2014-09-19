local Segments = require 'shared.classes.Segments'

local segments = Segments:new({cookie=bilin_user_id, domain = domain, url = url})
--Segments:fetch_data()
print(logger:tostring(segments))
