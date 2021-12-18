sample = """target area: x=20..30, y=-10..-5"""

function trajectory_hits(xmin::Int, xmax::Int, ymin::Int, ymax::Int)::Vector{Tuple{Int64,Int64,Int64}}

    hits = Tuple{Int,Int,Int}[]
    for vx0 = -300:300, vy0 = -300:300
        x, y, vx, vy = 0, 0, vx0, vy0
        yapogee = y

        while x <= xmax && y >= ymin
            x += vx
            y += vy
            # y >= yapogee && (yapogee = y)
            if xmin <= x <= xmax && ymin <= y <= ymax
                yapogee = vy0 <= 0 ? 0 : Int(vy0^2 / 2 + vy0 / 2)
                push!(hits, (vx0, vy0, yapogee))
                break
            end
            vx = vx != 0 ? sign(vx) * (abs(vx) - 1) : 0
            vy -= 1
        end
    end

    return hits
end

function main()
    xmin, xmax, ymin, ymax = parse.(Int, match(r"x=([-\d]+)..([-\d]+), y=([-\d]+)..([-\d]+)", readline("input/day17.txt")).captures)
    # xmin, xmax, ymin, ymax = parse.(Int, match(r"x=([-\d]+)..([-\d]+), y=([-\d]+)..([-\d]+)", sample).captures)

    hits = trajectory_hits(xmin, xmax, ymin, ymax)

    part1 = max(yapogee for (vx0, vy0, yapogee) in hits)
    part2 = length(hits)

    return part1, part2
end

println(main())
