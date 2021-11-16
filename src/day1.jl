
function part1()
    inp = open(readline, "input/day1/input")

    sum(x == y ? x - '0' : 0 for (x, y) in zip(inp, Iterators.drop(inp, 1))) +
    (first(inp) == last(inp) ? first(inp) - '0' : 0)
end

function part2()
    inp = open(readline, "input/day1/input")

    nums = [c - '0' for c in inp]

    sum(begin
        opposite_index = (i - 1 + length(nums) ÷ 2) % length(nums) + 1
        if nums[i] == nums[opposite_index]
            nums[i]
        else
            0
        end
    end for i in eachindex(nums))
end
