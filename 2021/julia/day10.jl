sample = """
[({(<(())[]>[[{[]{<()<>>
[(()[<>])]({[<{<<[]>>(
{([(<{}[<>[]}>{[]{[(<()>
(((({<>}<{<{<>}{[]{[]{}
[[<[([]))<([[{}[[()]]]
[{[{({}]{}}([{[{{{}}([]
{<[[]]>}<{[{[{[]{()[[[]
[<(<(<(<{}))><([]([]()
<{([([[(<>()){}]>(<<{{
<{([{{}}[<[[[<>{}]]]>[]]"""

function main()
    lines = readlines("input/day10.txt")
    # lines = readlines(IOBuffer(sample))

    openings = ['(', '[', '{', '<']
    closings = [')', ']', '}', '>']
    codec = Dict(zip(closings, openings))
    illegal_points = Dict(zip(closings, [3, 57, 1197, 25137]))
    autocomp_points = Dict(zip(openings, [1, 2, 3, 4]))

    corrupt_closings = Char[]
    autocomp_scores = Int[]

    for line in lines

        corrupt_flag = false
        stack = Char[]
        for c in line
            c ∈ openings && (push!(stack, c); continue)
            if (codec[c] != last(stack))
                push!(corrupt_closings, c)
                corrupt_flag = true
                break
            end
            pop!(stack)
        end
        if !corrupt_flag
            autocomp_score = 0
            for c in reverse(stack)
                autocomp_score = 5 * autocomp_score + autocomp_points[c]
            end
            push!(autocomp_scores, autocomp_score)
        end
    end

    part1 = sum(illegal_points[c] for c in corrupt_closings)
    part2 = partialsort(autocomp_scores, length(autocomp_scores) ÷ 2 + 1)

    return part1, part2
end

println(main())
