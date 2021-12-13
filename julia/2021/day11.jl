const CI = CartesianIndex
neighbors(coord::CartesianIndex, cis::CartesianIndices) = [coord + c for c in [CI(0, -1), CI(0, 1), CI(-1, 0),
    CI(1, 0), CI(-1, -1), CI(1, 1), CI(-1, 1), CI(1, -1)] if coord + c in cis]

sample = """
5483143223
2745854711
5264556173
6141336146
6357385478
4167524645
2176841721
6882881134
4846848554
5283751526"""

function main()
    m = mapreduce(l -> parse.(Int, collect(l))', vcat, eachline("input/day11.txt"))
    # m = mapreduce(l -> parse.(Int, collect(l))', vcat, eachline(IOBuffer(sample)))
    cis = CartesianIndices(m)

    part1 = 0
    part2 = 0

    maxsteps = 500
    flash_count = 0
    for i = 1:maxsteps
        # record step flashed octos CIs
        done = Set{CartesianIndex}()

        # increment energy level, find flashing octos and record them
        m .+= 1
        flashing_octopi = cis[findall(>(9), m)]
        flash_count += length(flashing_octopi)
        for coord in flashing_octopi
            push!(done, coord)
        end

        # update neighbor energy levels
        while (!isempty(flashing_octopi))
            new_flashes = Set{CartesianIndex}()
            for coord in flashing_octopi
                nbs = neighbors(coord, cis)
                m[nbs] .+= 1

                nb_flashes = setdiff(filter(o -> m[o] > 9, cis[nbs]), done)
                flash_count += length(nb_flashes)
                union!(new_flashes, nb_flashes)
                for coord in new_flashes
                    push!(done, coord)
                end
            end
            flashing_octopi = new_flashes
        end

        # restart energy levels of flashed octopi
        m[findall(>(9), m)] .= 0

        # check part1 and part2 conditions
        i == 100 && (part1 = flash_count)
        length(done) == length(m) && part2 == 0 && (part2 = i; break)
    end


    return part1, part2
end

println(main())

