
function parse_input(filename)
    tree = Dict{String,Tuple{Int,Vector{String}}}()

    reg = r"(\w+) \((\d+)\)(?: -> )?(.*)"

    open(filename) do io
        for l in eachline(io)
            m = match(reg, l)
            name = m.captures[1]
            n = parse(Int, m.captures[2])
            leaves = if length(m.captures[3]) > 0
                split(m.captures[3], ", ")
            else
                String[]
            end

            tree[name] = (n, leaves)
        end
    end

    tree
end

function part1()
    tree = parse_input("input/day7/input")

    leaves = Set{String}()
    sizehint!(leaves, length(tree))

    for (_, l) in values(tree)
        union!(leaves, l)
    end

    first(setdiff(keys(tree), leaves))
end
