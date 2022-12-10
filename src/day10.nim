import sequtils, strutils, sugar


func xAtCycle(cycles: seq[int], index: int): int =
    result = 1
    for i in 0..<index-1:
        result += cycles[i]
    

proc run*(filename: string): (int, int) =
    var cycles: seq[int]

    for line in lines(filename):
        cycles.add(0)
        let parts = line.split(" ")
        if parts[0] == "addx":
            cycles.add(parseInt(parts[1]))

    let
        breakpoints = @[20, 60, 100, 140, 180, 220]
        values = breakpoints.map(x => cycles.xAtCycle(x) * x)
        sum = values.foldl(a + b)

    (sum, 0)
