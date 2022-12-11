import algorithm, math, sequtils, strscans, strutils


type
    Monkey = ref object
        items: seq[int]
        instruction: string
        divisibleBy, whenTrue, whenFalse: int


proc worryLevel(instruction: string, item: int): int =
    let
        op = if instruction.contains("*"): "*" else: "+"
        parts = instruction.split(" " & $op & " ")
        right = try: parseInt(parts[1]) except: item
        level = if op == "*": item * right else: item + right
    floor(level / 3).toInt


proc processRound(monkeys: seq[Monkey]): seq[int] =
    for m in monkeys:
        result.add(m.items.len)
        for item in m.items:
            let
                worryLevel = worryLevel(m.instruction, item)
                division = worryLevel / m.divisibleBy
                isDivisible = division - division.toInt.toFloat == 0
                targetMonkey =
                    if isDivisible: m.whenTrue
                    else: m.whenFalse

            monkeys[targetMonkey].items.add(worryLevel)

        m.items = @[]


proc parseMonkeys(filename: string): seq[Monkey] =
    var lineNumber: int = 0
    for line in lines(filename):
        let ln = line.strip()
        if lineNumber mod 7 == 0:
            result.add(Monkey())
        elif lineNumber mod 7 == 1:
            let
                parts = ln.split(": ")
                items = parts[1].split(", ").map(parseInt)
            result[result.high].items = items
        elif lineNumber mod 7 == 2:
            let parts = ln.split(" = ")
            result[result.high].instruction = parts[1]
        elif lineNumber mod 7 == 3:
            var divisibleBy: int
            discard ln.scanf("Test: divisible by $i", divisibleBy)
            result[result.high].divisibleBy = divisibleBy
        elif lineNumber mod 7 == 4:
            var whenTrue: int
            discard ln.scanf("If true: throw to monkey $i", whenTrue)
            result[result.high].whenTrue = whenTrue
        elif lineNumber mod 7 == 5:
            var whenFalse: int
            discard ln.scanf("If false: throw to monkey $i", whenFalse)
            result[result.high].whenFalse = whenFalse

        lineNumber += 1


proc run*(filename: string): (int, int) =
    let monkeys = parseMonkeys(filename)

    var monkeysInspections = newSeq[int](monkeys.len)
    for i in 0..<20:
        let inspections = processRound(monkeys)
        for i, nb in inspections:
            monkeysInspections[i] += nb

    let mostActiveMonkeys = monkeysInspections.sorted(SortOrder.Descending)
    (mostActiveMonkeys[0..1].foldl(a * b), 0)
