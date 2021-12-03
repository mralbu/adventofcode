using BenchmarkTools

sample = split("""
00100
11110
10110
10111
10101
01111
00111
11100
10000
11001
00010
01010""", "\n")

input = readlines("input/day03.txt")

function bitvec_to_int(bitvec, acc = 0)
    v = 1
    for i in view(bitvec, lastindex(bitvec):-1:1)
        acc += v * i
        v *= 2
    end
    acc
end
bitvec_to_int(bitvec::AbstractString, acc::Int) = bitvec_to_int([l == '1' for l in bitvec], acc)

# Part 1 ----------------------------------------------------------------------------------

function part1(input)
    n_rows, n_bits = (length(input), length(input[1]))
    counter = zeros(Int, n_bits)
    for line in input
        counter .+= (l == '1' for l in line)
    end
    x = counter .> n_rows / 2

    return bitvec_to_int(x) * bitvec_to_int(.!x)
end

println("Part1 (sample): $(part1(sample))")
println("Part1: $(part1(input))\n")
# @benchmark part1($input)

# Part 2 ----------------------------------------------------------------------------------

function most_common_bit(input; pos = 1)
    n_rows, _ = (length(input), length(input[1]))
    counter = 0
    for line in input
        counter += (line[pos] == '1')
    end
    return counter >= n_rows / 2
end
least_common_bit(input; pos = 1) = !most_common_bit(input; pos = pos)

filter_by_firstbit(input, pos, bit) = [line for line in input if parse(Int, line[pos]) == bit]

function device_rating(input, bit_evaluation)
    position = 1
    while length(input) > 1
        input_candidate = filter_by_firstbit(input, position, bit_evaluation(input; pos = position))
        input = length(input_candidate) >= 1 ? input_candidate : break
        position += 1
    end
    return input[1]
end

function part2(input)
    oxygen_generator_rating = device_rating(input, most_common_bit)
    co2_scrubber_rating = device_rating(input, least_common_bit)

    return bitvec_to_int(oxygen_generator_rating) * bitvec_to_int(co2_scrubber_rating)
end

println("Part2 (sample): $(part2(sample))")
println("Part2: $(part2(input))")
# @benchmark part2($input)
