
function part1()
    buf = [0]

    inp = 355

    cur_pos = 1

    for i = 1:2017
        cur_pos = (cur_pos + inp - 1) % length(buf) + 2
        insert!(buf, cur_pos, i)
    end

    buf[cur_pos + 1]
end

function insert_list!(list, i, val)
    next_ind = list[i][3]
    push!(list, (val, i, next_ind))
    new_ind = length(list)
    list[i] = (list[i][1], list[i][2], new_ind)
    list[next_ind] = (list[next_ind][1], new_ind, list[next_ind][3])
    new_ind
end

function part2()
    buf = [(Int32(0), Int32(1), Int32(1))]

    inp = 355

    cur_pos = 1

    for i = 1:50_000_000
        for _ in 1:inp
            cur_pos = buf[cur_pos][3]
        end
        cur_pos = insert_list!(buf, cur_pos, i)
    end

    i = findfirst(x -> x[1] == 0, buf)
    buf[buf[i][3]]
end
