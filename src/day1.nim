import sequtils, algorithm, strutils
import ./result


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


proc run*(filename: string): DayResult = 
    let
        part1 = extractTopThree(filename).max
        part2 = extractTopThree(filename).foldl(a + b)
    (part1, part2)
