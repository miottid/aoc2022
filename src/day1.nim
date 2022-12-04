import sequtils, algorithm, strutils


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
            current.inc parseInt(line)
    replaceMin(result, current)


proc run*(filename: string): auto =
    let topThree = extractTopThree(filename)
    (topThree.max, topThree.foldl(a + b))
