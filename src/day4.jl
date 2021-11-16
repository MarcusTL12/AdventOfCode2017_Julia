
function part1()
    used = Set{SubString{String}}()

    open("input/day4/input") do io
        count(begin
            empty!(used)
            all(begin
                ret = w ∉ used
                push!(used, w)
                ret
            end for w in split(l))
        end for l in eachline(io))
    end
end

function part2()
    sorted = Set{Vector{Char}}()
    buffer = Char[]

    open("input/day4/input") do io
        count(begin
            empty!(sorted)
            all(begin
                empty!(buffer)
                append!(buffer, w)
                sort!(buffer)
                ret = buffer ∉ sorted
                if ret
                    push!(sorted, copy(buffer))
                end
                ret
            end for w in split(l))
        end for l in eachline(io))
    end
end
