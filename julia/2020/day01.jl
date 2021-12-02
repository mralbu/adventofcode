using BenchmarkTools

input = parse.(Int, readlines("input/day01.txt"))

# Part 1 ----------------------------------------------------------------

function part1(values::Array{Int,1})
    for (i, vi) in enumerate(values)
        for vj in Iterators.rest(values, i + 1)
            vi + vj == 2020 && return vi * vj
        end
    end
end
println(part1(input))
@benchmark part1(input)

# Part 2 ----------------------------------------------------------------

function part2(values::Array{Int,1})
    for (i, vi) in enumerate(values)
        for (j, vj) in enumerate(Iterators.rest(values, i + 1))
            sum = vi + vj
            sum > 2020 && continue
            for vk in Iterators.rest(values, i + j + 1)
                sum + vk == 2020 && return vi * vj * vk
            end
        end
    end
end
println(part2(input))
@benchmark part2(input)

# Day 1 ------------------------------------------------------------------

function day01(input)
    return part1(input), part2(input)
end
println(day01(input))
@benchmark day01(input)