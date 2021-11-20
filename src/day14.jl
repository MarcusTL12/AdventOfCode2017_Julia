using CircularArrays

function knot_hash(s)
    lengths = append!([Int(c) for c in s], [17, 31, 73, 47, 23])

    nums = CircularVector(collect(0:255))

    n = 256

    skipsize = 0
    curpos = 1

    for _ = 1:64
        for l in lengths
            reverse!(@view nums[curpos:curpos+l-1])
            curpos += l + skipsize
            skipsize += 1
        end
    end

    h = reverse!(reinterpret(
        UInt64,
        [UInt8(reduce(⊻, @view nums[i*16+1:(i+1)*16])) for i = 15:-1:0]
    ))

    h[1] = bitreverse(h[1])
    h[2] = bitreverse(h[2])

    h
end

function make_grid(inp)
    inp *= '-'

    buf = IOBuffer()

    grid = falses(128, 128)

    for col = 1:128
        print(buf, inp)
        print(buf, col - 1)
        h = knot_hash(take!(buf))

        grid.chunks[2col-1] = h[1]
        grid.chunks[2col] = h[2]
    end

    grid
end

function part1()
    inp = "uugsqrei"

    count(make_grid(inp))
end

function part2()
    inp = "uugsqrei"

    grid = make_grid(inp)

    regions = zeros(Int, 128, 128)
    cur_region = falses(128, 128)
    cur_id = 1

    dirs = (
        (1, 0),
        (-1, 0),
        (0, 1),
        (0, -1)
    )

    function dfs(pos)
        for d in dirs
            npos = pos .+ d
            if all(x -> 1 <= x <= 128, npos) &&
               !cur_region[npos...] && grid[npos...]
                cur_region[npos...] = true
                regions[npos...] = cur_id
                dfs(npos)
            end
        end
    end

    for j = 1:128, i = 1:128
        if grid[i, j] && regions[i, j] == 0
            cur_region .= false
            cur_region[i, j] = true
            regions[i, j] = cur_id
            dfs((i, j))
            cur_id += 1
        end
    end

    cur_id - 1
end
