sample = """[[[0,[4,5]],[0,0]],[[[4,5],[2,6]],[9,5]]]
[7,[[[3,7],[4,3]],[[6,3],[8,8]]]]
[[2,[[0,8],[3,4]]],[[[6,7],1],[7,[1,6]]]]
[[[[2,4],7],[6,[0,5]]],[[[6,8],[2,8]],[[2,1],[4,5]]]]
[7,[5,[[3,8],[1,4]]]]
[[2,[2,2]],[8,[8,1]]]
[2,9]
[1,[[[9,3],9],[[9,0],[0,7]]]]
[[[5,[7,4]],7],1]
[[[[4,2],2],6],[8,7]]"""

function magnitude(x)
    x1, x2 = x
    magx1 = x1 isa Number ? x1 : magnitude(x1)
    magx2 = x2 isa Number ? x2 : magnitude(x2)

    return 3 * magx1 + 2 * magx2
end
magnitude(x::String) = magnitude(Meta.parse(x) |> eval)

function explode(str)
    levels, levelnum = "", 0
    for x in collect(str)
        x == '[' && (levelnum += 1)
        x == ']' && (levelnum -= 1)
        levels *= string(levelnum)
    end

    ms = [m for m in eachmatch(r"\[(\d+),(\d+)\]", str) if levels[m.offset] == '5']

    isempty(ms) && (return str)

    m = ms[1]
    str = replace(str, m.match => "0", count = 1)
    x1, x2 = parse.(Int, m.captures)
    idx_m = m.offset

    m2s = [m2 for m2 in eachmatch(r"(\d+)", str[1:idx_m-1])]
    if !isempty(m2s)
        m2 = m2s[end]
        str = str[1:m2.offset-1] * replace(str[m2.offset:idx_m-1], m2.match => string(x1 + parse(Int, m2.captures[1])), count = 1) * str[idx_m:end]
        idx_m += length(string(x1 + parse(Int, m2.captures[1]))) - length(m2.match)
    end

    m3s = [m3 for m3 in eachmatch(r"(\d+)", str[idx_m+1:end])]
    if !isempty(m3s)
        m3 = m3s[1]
        str = str[1:idx_m+1] * replace(str[idx_m+2:end], m3.match => string(x2 + parse(Int, m3.captures[1])), count = 1)
    end

    return str
end

explode("[[[[0,7],4],[7,[[8,4],9]]],[1,1]]")
"[[[[0,7],4],[15,[0,13]]],[1,1]]"

function splitit(str)
    x = [x.match for x in eachmatch(r"\d+", str) if parse(Int, x.match) >= 10]
    if !isempty(x)
        numstr = x[1]
        num = parse(Int, numstr)
        split_pair = "[" * string(num ÷ 2, ",", ceil(Int, num / 2)) * "]"
        str = replace(str, numstr => split_pair, count = 1)
    end
    return str
end

function add(x::String, y::String)
    str = "[" * x * "," * y * "]"

    while true
        # println(str)
        old = str
        strexp = explode(str)
        str != strexp && (str = strexp; continue)

        # println("splitit")
        strspl = splitit(str)
        str != strspl && (str = strspl; continue)

        strspl == old && strexp == old && break
    end

    return str
end

lines = readlines(IOBuffer(sample))
lines[1:2]
str = "[[[[4,0],[5,4]],[[7,7],[6,0]]],[[8,[7,7]],[[7,9],[5,0]]]]"
add(lines[1], lines[2])

add("[[[[4,3],4],4],[7,[[8,4],9]]]", "[1,1]")

str = reduce(add, lines[2:end], init = lines[1])
1
add("[[[[4,0],[5,4]],[[7,7],[6,0]]],[[8,[7,7]],[[7,9],[5,0]]]]", "[[2,[[0,8],[3,4]]],[[[6,7],1],[7,[1,6]]]]")
"[[[[6,7],[6,7]],[[7,7],[0,7]]],[[[8,7],[7,7]],[[8,8],[8,0]]]]"


str = "[[[[[4,0],[5,4]],[[7,7],[6,0]]],[[8,[7,7]],[[7,9],[5,0]]]],[[2,[[0,8],[3,4]]],[[[6,7],1],[7,[1,6]]]]]"
str = explode(str)
str = splitit(str)


str = lines[1]
str = add(str, lines[2])
str = add(str, lines[3])
str = add(str, lines[4])
str = add(str, lines[5])


str = "[1,1]"
str = add(str, "[2,2]")
str = add(str, "[3,3]")
str = add(str, "[4,4]")
str = add(str, "[5,5]")
str = add(str, "[6,6]")


str = "[" * lines[1] * "," * lines[2] * "]"
explode(str)

str = reduce(add, lines[2:end], init = lines[1])
magnitude(str)

function main()
    # lines = readlines("input/day18.txt")
    lines = readlines(IOBuffer(sample))

    str = reduce(add, lines[2:end], init = lines[1])
    println(magnitude(str))
end

