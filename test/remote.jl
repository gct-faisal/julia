# This file is a part of Julia. License is MIT: http://julialang.org/license

# Check that serializer hasn't gone out-of-frame
@test Serializer.ser_tag[Symbol] == 2
@test Serializer.ser_tag[()] == 47
@test Serializer.ser_tag[false] == 123

# issue #1770
let
    a = ['T', 'e', 's', 't']
    f = IOBuffer()
    serialize(f, a)
    seek(f, 0)
    @test deserialize(f) == a
    f = IOBuffer()
    serialize(f, a)
    seek(f, 0)
    @test deserialize(f) == a

    # issue #4414
    seek(f,0)
    serialize(f, :β)
    seek(f,0)
    @test deserialize(f) === :β
end
