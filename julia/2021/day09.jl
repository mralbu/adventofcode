sample = """
2199943210
3987894921
9856789892
8767896789
9899965678"""

CI = CartesianIndex

neighbors(coord::CartesianIndex) = [coord + c for c in [CI(0, -1), CI(0, 1), CI(-1, 0), CI(1, 0)]]

function basin_neighbors!(ns::Set{CartesianIndex}, done::Set{CartesianIndex}, coord::CartesianIndex, m::Matrix)
    push!(ns, coord)
    push!(done, coord)

    for n in neighbors(coord)
        m[n] == 9 && continue
        n ∈ done && continue
        basin_neighbors!(ns, done, n, m)
    end

    return ns
end

function main()
    lines = readlines("input/day09.txt")
    # lines = readlines(IOBuffer(sample))

    ll = map(l -> parse.(Int, l), collect.(lines))
    nr, nc = length(lines), length(lines[1])
    m = fill(9, (nr + 2, nc + 2))
    m[2:end-1, 2:end-1] .= reduce(hcat, ll)'

    risk_level = 0
    min_points = CartesianIndex[]
    basin_lengths = Int[]
    for c in CartesianIndices((2:nr+1, 2:nc+1))
        if all(i -> m[c] < m[i], neighbors(c))
            risk_level += 1 + m[c]
            push!(min_points, c)

            ns = Set{CartesianIndex}()
            done = Set{CartesianIndex}()
            push!(basin_lengths, basin_neighbors!(ns, done, c, m) |> length)
        end
    end

    part1 = risk_level
    part2 = partialsort!(basin_lengths, 1:3, rev = true) |> prod

    return part1, part2
end

println(main())
