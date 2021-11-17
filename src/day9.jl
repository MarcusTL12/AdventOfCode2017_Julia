
function part1()
    inp = "{{<!>},{<!>},{<!>},{<a>}}"

    iter = Iterators.Stateful(inp)

    while (c = popfirst!(iter); !isnothing(c))
        println(c)
    end
end
