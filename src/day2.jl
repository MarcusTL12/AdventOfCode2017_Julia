
function part1()
    open("input/day2/input") do io
        -sum(-(extrema(s -> parse(Int, s), split(l))...) for l in eachline(io))
    end
end

function part2()
    open("input/day2/input") do io
        sum(begin
            nums = [parse(Int, s) for s in split(l)]

            res = 0

            for i in 1:length(nums) - 1, j in i + 1:length(nums)
                q, r = divrem(reverse(minmax(nums[i], nums[j]))...)

                if r == 0
                    res = q
                    break
                end
            end

            res
        end for l in eachline(io))
    end
end
