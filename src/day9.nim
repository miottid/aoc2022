import strutils


type Point = tuple[x, y: int]


const
    diagonalMoves: seq[Point] = @[(-1,1),(1,1),(-1,-1),(1,-1)]
    horizontalMoves: seq[Point] = @[(1,0),(-1,0)]
    verticalMoves: seq[Point] = @[(0,1),(0,-1)]


func isInRange(head, tail: Point): bool =
    abs(head.x - tail.x) <= 1 and abs(head.y - tail.y) <= 1


func nextPosition(head, tail: Point): Point =
    let moves =
        if head.x == tail.x: verticalMoves
        elif head.y == tail.y: horizontalMoves
        else: diagonalMoves
    for op in moves:
        let newTail = (tail.x + op.x, tail.y + op.y)
        if head.isInRange(newTail):
            return newTail


proc run*(filename: string): (int, int) =
    var
        rope = newSeq[Point](10)
        nextVisits, tailVisits: seq[Point]

    for line in lines(filename):
        let
            parts = line.split(" ")
            op: Point = case parts[0]:
                of "R": verticalMoves[0]
                of "L": verticalMoves[1]
                of "U": horizontalMoves[0]
                of "D": horizontalMoves[1]
                else: raise newException(ValueError, "invalid direction")
            steps = parseInt($parts[1])

        for _ in 1..steps:
            rope[0].x += op.x
            rope[0].y += op.y

            for i in 1..rope.high:
                if rope[i-1].isInRange(rope[i]):
                    break
                rope[i] = rope[i-1].nextPosition(rope[i])

            if not nextVisits.contains(rope[1]):
                nextVisits.add(rope[1])

            if not tailVisits.contains(rope[9]):
                tailVisits.add(rope[9])

    (nextVisits.len, tailVisits.len)
