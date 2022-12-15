import algorithm, sequtils, json


func isCorrectOrder(left, right: int): int =
    if left == right: 0
    elif left < right: -1
    else: 1


func compare(left, right: JsonNode): int =
    if left.kind == JInt and right.kind == JInt:
        return isCorrectOrder(left.to(int), right.to(int))
    if left.kind == JArray and right.kind == JInt:
        let arr = newJArray()
        arr.add(right)
        return compare(left, arr)
    if left.kind == JInt and right.kind == JArray:
        let arr = newJArray()
        arr.add(left)
        return compare(arr, right)
    for i in 0..min(left.len - 1, right.len - 1):
        let r = compare(left[i], right[i])
        if r != 0: return r
    isCorrectOrder(left.len, right.len)


proc run*(filename: string): (int, int) =
    var
        packetPairs: seq[(JsonNode, JsonNode)]
        last: JsonNode
        i = 1

    for line in lines(filename):
        case i mod 3:
        of 1: last = parseJson(line)
        of 2: packetPairs.add((last, parseJson(line)))
        else: discard
        i += 1

    for i, pair in packetPairs:
        if compare(pair[0], pair[1]) == -1:
            result[0] += i + 1

    var
        dividers = @["[2]", "[6]"].mapIt(parseJson(it))
        packets: seq[JsonNode]
        dividerIndices: seq[int]

    for p in packetPairs:
        packets.add(@[p[0], p[1]])

    packets.add(dividers)

    for i, packet in packets.sorted(compare):
        if dividers.contains(packet):
            dividerIndices.add(i + 1)
        if dividerIndices.len == 2:
            break
    result[1] = dividerIndices.foldl(a*b)
