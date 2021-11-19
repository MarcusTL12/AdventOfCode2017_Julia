
function part1()
    n = 256
    nums = collect(0:n-1)

    inp = eval(Meta.parse("[" * readline("input/day10/input") * "]"))

    skipsize = 0
    startind = 1

    for l in inp
        nums[1:l] = @view nums[l:-1:1]
        startind -= skipsize + l
        for _ = 1:skipsize+l
            push!(nums, popfirst!(nums))
        end
        skipsize += 1
    end

    startind = (startind - 1) % n + n + 1

    nums[startind] * nums[startind%n+1]
end

function knot_hash(s)
    lengths = append!([Int(c) for c in s], [17, 31, 73, 47, 23])

    nums = collect(0:255)

    n = 256

    skipsize = 0
    startind = 1

    for _ = 1:64
        for l in lengths
            nums[1:l] = @view nums[l:-1:1]
            startind -= skipsize + l
            for _ = 1:skipsize+l
                push!(nums, popfirst!(nums))
            end
            skipsize += 1
        end
    end

    startind = (startind - 1) % n + n + 1

    for _ = 2:startind
        pushfirst!(nums, pop!(nums))
    end

    densehash = [UInt8(reduce(⊻, @view nums[i*16+1:(i+1)*16])) for i = 0:15]

    bytes2hex(densehash)
end

function part2()
    knot_hash(readline("input/day10/input"))
end
