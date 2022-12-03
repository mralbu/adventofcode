using BenchmarkTools

input = read("input/day04.txt", String)
input = [
    Dict([x[1] => x[2] for x in eachmatch(r"(\w+):([\w#]+)", passport)])
    for passport in split(input, "\n\n")
]

# Part 1 ----------------------------------------------------------------

function part1(passports::Vector{<:Dict{<:Any,<:Any}})
    required_keys = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]

    return sum(
        [all(k -> k in keys(passport), required_keys) for passport in passports]
    )
end

println(part1(input))
@benchmark part1(input)

# Part 2 ----------------------------------------------------------------

function part2(passports)
    required_keys = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
    nvalid = 0
    for passport in passports
        !all(k -> k in keys(passport), required_keys) && continue
        !(1920 <= parse(Int, passport["byr"]) <= 2002) && continue
        !(2010 <= parse(Int, passport["iyr"]) <= 2020) && continue
        !(2020 <= parse(Int, passport["eyr"]) <= 2030) && continue
        !occursin(r"^\d+cm|in$", passport["hgt"]) && continue
        m = match(r"(\d+)(cm|in)", passport["hgt"])
        m[2] == "cm" && !(150 <= parse(Int, m[1]) <= 193) && continue
        m[2] == "in" && !(59 <= parse(Int, m[1]) <= 76) && continue
        !occursin(r"^#[0-9a-f]{6}$", passport["hcl"]) && continue
        !occursin(r"^amb|blu|brn|gry|grn|hzl|oth$", passport["ecl"]) && continue
        !occursin(r"^\d{9}$", passport["pid"]) && continue
        nvalid += 1
    end
    return nvalid
end
println(part2(input))
@benchmark part2(input)

# Day 4 ------------------------------------------------------------------

function day04(input)
    return part1(input), part2(input)
end
println(day04(input))
@benchmark day04(input)

