
function part1()
    jumps = open("input/day5/input") do io
        parse.(Int, eachline(io))
    end

    i = 1
    j = 0
    while i in eachindex(jumps)
        jump = jumps[i]
        jumps[i] += 1
        i += jump
        j += 1
    end

    j
end

function part2()
    jumps = open("input/day5/input") do io
        parse.(Int, eachline(io))
    end

    i = 1
    j = 0
    while i in eachindex(jumps)
        jump = jumps[i]
        jumps[i] += if jump >= 3
            -1
        else
            1
        end
        i += jump
        j += 1
    end

    j
end
