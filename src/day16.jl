
function part1()
    inp = split(readline("input/day16/input"), ',')

    line = collect('a':'p')

    for ins in inp
        c = first(ins)
        rest = ins[2:end]
        if c == 's'
            n = parse(Int, rest)
            for _ = 1:n
                pushfirst!(line, pop!(line))
            end
        elseif c == 'x'
            a, b = split(rest, '/')
            a = parse(Int, a) + 1
            b = parse(Int, b) + 1

            tmp = line[a]
            line[a] = line[b]
            line[b] = tmp
        elseif c == 'p'
            a, _, b = rest

            i = findfirst(==(a), line)
            j = findfirst(==(b), line)

            tmp = line[i]
            line[i] = line[j]
            line[j] = tmp
        end
    end

    String(line)
end

function compile_input(inp)
    [
        begin
            c = first(ins)
            rest = @view ins[2:end]
            if c == 's'
                (1, parse(Int, rest), 0)
            elseif c == 'x'
                (2, (parse.(Int, split(rest, '/')) .+ 1)...)
            elseif c == 'p'
                a, _, b = rest
                (3, Int(a), Int(b))
            end
        end::Tuple{Int,Int,Int} for ins in inp
    ]
end

function part2()
    inp = compile_input(split(readline("input/day16/input"), ','))

    line = collect('a':'p')

    seen = Set((copy(line),))
    order = [copy(line)]

    n = 0

    for _ = 1:1000_000_000
        n += 1
        for (ins, a, b) in inp
            if ins == 1
                for _ = 1:a
                    pushfirst!(line, pop!(line))
                end
            elseif ins == 2
                tmp = line[a]
                line[a] = line[b]
                line[b] = tmp
            elseif ins == 3
                a_ = Char(a)
                b_ = Char(b)

                i = findfirst(==(a_), line)
                j = findfirst(==(b_), line)

                tmp = line[i]
                line[i] = line[j]
                line[j] = tmp
            end
        end

        if line in seen
            break
        else
            push!(seen, copy(line))
            push!(order, copy(line))
        end
    end

    String(order[1000_000_000 % n + 1])
end
