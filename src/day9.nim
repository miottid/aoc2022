import strutils


type Point = tuple[x, y: int]


func isInRange(tail, head: Point): bool =
    abs(head.x - tail.x) <= 1 and abs(head.y - tail.y) <= 1


func nextPosition(tail, head: Point): Point =
    let moves: seq[Point] =
        if head.x == tail.x: @[(0, 1), (0, -1)]
        elif head.y == tail.y: @[(1, 0), (-1, 0)]
        else: @[(-1, 1), (1, 1), (-1, -1), (1, -1)]
    for op in moves:
        let newTail = (tail.x + op.x, tail.y + op.y)
        if newTail.isInRange(head):
            return newTail


proc run*(filename: string): (int, int) =
    var
        rope = newSeq[Point](10)
        nextVisits, tailVisits: seq[Point]

    for line in lines(filename):
        let
            parts = line.split(" ")
            op: Point = case parts[0]:
                of "R": ( 1,  0)
                of "L": (-1,  0)
                of "U": ( 0,  1)
                of "D": ( 0, -1)
                else: raise newException(ValueError, "invalid direction")
            steps = parseInt($parts[1])

        for _ in 1..steps:
            rope[0].x += op.x
            rope[0].y += op.y

            for i in 1..rope.high:
                if not rope[i].isInRange(rope[i-1]):
                    rope[i] = rope[i].nextPosition(rope[i-1])

            if not nextVisits.contains(rope[1]):
                nextVisits.add(rope[1])

            if not tailVisits.contains(rope[9]):
                tailVisits.add(rope[9])

    (nextVisits.len, tailVisits.len)
