using BenchmarkTools

input = parse.(Int, readlines("input/day01.txt"));

# Part 1 ----------------------------------------------------------------------------------

part1(input) = count(>(0), diff(input))
println(part1(input))
@benchmark part1($input)

# alternative
part1(input) = sum(input[i] > input[i-1] for i = 2:lastindex(input))
println(part1(input))
@benchmark part1($input)

# Part 2 ----------------------------------------------------------------------------------

part2(input) = sum(sum(@view input[i:i+2]) > sum(@view input[i-1:i+1]) for i = 2:lastindex(input)-2)
println(part2(input))
@benchmark part2($input)

# alternative: sum(b, c, d) - sum(a, b, c) = d - a
part2(input) = sum(input[i+1] > input[i-2] for i = 3:lastindex(input)-1)
println(part2(input))
@benchmark part2($input)

# alternative
function part2(input)
    rolling_sum = collect(((sum(@view input[i:i+2])) for i = 1:length(input)-2))
    return sum(rolling_sum[2:end] .> rolling_sum[1:end-1])
end

println(part2(input))
@benchmark part2($input)
