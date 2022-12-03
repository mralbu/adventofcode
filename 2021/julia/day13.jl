using DelimitedFiles
const CI = CartesianIndex

sample = """
6,10
0,14
9,10
0,3
10,4
4,11
6,0
6,12
4,1
0,13
10,12
3,4
3,0
8,4
1,10
2,14
8,10
9,0

fold along y=7
fold along x=5"""

function main()
    dots, folds = split(read("input/day13.txt", String), "\n\n")
    # dots, folds = split(read(IOBuffer(sample), String), "\n\n")

    dots = readdlm(IOBuffer(dots), ',', Int, '\n') .+ 1

    nx, ny = maximum(dots[:, 1]), maximum(dots[:, 2])
    ny = ny % 2 == 0 ? ny + 1 : ny # dimensions must be odd
    nx = nx % 2 == 0 ? nx + 1 : nx # dimensions must be odd
    m = zeros(Bool, ny, nx)

    coords = [CI(y, x) for (x, y) in eachrow(dots)]
    m[coords] .= 1

    instructions = split(folds, '\n')
    foldinstruct(instruc) = occursin('x', instruc) ? 1 : 2, parse(Int, split(instruc, '=')[2]) + 1

    for (i, instruct) in enumerate(instructions)
        d, l = foldinstruct(instruct)
        if d == 1
            m = m[:, 1:l-1] .|| m[:, end:-1:l+1]
        else
            m = m[1:l-1, :] .|| m[end:-1:l+1, :]
        end

        i == 1 && (println("part1: $(count(m))"))
    end

    println("part2: ")
    println.(mapslices(l -> join(map(el -> el > 0 ? "#" : " ", l)), m; dims = 2))
end

main()