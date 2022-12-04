import algorithm, sequtils, strutils


proc instructionToRange(instruction: string): seq[int] =
    let bounds = split(instruction, "-")
    (parseInt(bounds[0]) .. parseInt(bounds[1])).toSeq


iterator assignmentPairs(filename: string): seq[seq[int]] =
    for line in lines(filename):
        let a = split(line, ",").map(instructionToRange)
        yield if a[0].len > a[1].len: a.reversed()
              else: a


proc part1(filename: string): int =
    for pair in assignmentPairs(filename):
        if pair[0].allIt(it in pair[1]):
            result += 1


proc part2(filename: string): int =
    for pair in assignmentPairs(filename):
        if pair[0].anyIt(it in pair[1]):
            result += 1


proc run*(filename: string): tuple[part1: int, part2: int] =
    (part1(filename), part2(filename))
