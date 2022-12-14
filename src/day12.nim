import heapqueue, tables

type
    Point = tuple[x, y: int]
    World = tuple
        data: seq[int]
        width: int
        start: Point
        finish: Point


proc parseWorld(filename: string): World =
    const minElevation = ord('a')
    var y: int
    for line in lines(filename):
        if result.width == 0: result.width = line.len
        let height = result.data.len div result.width
        for x, c in line:
            let elevation = if c == 'S':
                result.start = (x, height)
                minElevation
            elif c == 'E':
                result.finish = (x, height)
                ord('z')
            else:
                ord(c)
            result.data.add(elevation - minElevation)
        y += 1


func valueAt(world: World, p: Point): int = world.data[p.y * world.width + p.x]


proc run*(filename: string): (int, int) = 
    let world = parseWorld(filename)
    var
        dists = { world.finish: 0 }.toTable
        queue = [(0, world.finish)].toHeapQueue

    while len(queue) > 0:
        let (cost, current) = queue.pop()

        for (x, y) in @[(0,-1),(0,1),(1,0),(-1,0)]:
            let next: Point = (current.x+x, current.y+y)

            if next.x < 0 or next.x > world.width-1:
                continue
            if next.y < 0 or next.y > (world.data.len div world.width)-1:
                continue
            let
                nval = world.valueAt(next)
                cval = world.valueAt(current)
            if cval - nval > 1:
                continue

            try:
                let ncost = cost + 1
                if ncost < dists.getOrDefault(next, high(int)):
                    dists[next] = ncost
                    queue.push((ncost, next))
            except IndexDefect:
                continue

    result[0] = dists[world.start]
