
function part1()
    banks = open("input/day6/input") do io
        parse.(Int, split(readline(io)))
    end

    seen = Set{Vector{Int}}()

    j = 0

    while banks ∉ seen
        j += 1
        push!(seen, copy(banks))
        i = argmax(banks)
        mem = banks[i]
        banks[i] = 0
        for _ = 1:mem
            i = i % length(banks) + 1
            banks[i] += 1
        end
    end

    j
end

function part2()
    banks = open("input/day6/input") do io
        parse.(Int, split(readline(io)))
    end

    seen = Dict{Vector{Int}, Int}()

    j = 0

    while !haskey(seen, banks)
        j += 1
        seen[copy(banks)] = j
        i = argmax(banks)
        mem = banks[i]
        banks[i] = 0
        for _ = 1:mem
            i = i % length(banks) + 1
            banks[i] += 1
        end
    end

    j - seen[banks] + 1
end
