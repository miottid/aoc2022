import sequtils, strutils, strscans

type
    Cargo = seq[seq[char]]
    Instruction = (int, int, int)
    World = tuple[cargo: Cargo, instructions: seq[Instruction]]


func parseInstruction(line: string): Instruction =
    var a, f, t: int
    discard line.scanf("move $i from $i to $i", a, f, t)
    (a, f-1, t-1)


proc parseCargoAndInstructions(filename: string): World =
    for line in lines(filename):
        if not line.startsWith("move"):
            for i, c in line:
                if c == '[':
                    let idx = i div 4
                    if idx >= result.cargo.len:
                        result.cargo.setLen(idx+1)
                    result.cargo[idx] = line[i+1] & result.cargo[idx]
        else:
            result.instructions.add(line.parseInstruction)


func cratesOnTop(cargo: Cargo): string = cargo.mapIt(it[it.high]).join()


proc run*(filename: string): auto =
    let (cargo, instructions) = parseCargoAndInstructions(filename)
    var cargo1, cargo2 = cargo

    for (a, f, t) in instructions:
        var
            items1, items2: seq[char]
            amount = a

        for _ in countdown(amount, 1):
            items1.add(cargo1[f].pop())
            items2 = cargo2[f].pop() & items2

        cargo1[t].add(items1)
        cargo2[t].add(items2)

    (cargo1.cratesOnTop, cargo2.cratesOnTop)
