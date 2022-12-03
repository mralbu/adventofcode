sample = """
be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe
edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc
fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg
fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb
aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea
fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb
dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe
bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef
egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb
gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce"""

sort_string(s::AbstractString) = join(sort(collect(s)))

function get_output_sum(line::AbstractString)::Int
    inputs, outputs = split.(split(line, " | "))
    inputs = sort_string.(inputs)
    outputs = sort_string.(outputs)


    idx = indexin([2, 3, 7, 4], length.(inputs))
    codec = Dict(zip([1, 7, 8, 4], inputs[idx]))

    # 6 digits
    codec[6] = filter(i -> length(i) == 6 && codec[1] ⊈ i, inputs)[1]
    codec[9] = filter(i -> length(i) == 6 && i ≠ codec[6] && codec[4] ⊆ i, inputs)[1]
    codec[0] = filter(i -> length(i) == 6 && i ≠ codec[6] ⊈ i && i ≠ codec[9], inputs)[1]

    # 5 digits
    codec[3] = filter(i -> length(i) == 5 && codec[1] ⊆ i, inputs)[1]
    codec[5] = filter(i -> length(i) == 5 && i ⊆ codec[6], inputs)[1]
    codec[2] = setdiff(inputs, values(codec))[1]

    rev_codec = Dict(v => k for (k, v) in codec)

    return sum(rev_codec[out] * 10^(i - 1) for (i, out) in enumerate(reverse(outputs)))
end

function main()
    lines = readlines("input/day08.txt")
    # lines = readlines(IOBuffer(sample))

    total_count = 0
    for line in lines
        _, outputs = split.(split(line, " | "))
        total_count += count(out -> out ∈ [2, 3, 4, 7], length.(outputs))
    end
    part1 = total_count

    total_sum = 0
    for line in lines
        total_sum += get_output_sum(line)
    end
    part2 = total_sum

    return part1, part2
end

println(main())
