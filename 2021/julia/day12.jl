sample = """
start-A
start-b
A-c
A-b
b-d
A-end
b-end"""

function main()
    # paths = map(l -> tuple(split(l, "-")...), eachline("input/day12.txt"))
    paths = map(l -> tuple(split(l, "-")...), eachline(IOBuffer(sample)))

    paths = vcat(paths, [(v, k) for (k, v) in paths if k != "start" && v != "end"])

    part1 = traverse_paths(paths, ["start"], 1)
    part2 = traverse_paths(paths, ["start"], 2)

    return part1, part2
end

function traverse_paths(paths::AbstractVector, history::AbstractVector{String}, smallcave_visits = 1)::Int
    history[end] == "end" && (return 1)

    lowercase_history = filter(x -> all(islowercase, x) && x ∉ ["start", "end"], history) |> unique
    any(x -> count(==(x), history) == smallcave_visits, lowercase_history) && (smallcave_visits = 1)

    subpath_count = 0
    for n in [d for (o, d) in paths if o == history[end]]
        if (count(==(n), history) < smallcave_visits || isuppercase(n[1]))
            subpath_count += traverse_paths(paths, push!(copy(history), n), smallcave_visits)
        end
    end
    return subpath_count
end

println(main())
