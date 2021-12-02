using BenchmarkTools

sample = split("""
forward 5
down 5
forward 8
up 3
down 8
forward 2""", "\n")

input = readlines("input/day02.txt");

# Part 1 ----------------------------------------------------------------------------------

function part1(input)
    depth, horizontal = 0, 0

    for command in input
        key, value = command[1], parse(Int, command[end])
        if (key == 'u')
            depth -= value
        elseif (key == 'd')
            depth += value
        elseif (key == 'f')
            horizontal += value
        end
        depth = max(0, depth)
    end
    return depth * horizontal
end

println(part1(sample))
println(part1(input))
@benchmark part1($input)

# Part 2 ----------------------------------------------------------------------------------

function part2(input)
    aim, depth, horizontal = 0, 0, 0

    for command in input
        key, value = command[1], parse(Int, command[end])
        if (key == 'u')
            aim -= value
        elseif (key == 'd')
            aim += value
        elseif (key == 'f')
            horizontal += value
            depth += aim * value
        end
        depth = max(0, depth)
    end
    return depth * horizontal
end

println(part2(sample))
println(part2(input))
@benchmark part2($input)
