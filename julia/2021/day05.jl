using DataStructures: DefaultDict

sample = """
0,9 -> 5,9
8,0 -> 0,8
9,4 -> 3,4
2,2 -> 2,1
7,0 -> 7,4
6,4 -> 2,0
0,9 -> 2,9
3,4 -> 1,4
0,0 -> 8,8
5,5 -> 8,2
"""

function process_input(input)::Vector{NamedTuple}
    lines = []
    for l in input
        m = parse.(Int, match(r"(\d+),(\d+) -> (\d+),(\d+)", l).captures)
        push!(lines, (x1 = m[1], y1 = m[2], x2 = m[3], y2 = m[4]))
    end
    return lines
end

line_length(line::NamedTuple) = max(abs(line.x1 - line.x2), abs(line.y1 - line.y2))

function coord_intersects(lines::AbstractVector{NamedTuple})
    coord_inter = DefaultDict(0)
    for line in lines
        x1, y1, x2, y2 = line

        Δx = (x2 == x1) ? 0 :
             (x2 > x1) ? 1 : -1

        Δy = (y2 == y1) ? 0 :
             (y2 > y1) ? 1 : -1

        x, y = x1, y1
        for _ = 0:line_length(line)
            coord_inter[(x, y)] += 1
            x != x2 && (x += Δx)
            y != y2 && (y += Δy)
        end
    end
    return coord_inter
end

function main()
    # input = readlines(IOBuffer(sample))
    input = readlines("input/day05.txt")
    lines = process_input(input)

    hv_lines = filter(l -> l.x1 == l.x2 || l.y1 == l.y2, lines)
    part1 = filter(d -> d.second >= 2, coord_intersects(hv_lines))
    part2 = filter(d -> d.second >= 2, coord_intersects(lines))

    return length(part1), length(part2)
end

println(main())
