import json


type ComparisationResult = enum
    Skip
    CorrectOrder
    IncorrectOrder


func isCorrectOrder(left, right: int): ComparisationResult =
    if left == right: Skip
    elif left < right: CorrectOrder
    else: IncorrectOrder


func compare(left, right: JsonNode): ComparisationResult =
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
        if r != Skip: return r
    return isCorrectOrder(left.len, right.len)


proc run*(filename: string): (int, int) =
    var
        packets: seq[(JsonNode, JsonNode)]
        last: JsonNode
        i = 1

    for line in lines(filename):
        let cursor = i mod 3
        case cursor:
        of 1: last = parseJson(line)
        of 2: packets.add((last, parseJson(line)))
        else: discard
        i += 1

    for i, pair in packets:
        if compare(pair[0], pair[1]) == CorrectOrder:
            result[0] += i + 1
