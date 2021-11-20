using OffsetArrays

function parse_input(filename)
    graph = Vector{Int}[]

    open(filename) do io
        for l in eachline(io)
            _, b = split(l, " <-> ")
            push!(graph, parse.(Int, split(b, ", ")))
        end
    end

    OffsetArray(graph, 0:length(graph)-1)
end

function part1()
    graph = parse_input("input/day12/input")

    group = Set(0)

    function dfs(id)
        for n_id in graph[id]
            if n_id ∉ group
                push!(group, n_id)
                dfs(n_id)
            end
        end
    end

    dfs(0)

    length(group)
end

function part2()
    graph = parse_input("input/day12/input")

    remaining_ids = Set(eachindex(graph))

    group = Set{Int}()

    amt_groups = 0

    function dfs(id)
        for n_id in graph[id]
            if n_id ∉ group
                push!(group, n_id)
                dfs(n_id)
            end
        end
    end

    while !isempty(remaining_ids)
        empty!(group)

        id = pop!(remaining_ids)

        push!(group, id)
        dfs(id)

        setdiff!(remaining_ids, group)
        amt_groups += 1
    end

    amt_groups
end
