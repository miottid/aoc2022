import sequtils, strutils, strscans


proc part1(filename: string): string =
    var stacks = newSeq[seq[char]](9)

    for line in lines(filename):
        if not line.startsWith("move"):
            for i, c in line:
                if c == '[':
                    stacks[i div 4] = line[i+1] & stacks[i div 4]
        else:
            var a, f, t: int
            discard line.scanf("move $i from $i to $i", a, f, t)
            var items: seq[char]
            while a > 0:
                items.add(stacks[f-1].pop())
                a.dec
            stacks[t-1].add(items)

    stacks.filterIt(it.len > 0).mapIt(it[it.high]).join()


proc run*(filename: string): auto =
    (part1(filename), 0)
