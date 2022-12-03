
function simulate(fish_cycle_count::AbstractVector, epochs::Int)
    for _ = 1:epochs
        cycle_end = popfirst!(fish_cycle_count)
        push!(fish_cycle_count, cycle_end)
        fish_cycle_count[6+1] += cycle_end
    end
    return sum(fish_cycle_count)
end

function main()
    # input = parse.(Int, split("3,4,3,1,2", ','))
    input = parse.(Int, split(readline(joinpath(@__DIR__, "input/day06.txt")), ','))
    init_cycle_count = [count(==(i), input) for i = 0:8]

    part1 = simulate(copy(init_cycle_count), 80)
    part2 = simulate(copy(init_cycle_count), 256)
    return part1, part2
end

println(main())
