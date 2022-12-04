import sequtils, strutils, sugar


proc instructionToRange(instruction: string): seq[int] =
    let bounds = split(instruction, "-")
    (parseInt(bounds[0]) .. parseInt(bounds[1])).toSeq


proc part1(filename: string): int =
    for line in lines(filename):
        let assignments = split(line, ",").map(instructionToRange)
        var 
            smaller: seq[int]
            greater: seq[int]

        if assignments[0].len < assignments[1].len:
            smaller = assignments[0]
            greater = assignments[1]
        else:
            greater = assignments[0]
            smaller = assignments[1]

        if smaller.all(a => a in greater):
            result += 1


proc run*(filename: string): tuple[part1: int, part2: int] =
    (part1(filename), 0)
