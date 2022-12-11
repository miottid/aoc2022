import sequtils, strutils, sugar


iterator cycling(cycles: seq[int]): (int, int) =
    var x: int = 1
    for i in cycles.low..cycles.high:
        yield (i, x)
        x += cycles[i]


func xAtCycle(cycles: seq[int], ending: int): int =
    for i, x in cycles.cycling():
        if i+1 == ending:
            return x


func crtLine(cycles: seq[int], width, ending: int): string =
    result = "#"
    for i, x in cycles.cycling():
        if ending - (width - 1) <= i:
            let draw = x - 1 <= result.len and x + 1 >= result.len
            result &= (if draw: "#" else: ".")
        if i+1 == ending:
            break


proc run*(filename: string): (int, string) =
    var cycles: seq[int]
    for line in lines(filename):
        cycles.add(0)
        let parts = line.split(" ")
        if parts[0] == "addx":
            cycles.add(parseInt(parts[1]))

    let
        xs = @[20,60,100,140,180,220].map(x => cycles.xAtCycle(x) * x)
        crts = @[40,80,120,160,200,240].map(x => cycles.crtLine(40, x))

    (xs.foldl(a + b), crts.join("\n"))
