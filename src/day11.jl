using StaticArrays

function hexdist(pos)
    if sign(pos[1]) == sign(pos[2])
        abs(sum(pos))
    else
        min(abs.(pos)...) + abs(sum(pos))
    end
end

function getdirs()
    Dict((
        "n" => (@SVector [1, 0]),
        "s" => (@SVector [-1, 0]),
        "ne" => (@SVector [0, 1]),
        "sw" => (@SVector [0, -1]),
        "nw" => (@SVector [1, -1]),
        "se" => (@SVector [-1, 1])
    ))
end

function part1()
    dirs = getdirs()

    inp = split(readline("input/day11/input"), ',')

    hexdist(sum(dirs[d] for d in inp))
end

function part2()
    dirs = getdirs()

    inp = split(readline("input/day11/input"), ',')

    maximum(hexdist, Iterators.accumulate(+, dirs[d] for d in inp))
end
