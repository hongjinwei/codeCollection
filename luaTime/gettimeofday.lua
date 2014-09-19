local ffi = require 'ffi'

ffi.cdef[[
    
    typedef struct timeval{
        long tv_sec;
        long tv_usec;
    } timeval;

    int gettimeofday(struct timeval *tv, void* tzp);

]]

--local timenow = ffi.string(utime.gettime())
--ffi.copy(timenow, utime.gettime())
--timenow = ffi.C.gettime()
--print(timenow)
local tv = ffi.new("timeval")
ffi.C.gettimeofday(tv, nil)
print(tv.tv_sec .. '.' .. tv.tv_usec)
