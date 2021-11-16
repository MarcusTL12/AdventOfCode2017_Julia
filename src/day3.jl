
function part1()
    inp = 289326

    pos = 0 + 0im
    dir = 1 + 0im

    i = 1
    j = 0
    dist = 1

    while i < inp
        if inp - i > dist
            pos += dist * dir
            j = dist
            i += dist
        else
            pos += dir
            j += 1
            i += 1
        end
        if j == dist
            j = 0
            dir *= 1im
            if real(dir) != 0
                dist += 1
            end
        end
    end

    abs(real(pos)) + abs(imag(pos))
end

function part2()
    inp = 289326

    pos = 0 + 0im
    dir = 1 + 0im

    dirs = (
        1 + 0im,
        1 + 1im,
        0 + 1im,
        -1 + 1im,
        -1 + 0im,
        -1 + -1im,
        0 + -1im,
        1 + -1im,
    )

    i = 0
    dist = 1
    
    cache = Dict(pos => 1)
    sizehint!(cache, inp)

    while cache[pos] <= inp
        pos += dir
        cache[pos] = sum(get(cache, pos + d, 0) for d in dirs)
        i += 1
        if i == dist
            i = 0
            dir *= 1im
            if real(dir) != 0
                dist += 1
            end
        end
    end

    cache[pos]
end
