import sequtils, strutils


func toPriority(c: char): int =
    ord(c) - (if c.isLowerAscii: 96 else: 38)


proc part1(filename: string): int =
    for line in lines(filename):
        let
            half = (line.high / 2).toInt
            c1 = line[line.low..<half].toSeq
            c2 = line[half..line.high].toSeq
            priorities = c1.filterIt(it in c2).deduplicate.map(toPriority)
        result.inc priorities.foldl(a + b)


proc part2(filename: string): int =
    var 
        cursor = 1
        groupItems: seq[char]

    for line in lines(filename):
        if groupItems.len == 0:
            groupItems = line.toSeq
        else:
            groupItems = groupItems.filterIt(it in line).deduplicate

        if cursor mod 3 == 0:
            result += groupItems.map(toPriority).foldl(a + b)
            groupItems = @[]

        cursor.inc


proc run*(filename: string): auto =
    (part1(filename), part2(filename))
