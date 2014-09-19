local ffi = require 'ffi'
ffi.cdef[[
    typedef struct a{
        const static int a=10;
        const static int b=11;
    }a;
    
    struct b{
        int a;
        int b;
    };
]]

local s = ffi.new("struct a")
local w = ffi.new("struct b")
w.a, w.b = 3,5
print(w.a, w.b)
print(s.a,s.b)
