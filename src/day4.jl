
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
