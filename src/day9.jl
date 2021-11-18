
function part1()
    inp = readline("input/day9/input")

    iter = Iterators.Stateful(inp)

    garbage = false
    depth = 0

    score = 0

    while !isempty(iter)
        c = popfirst!(iter)

        if garbage
            if c == '!'
                popfirst!(iter)
            elseif c == '>'
                garbage = false
            end
        elseif c == '{'
            depth += 1
            score += depth
        elseif c == '}'
            depth -= 1
        elseif c == '<'
            garbage = true
        end
    end

    score
end

function part2()
    inp = readline("input/day9/input")

    iter = Iterators.Stateful(inp)

    garbage = false
    amt_garbage = 0

    while !isempty(iter)
        c = popfirst!(iter)

        if garbage
            if c == '!'
                popfirst!(iter)
            elseif c == '>'
                garbage = false
            else
                amt_garbage += 1
            end
        elseif c == '<'
            garbage = true
        end
    end

    amt_garbage
end
