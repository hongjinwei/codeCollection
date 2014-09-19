local ffi = require 'ffi'
local utime = ffi.load('time')
ffi.cdef[[
     int hello(); 
     char *gettime(void);

]]

local s = utime.hello()
local timenow = ffi.string(utime.gettime())
print(timenow)
--ffi.copy(timenow, utime.gettime())
--timenow = ffi.C.gettime()
--print(timenow)
