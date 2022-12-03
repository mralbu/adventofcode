using BenchmarkTools

input = readlines("input/day03.txt")

function count_trees(treemap, right::Int, down::Int)
    rows, cols = length(treemap), length(treemap[1])

    # initialize
    r, c, ntrees = 1, 1, treemap[1][1] == '#' ? 1 : 0

    # traverse treemap
    while r != rows
        c = mod1(c + right, cols)
        r += down
        if treemap[r][c] == '#'
            ntrees += 1
        end
    end
    return ntrees
end

# Part 1 ----------------------------------------------------------------

function part1(treemap)
    return count_trees(treemap, 3, 1)
end
println(part1(input))
@benchmark part1(input)

# Part 2 ----------------------------------------------------------------

function part2(treemap)
    slopes = [(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)]
    return (count_trees(treemap, right, down) for (right, down) in slopes) |> prod
end
println(part2(input))
@benchmark part2(input)

# Day 3 ------------------------------------------------------------------

function day03(input)
    return part1(input), part2(input)
end
println(day03(input))
@benchmark day03(input)
