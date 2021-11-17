
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

function get_root(tree)
    leaves = Set{String}()
    sizehint!(leaves, length(tree))

    for (_, l) in values(tree)
        union!(leaves, l)
    end

    first(setdiff(keys(tree), leaves))
end

function part1()
    get_root(parse_input("input/day7/input"))
end

function get_disk_weight!(disk_weights, tree, node)
    if haskey(disk_weights, node)
        disk_weights[node]
    else
        node_weight, branches = tree[node]

        disk_weights[node] = node_weight + (!isempty(branches) && sum(
            get_disk_weight!(disk_weights, tree, branch) for branch in branches
        ))
    end
end

function find_wrong_weight!(disk_weights, tree, node, target)
    _, branches = tree[node]
    if isempty(branches)
        target
    else
        sub_disk_weights = [
            get_disk_weight!(disk_weights, tree, branch) for branch in branches
        ]

        correct_disk_weight = if sub_disk_weights[1] == sub_disk_weights[2] ==
                                 sub_disk_weights[3]
            sub_disk_weights[1]
        elseif sub_disk_weights[1] == sub_disk_weights[2]
            sub_disk_weights[1]
        else
            sub_disk_weights[3]
        end

        wrong_ind = findfirst(!=(correct_disk_weight), sub_disk_weights)

        if isnothing(wrong_ind)
            target - sum(sub_disk_weights)
        else
            find_wrong_weight!(
                disk_weights, tree, branches[wrong_ind], correct_disk_weight
            )
        end
    end
end

function part2()
    tree = parse_input("input/day7/input")

    disk_weights = sizehint!(Dict{String,Int}(), length(tree))

    root = get_root(tree)

    find_wrong_weight!(disk_weights, tree, root, 0)
end
