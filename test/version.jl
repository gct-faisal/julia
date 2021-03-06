# This file is a part of Julia. License is MIT: http://julialang.org/license

# parsing tests

@test v"1" == VersionNumber(1)
@test v"2.1" == VersionNumber(2, 1)
@test v"3.2.1" == VersionNumber(3, 2, 1)

@test v"2-1" == VersionNumber(2, 0, 0, (1,), ())
@test v"3.2-1" == VersionNumber(3, 2, 0, (1,), ())
@test v"4.3.2-1" == VersionNumber(4, 3, 2, (1,), ())

@test v"1-a" == VersionNumber(1, 0, 0, ("a",), ()) == v"1a"
@test v"2.1-a" == VersionNumber(2, 1, 0, ("a",), ()) == v"2.1a"
@test v"3.2.1-a" == VersionNumber(3, 2, 1, ("a",), ()) == v"3.2.1a"

@test v"2-a1" == VersionNumber(2, 0, 0, ("a1",), ()) == v"2a1"
@test v"3.2-a1" == VersionNumber(3, 2, 0, ("a1",), ()) == v"3.2a1"
@test v"4.3.2-a1" == VersionNumber(4, 3, 2, ("a1",), ()) == v"4.3.2a1"

@test v"2-1a" == VersionNumber(2, 0, 0, ("1a",), ())
@test v"3.2-1a" == VersionNumber(3, 2, 0, ("1a",), ())
@test v"4.3.2-1a" == VersionNumber(4, 3, 2, ("1a",), ())

@test v"2-a.1" == VersionNumber(2, 0, 0, ("a", 1), ()) == v"2a.1"
@test v"3.2-a.1" == VersionNumber(3, 2, 0, ("a", 1), ()) == v"3.2a.1"
@test v"4.3.2-a.1" == VersionNumber(4, 3, 2, ("a", 1), ()) == v"4.3.2a.1"

@test v"2-1.a" == VersionNumber(2, 0, 0, (1, "a"), ())
@test v"3.2-1.a" == VersionNumber(3, 2, 0, (1, "a"), ())
@test v"4.3.2-1.a" == VersionNumber(4, 3, 2, (1, "a"), ())

@test v"2+1" == VersionNumber(2, 0, 0, (), (1,))
@test v"3.2+1" == VersionNumber(3, 2, 0, (), (1,))
@test v"4.3.2+1" == VersionNumber(4, 3, 2, (), (1,))

@test v"1+a" == VersionNumber(1, 0, 0, (), ("a",))
@test v"2.1+a" == VersionNumber(2, 1, 0, (), ("a",))
@test v"3.2.1+a" == VersionNumber(3, 2, 1, (), ("a",))

@test v"2+a1" == VersionNumber(2, 0, 0, (), ("a1",))
@test v"3.2+a1" == VersionNumber(3, 2, 0, (), ("a1",))
@test v"4.3.2+a1" == VersionNumber(4, 3, 2, (), ("a1",))

@test v"2+1a" == VersionNumber(2, 0, 0, (), ("1a",))
@test v"3.2+1a" == VersionNumber(3, 2, 0, (), ("1a",))
@test v"4.3.2+1a" == VersionNumber(4, 3, 2, (), ("1a",))

@test v"2+a.1" == VersionNumber(2, 0, 0, (), ("a", 1))
@test v"3.2+a.1" == VersionNumber(3, 2, 0, (), ("a", 1))
@test v"4.3.2+a.1" == VersionNumber(4, 3, 2, (), ("a", 1))

@test v"2+1.a" == VersionNumber(2, 0, 0, (), (1, "a"))
@test v"3.2+1.a" == VersionNumber(3, 2, 0, (), (1, "a"))
@test v"4.3.2+1.a" == VersionNumber(4, 3, 2, (), (1, "a"))

# basic comparison

@test VersionNumber(2,3,1) == VersionNumber(Int8(2),UInt32(3),Int32(1)) == v"2.3.1"
@test v"2.3.0" < v"2.3.1" < v"2.4.8" < v"3.7.2"

# advanced comparison & manipulation

import Base: thispatch, thisminor, thismajor,
             nextpatch, nextminor, nextmajor, check_new_version

@test v"1.2.3" == thispatch(v"1.2.3-")
@test v"1.2.3" == thispatch(v"1.2.3-pre")
@test v"1.2.3" == thispatch(v"1.2.3")
@test v"1.2.3" == thispatch(v"1.2.3+post")
@test v"1.2.3" == thispatch(v"1.2.3+")

@test v"1.2" == thisminor(v"1.2.3-")
@test v"1.2" == thisminor(v"1.2.3-pre")
@test v"1.2" == thisminor(v"1.2.3")
@test v"1.2" == thisminor(v"1.2.3+post")
@test v"1.2" == thisminor(v"1.2.3+")

@test v"1" == thismajor(v"1.2.3-")
@test v"1" == thismajor(v"1.2.3-pre")
@test v"1" == thismajor(v"1.2.3")
@test v"1" == thismajor(v"1.2.3+post")
@test v"1" == thismajor(v"1.2.3+")

@test v"1.2.3" == nextpatch(v"1.2.3-")
@test v"1.2.3" == nextpatch(v"1.2.3-pre")
@test v"1.2.4" == nextpatch(v"1.2.3")
@test v"1.2.4" == nextpatch(v"1.2.3+post")
@test v"1.2.4" == nextpatch(v"1.2.3+")

@test v"1.2" == nextminor(v"1.2-")
@test v"1.2" == nextminor(v"1.2-pre")
@test v"1.3" == nextminor(v"1.2")
@test v"1.3" == nextminor(v"1.2+post")
@test v"1.3" == nextminor(v"1.2+")

@test v"1.3" == nextminor(v"1.2.3-")
@test v"1.3" == nextminor(v"1.2.3-pre")
@test v"1.3" == nextminor(v"1.2.3")
@test v"1.3" == nextminor(v"1.2.3+post")
@test v"1.3" == nextminor(v"1.2.3+")

@test v"1" == nextmajor(v"1-")
@test v"1" == nextmajor(v"1-pre")
@test v"2" == nextmajor(v"1")
@test v"2" == nextmajor(v"1+post")
@test v"2" == nextmajor(v"1+")

@test v"2" == nextmajor(v"1.2-")
@test v"2" == nextmajor(v"1.2-pre")
@test v"2" == nextmajor(v"1.2")
@test v"2" == nextmajor(v"1.2+post")
@test v"2" == nextmajor(v"1.2+")

@test v"2" == nextmajor(v"1.2.3-")
@test v"2" == nextmajor(v"1.2.3-pre")
@test v"2" == nextmajor(v"1.2.3")
@test v"2" == nextmajor(v"1.2.3+post")
@test v"2" == nextmajor(v"1.2.3+")

for major=0:3, minor=0:3, patch=0:3
    a = VersionNumber(major,minor,patch,("",),())
    b = VersionNumber(major,minor,patch,("pre",),())
    c = VersionNumber(major,minor,patch,(),())
    d = VersionNumber(major,minor,patch,(),("post",))
    e = VersionNumber(major,minor,patch,(),("",))
    @test a < b < c < d < e
    for x in [a,b,c,d,e]
        @test thispatch(x) == VersionNumber(major,minor,patch)
        @test thisminor(x) == VersionNumber(major,minor,0)
        @test thismajor(x) == VersionNumber(major,0,0)
        @test x < nextpatch(x) <= nextminor(x) <= nextmajor(x)
        @test x < thispatch(x) ? nextpatch(x) == thispatch(x) : thispatch(x) < nextpatch(x)
        @test x < thisminor(x) ? nextminor(x) == thisminor(x) : thisminor(x) < nextminor(x)
        @test x < thismajor(x) ? nextmajor(x) == thismajor(x) : thismajor(x) < nextmajor(x)
    end
end

# julia_version.h version test

@test VERSION.major == ccall(:jl_ver_major,Cint,())
@test VERSION.minor == ccall(:jl_ver_minor,Cint,())
@test VERSION.patch == ccall(:jl_ver_patch,Cint,())
