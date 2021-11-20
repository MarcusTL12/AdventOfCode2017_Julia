
function parse_input(filename)
    open(filename) do io
        [
            begin
                a, b = split(l, ": ")
                parse(Int, a) => parse(Int, b)
            end for l in eachline(io)
        ]
    end
end

function is_caught(depth, range, offset)
    period = (range - 1) * 2

    iszero((depth + offset) % period)
end

function part1()
    inp = parse_input("input/day13/input")

    sum(
        is_caught(depth, range, 0) ? depth * range : 0 for (depth, range) in inp
    )
end

function caught_any(inp, offset)
    any(is_caught(depth, range, offset) for (depth, range) in inp)
end

function part2()
    inp = parse_input("input/day13/input")

    first(
        Iterators.filter(off -> !caught_any(inp, off), Iterators.countfrom(0))
    )
end
