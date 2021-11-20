
function part1()
    a_mul = 16807
    b_mul = 48271

    d = 2147483647

    a = 591
    b = 393

    counter = 0

    for _ = 1:40_000_000
        a = (a * a_mul) % d
        b = (b * b_mul) % d

        counter += (a & 0xffff) == (b & 0xffff)
    end

    counter
end

function part2()
    a_mul = 16807
    b_mul = 48271

    d = 2147483647

    a = 591
    b = 393

    counter = 0

    for _ = 1:5_000_000
        a = (a * a_mul) % d
        while a % 4 != 0
            a = (a * a_mul) % d
        end
        b = (b * b_mul) % d
        while b % 8 != 0
            b = (b * b_mul) % d
        end
        counter += (a & 0xffff) == (b & 0xffff)
    end

    counter
end
