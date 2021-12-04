using DelimitedFiles

sample = """
7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

22 13 17 11  0
 8  2 23  4 24
21  9 14 16  7
 6 10  3 18  5
 1 12 20 15 19

 3 15  0  2 22
 9 18 13 17  5
19  8  7 25 23
20 11 10 24  4
14 21 16 12  6

14 21 17 24  4
10 16 15  9 19
18  8 23 26 20
22 11 13  6  5
 2  0 12  3  7"""

function parse_input(input)
    draws = parse.(Int, split(readline(input), ","))
    cards = readdlm(input, skipstart = 1, Int)
    n_rows, n_cols = size(cards)

    return draws, [cards[i:i+n_cols-1, :] for i = 1:n_cols:n_rows]
end

check_win(mark) = any(prod(mark, dims = 1)) || any(prod(mark, dims = 2))
bingo_score(last_draw, card, mark) = last_draw * sum(.!mark .* card)

draws, cards = parse_input("input/day04.txt")
# draws, cards = parse_input(IOBuffer(sample))

# Part 1 ----------------------------------------------------------------------------------

function part1(draws, cards)
    marks = [BitMatrix(zero(card)) for card in cards]

    for draw in draws
        for (i, card) in enumerate(cards)
            marks[i] .|= (draw .∈ card)
            check_win(marks[i]) && return bingo_score(draw, card, marks[i])
        end
    end
end

println("Part1: $(part1(draws, cards))")
# @benchmark part1(draws, cards)

# Part 2 ----------------------------------------------------------------------------------

function part2(draws, cards)
    marks = [BitMatrix(zero(card)) for card in cards]
    n_cards = length(cards)
    winning_cards = Set()

    for draw in draws
        for (i, card) in enumerate(cards)
            marks[i] .|= (draw .∈ card)
            check_win(marks[i]) && (push!(winning_cards, i))
            length(winning_cards) == n_cards && (return bingo_score(draw, card, marks[i]))
        end
    end
end

println("Part2: $(part2(draws, cards))\n")
