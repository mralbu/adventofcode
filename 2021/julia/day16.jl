sample = """
C200B40A82
04005AC33890
38006F45291200
D2FE28
8A004A801A8002F478
620080001611562C8802118E34
C0015000016115A2E0802F182340
A0016C880162017C3686B18A3D4780
"""

abstract type AbstractPacket end

struct LiteralPacket <: AbstractPacket
    version::Int
    typeID::Int
    value::Int
end

struct OperatorPacket <: AbstractPacket
    version::Int
    typeID::Int
    lengthtypeID::Int
    subpackets::AbstractVector{AbstractPacket}
    value::Int
end

OperatorPacket(version::Int, typeID::Int, lengthtypeID::Int, subpackets::AbstractVector{AbstractPacket}) = OperatorPacket(version, typeID, lengthtypeID, subpackets, 0)

Base.show(io::IO, p::LiteralPacket) = print(io, "LiteralPacket(version=$(p.version), typeID=$(p.typeID), value=$(p.value))")
Base.show(io::IO, p::OperatorPacket) = print(io, "OperatorPacket(version=$(p.version), typeID=$(p.typeID), lengthtypeID=$(p.lengthtypeID), subpackets=$(p.subpackets))")

function parse_packet(packet::String)
    version = parse(Int, packet[1:3], base = 2)
    typeID = parse(Int, packet[4:6], base = 2)

    if (typeID == 4)
        i = 7
        value = ""
        while packet[i] != '0'
            value *= packet[i+1:i+4]
            i += 5
        end
        value *= packet[i+1:i+4]

        remainder = (length(packet) > i + 4) && (!all(==('0'), packet[i+5:end])) ? packet[i+5:end] : ""

        return LiteralPacket(version, typeID, parse(Int, value, base = 2)), remainder
    else
        length_typeID = packet[7]
        if (length_typeID == '0')
            total_length = parse(Int, packet[8:22], base = 2)

            internal_remainder = packet[23:23+total_length-1]
            subpackaget_list = AbstractPacket[]
            while length(internal_remainder) > 0
                subpackage, internal_remainder = parse_packet(internal_remainder)
                push!(subpackaget_list, subpackage)
            end

            remainder = (length(packet) > 23 + total_length - 1) ? packet[23+total_length:end] : ""
            value = operation(typeID, [p.value for p in subpackaget_list])
            return OperatorPacket(version, typeID, 0, subpackaget_list, value), remainder

        elseif (length_typeID == '1')
            n_subpackets = parse(Int, packet[8:18], base = 2)

            remainder = packet[19:end]
            subpackaget_list = AbstractPacket[]
            i = 0
            while length(remainder) > 0 && i < n_subpackets
                subpackage, remainder = parse_packet(remainder)
                push!(subpackaget_list, subpackage)
                i += 1
            end
            value = operation(typeID, [p.value for p in subpackaget_list])
            return OperatorPacket(version, typeID, 1, subpackaget_list, value), remainder
        end
    end
end

version_sum(p::OperatorPacket) = p.version + sum([version_sum(subp) for subp in p.subpackets])
version_sum(p::LiteralPacket) = p.version

function operation(typeID::Int, values::AbstractVector)::Int
    typeID == 4 && return values
    typeID == 0 && return sum(values)
    typeID == 1 && return prod(values)
    typeID == 2 && return minimum(values)
    typeID == 3 && return maximum(values)
    typeID == 5 && return Int(values[1] > values[2])
    typeID == 6 && return Int(values[1] < values[2])
    typeID == 7 && return Int(values[1] == values[2])
end

function main()
    packets = map(l -> join(lpad.(string.(hex2bytes(l), base = 2), 8, '0')), eachline("input/day16.txt"))
    # packets = map(l -> join(lpad.(string.(hex2bytes(l), base = 2), 8, '0')), eachline(IOBuffer(sample)))

    p, _ = parse_packet(packets[1])

    part1 = version_sum(p)
    part2 = p.value

    return part1, part2
end

println(main())
