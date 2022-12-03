import sequtils, strutils


proc toPriority(c: char): int =
    result = ord(c)
    if c.isLowerAscii: result -= 96
    else: result -= 38


proc part1(filename: string): int =
    for line in lines(filename):
        let
            half = (line.high / 2).toInt
            c1 = line[line.low..<half].toSeq
            c2 = line[half..line.high].toSeq
            priorities = c1.filterIt(it in c2).deduplicate.map(toPriority)
        result += priorities.foldl(a + b)
    

proc run*(filename: string): tuple[part1: int, part2: int] =
    (part1(filename), 0)
