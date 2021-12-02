using BenchmarkTools

input = readlines("input/day02.txt")

# Day 2 ------------------------------------------------------------------

function day02(input::Vector{String})
    part1, part2 = 0, 0
    for line in input
        m = match(r"(\d+)-(\d+)\s+(.):\s+(.+)", line)
        isnothing(m) && break
        low = parse(Int, m.captures[1])
        high = parse(Int, m.captures[2])
        char = m.captures[3][1]
        pw = m.captures[4]
        if low <= count(c -> c == char, pw) <= high
            part1 += 1
        end
        if xor(pw[low] == char, pw[high] == char)
            part2 += 1
        end
    end
    return part1, part2
end

println(day02(input))
@benchmark day02(input)