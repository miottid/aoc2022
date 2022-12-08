import math, strutils


type
    Forest = object
        trees: seq[int]
        size: int
    Direction = enum north, south, east, west


proc newForest(filename: string): Forest =
    for line in lines(filename):
        if result.size == 0:
            result.size = line.len
        for c in line:
            result.trees.add(parseInt($c))


func positionMovingInDirection(forest: Forest, pos: int, steps: int, direction: Direction): int =
    case direction:
    of north: pos - steps * forest.size
    of south: pos + steps * forest.size
    of east: pos - steps
    of west: pos + steps


func maxStepsInDirection(forest: Forest, pos: int, direction: Direction): int =
    case direction:
    of north: pos div forest.size
    of south: forest.size - ((pos div forest.size) + 1)
    of east: pos mod forest.size
    of west: forest.size - (pos mod forest.size) - 1


func isTreeVisible(forest: Forest, pos: int): bool =
    # is on the edge.
    if pos mod forest.size == 0 or (pos+1) mod forest.size == 0 or 
        pos < forest.size or pos > forest.size ^ 2 - forest.size:
            return true

    for direction in [north, south, east, west]:
        var visible = true
        for step in 1..forest.maxStepsInDirection(pos, direction):
            let cmpPos = forest.positionMovingInDirection(pos, step, direction)
            if forest.trees[cmpPos] >= forest.trees[pos]:
                visible = false
                break
        if visible:
            return true


func countVisibleTrees(forest: Forest): int =
    for i in forest.trees.low..forest.trees.high:
        if isTreeVisible(forest, i):
            result += 1


func viewingDistance(forest: Forest, pos: int, direction: Direction): int =
    let tree = forest.trees[pos]

    for step in 1..forest.maxStepsInDirection(pos, direction):
        result += 1
        let cmpPos = forest.positionMovingInDirection(pos, step, direction)
        if forest.trees[cmpPos] >= tree:
            break


func highestScenicScore(forest: Forest): int =
    for pos in forest.trees.low..forest.trees.high:
        let 
            atNorth = forest.viewingDistance(pos, north)
            atSouth = forest.viewingDistance(pos, south)
            atEast = forest.viewingDistance(pos, east)
            atWest = forest.viewingDistance(pos, west)
            score = atNorth * atSouth * atEast * atWest
        if score > result: result = score


proc run*(filename: string): (int, int) =
    let forest = newForest(filename)
    (forest.countVisibleTrees, forest.highestScenicScore)
