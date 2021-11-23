
function parse_input(filename)
    lines = open(collect ∘ eachline, filename)

    grid = fill(' ', length(lines), length(lines[1]))

    for (row, line) in zip(eachrow(grid), lines)
        row .= Vector{Char}(line)
    end

    grid
end

function part1and2()
    grid = parse_input("input/day19/input")

    pos = 1 + findfirst(==('|'), @view grid[1, :]) * im

    dir = 1 + 0im

    done = false

    result = Char[]

    steps = 0

    while !done
        pos += dir
        steps += 1

        c = grid[real(pos), imag(pos)]

        if 'A' <= c <= 'Z'
            push!(result, c)
        elseif c == '+'
            target = iszero(real(dir)) ? '|' : '-'

            p1 = pos + dir * 1im
            p2 = pos - dir * 1im

            c1 = get(grid, (real(p1), imag(p1)), ' ')
            c2 = get(grid, (real(p2), imag(p2)), ' ')

            if c1 == target || 'A' <= c1 <= 'Z'
                dir *= 1im
            elseif c2 == target || 'A' <= c2 <= 'Z'
                dir *= -1im
            else
                throw("Faaak")
            end
        elseif c == ' '
            done = true
        end
    end

    String(result), steps
end
