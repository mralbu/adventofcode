sample = """
NNCB

CH -> B
HH -> N
CB -> H
NH -> C
HB -> C
HC -> B
HN -> C
NN -> C
BH -> H
NC -> B
NB -> B
BN -> B
BB -> N
BC -> B
CC -> N
CN -> C"""

function grow_polymer(polymer_template, rules, steps)
    pair_count = Dict(p => count(p, polymer_template) for p in keys(rules))

    # count new pairs
    for _ = 1:steps
        temp = copy(pair_count)
        replace!(p -> first(p) => 0, pair_count)
        for (k, v) in temp
            pair_count[k[1]*rules[k]] += v
            pair_count[rules[k]*k[2]] += v
        end
    end

    # count elements after polymer growth
    elements = keys(pair_count) |> join |> unique
    element_count = Dict(el => 0 for el in elements)
    for (k, v) in pair_count
        element_count[first(k)] += v
        element_count[last(k)] += v
    end

    element_count_vals = map(x -> Int(ceil(x / 2)), element_count |> values)

    return maximum(element_count_vals) - minimum(element_count_vals)
end

function main()
    # polymer_template, _, rules... = readlines("input/day14.txt")
    polymer_template, _, rules... = readlines(IOBuffer(sample))

    rules = Dict(k => v for (k, v) in split.(rules, " -> "))

    part1 = grow_polymer(polymer_template, rules, 10)
    part2 = grow_polymer(polymer_template, rules, 40)

    return part1, part2
end

println(main())
