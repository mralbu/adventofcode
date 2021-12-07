using Statistics: median, mean

cost(d) = d * (1 + d) / 2

function main()
    input = parse.(Int, split(readline(joinpath(@__DIR__, "input/day07.txt")), ','))
    # input = parse.(Int, split("16,1,2,0,4,2,7,1,2,14", ','))

    m1 = median(input)
    m2 = mean(input)

    part1 = sum(Int, abs.(input .- m1))
    part2 = Int(minimum(sum(cost.(abs.(input .- mx))) for mx = round(m2 - 0.5):round(m2 + 0.5)))
    return part1, part2
end

println(main())

# part2
# cost(x, mx) = Sum((x - mx)^2) / 2 + Sum(abs(x - mx)) / 2
# Sum(2(x - mx)) / 2 + Sum(-1) / 2 <= dCostdmx(x) <= Sum(2(x - mx)) / 2 + Sum(+1) / 2
# dCostdmx(x) == 0
# -1 / 2 + Sum(x) / n <= mx <= +1 / 2 + Sum(x) / n

