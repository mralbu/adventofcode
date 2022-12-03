# Learning Graphs.jl / #cheating
const CI = CartesianIndex
using SimpleWeightedGraphs
using Graphs

# bug-fix a_star(g::AbstractSimpleWeightedEdge, s, e)
# https://github.com/sbromberger/SimpleWeightedGraphs.jl/pull/70/files
SimpleWeightedGraphs.SimpleWeightedEdge{T,U}(x::T, y::T) where {T<:Integer} where {U<:Real} = SimpleWeightedEdge(x, y, one(U))
==(e1::AbstractEdge, e2::AbstractSimpleWeightedEdge) = (src(e1) == src(e2) && dst(e1) == dst(e2))

sample = """
1163751742
1381373672
2136511328
3694931569
7463417111
1319128137
1359912421
3125421639
1293138521
2311944581"""

neighbors(n, ci_map) = filter(∈(ci_map), map(ci -> n + ci, [CI(-1, 0), CI(1, 0), CI(0, -1), CI(0, 1)]))

function create_graph(risk)
    ci_map = CartesianIndices(risk)
    ci2num = Dict(v => k for (k, v) in enumerate(CartesianIndices(risk)))

    g = SimpleWeightedDiGraph(risk |> length)
    for ci in CartesianIndices(risk)
        for nb in neighbors(ci, ci_map)
            add_edge!(g, ci2num[nb], ci2num[ci], risk[ci])
        end
    end

    return g
end

function lowest_total_risk(risk, src, dest)
    num2ci = Dict(enumerate(CartesianIndices(risk)))

    g = create_graph(risk)
    path = Graphs.a_star(g, src, dest)

    return sum(risk[num2ci[e.dst]] for e in path)
end

function bigger_cave(risk)
    risk = reduce(vcat, [risk .+ i for i in [0, 1, 2, 3, 4]])
    risk = reduce(hcat, [risk .+ i for i in [0, 1, 2, 3, 4]])
    return mod1.(risk, 9)
end

function main()
    risk = mapreduce(l -> parse.(Int, split(l, ""))', vcat, eachline("input/day15.txt"))
    # risk = mapreduce(l -> parse.(Int, split(l, ""))', vcat, eachline(IOBuffer(sample)))

    part1 = lowest_total_risk(risk, 1, length(risk))

    bigcave_risk = bigger_cave(risk)
    part2 = lowest_total_risk(bigcave_risk, 1, length(bigcave_risk))

    return part1, part2
end

println(main())
