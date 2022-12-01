import std/algorithm, strutils, sequtils


proc replaceMin(arr: var array[3, int], value: int) =
    for i in arr.low..arr.high:
        if value > arr[i]:
            arr[i] = value
            arr.sort()
            break


proc extractTopThree(filename: string): array[3, int] =
    var current: int
    for line in lines(filename):
        if line.isEmptyOrWhitespace:
            replaceMin(result, current)
            current = 0
        else:
            current += parseInt(line)
    replaceMin(result, current)


proc part1(filename: string): int =
    extractTopThree(filename).max


proc part2(filename: string): int =
    extractTopThree(filename).foldl(a + b)


type Day1Result = tuple[part1: int, part2: int]


proc run*(filename: string): Day1Result = 
    (part1(filename), part2(filename))
