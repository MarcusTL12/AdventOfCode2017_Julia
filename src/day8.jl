
reg = r"(\w+) (inc|dec) (-?\d+) if (\w+) (\S+) (-?\d+)";

function part1()
    vars = Dict{String,Int}()

    open("input/day8/input") do io
        for l in eachline(io)
            m = match(reg, l)

            cond_var = get(vars, m.captures[4], 0)
            cond_func = eval(Meta.parse(m.captures[5]))
            cond_num = parse(Int, m.captures[6])

            if cond_func(cond_var, cond_num)
                sgn = m.captures[2] == "inc" ? 1 : -1
                num = parse(Int, m.captures[3])
                vars[m.captures[1]] = get(vars, m.captures[1], 0) + num * sgn
            end
        end
    end

    maximum(values(vars))
end

function part2()
    vars = Dict{String,Int}()

    curmax = 0

    open("input/day8/input") do io
        for l in eachline(io)
            m = match(reg, l)

            cond_var = get(vars, m.captures[4], 0)
            cond_func = eval(Meta.parse(m.captures[5]))
            cond_num = parse(Int, m.captures[6])

            if cond_func(cond_var, cond_num)
                sgn = m.captures[2] == "inc" ? 1 : -1
                num = parse(Int, m.captures[3])
                n_num = get(vars, m.captures[1], 0) + num * sgn
                vars[m.captures[1]] = n_num
                curmax = max(curmax, n_num)
            end
        end
    end

    curmax
end
