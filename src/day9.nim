import strutils, sequtils


type Point = tuple[x: int, y: int]


func isInRange(tail: Point, head: Point): bool =
    let computations: seq[Point] = @[
        (-1,  1), ( 0,  1), ( 1,  1),
        (-1,  0), ( 0,  0), ( 1,  0),
        (-1, -1), ( 0, -1), ( 1, -1),
    ]
    computations.anyIt(
        tail.x + it.x == head.x and 
            tail.y + it.y == head.y
    )


func nextPosition(tail: Point, head: Point): Point =
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
        head: Point
        tail: Point
        visits: seq[Point] = @[(0, 0)]
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
            head.x += op.x
            head.y += op.y
            if not tail.isInRange(head):
                tail = tail.nextPosition(head)
                visits.add(tail)

    result[0] = deduplicate(visits).len
