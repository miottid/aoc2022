import algorithm, sequtils, strscans, strutils


type Monkey = ref object
    starting: seq[int]
    operation: (string, string)
    divisibleBy, whenTrue, whenFalse: int


const
    testMatch = "Test: divisible by $i"
    testTrueMatch = "If true: throw to monkey $i"
    testFalseMatch = "If false: throw to monkey $i"


proc parseMonkeys(filename: string): seq[Monkey] =
    var i: int = 0
    for line in lines(filename):
        let
            ln = line.strip()
            cursor = i mod 7

        case cursor:
        of 0: result.add(Monkey())
        of 1:
            let parts = ln.split(": ")
            result[result.high].starting = parts[1]
                .split(", ").mapIt(it.parseInt)
        of 2:
            let
                tmp = ln.split(" = ")
                op = if tmp[1].contains("*"): "*" else: "+"
                parts = tmp[1].split($op)
            result[result.high].operation = (op, parts[1].strip())
        of 3:
            var divisibleBy: int
            discard ln.scanf(testMatch, divisibleBy)
            result[result.high].divisibleBy = divisibleBy
        of 4:
            var whenTrue: int
            discard ln.scanf(testTrueMatch, whenTrue)
            result[result.high].whenTrue = whenTrue
        of 5:
            var whenFalse: int
            discard ln.scanf(testFalseMatch, whenFalse)
            result[result.high].whenFalse = whenFalse
        else: discard

        i += 1


func monkeyBusiness(monkeys: seq[Monkey], round: int, divideByThree = true): int =
    let lcm = monkeys.mapIt(it.divisibleBy).foldl(a*b)
    var counts = newSeq[int](monkeys.len)

    for _ in 0..<round:
        for i, m in monkeys:
            counts[i] += m.starting.len

            for item in m.starting:
                let
                    right =
                        if m.operation[1] == "old": item
                        else: parseInt(m.operation[1])
                    level =
                        if m.operation[0] == "*": item * right
                        else: item + right
                    normLevel =
                        if divideByThree: level div 3
                        else: level mod lcm
                    divisible = normLevel mod m.divisibleBy == 0
                    target =
                        if divisible: m.whenTrue
                        else: m.whenFalse

                monkeys[target].starting.add(normLevel)

            m.starting = @[]

    counts.sorted(Descending)[0..1].foldl(a * b)


proc run*(filename: string): (int, int64) =
    result[0] = monkeyBusiness(parseMonkeys(filename), 20)
    result[1] = monkeyBusiness(parseMonkeys(filename), 10_000, false)
