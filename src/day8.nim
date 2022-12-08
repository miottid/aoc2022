import math, strutils

type
    Tree = int
    Forest = object
        trees: seq[Tree]
        size: int
    Position = int
    Direction = enum north, south, east, west


proc isTreeVisible(forest: Forest, pos: Position): bool =
    # is on the edge.
    if pos mod forest.size == 0 or (pos+1) mod forest.size == 0 or 
        pos < forest.size or pos > forest.size ^ 2 - forest.size:
            return true

    let
        tree = forest.trees[pos]
        stepsDirections = {
            north: pos div forest.size,
            south: forest.size - ((pos div forest.size) + 1),
            east: pos mod forest.size,
            west: forest.size - (pos mod forest.size) - 1,
        }

    for (direction, steps) in stepsDirections:
        var visible = true
        for i in 1..steps:
            let cmpPos = case direction:
                of north: pos - i * forest.size
                of south: pos + i * forest.size
                of east: pos - i
                of west: pos + i
            if forest.trees[cmpPos] >= tree:
                visible = false
                break
        if visible:
            return true


proc `$`(forest: Forest): string =
    for i, c in forest.trees:
        result &= (if isTreeVisible(forest, i): "(+" else: "(-")
        result &= $c & ")"
        if (i+1) mod forest.size == 0:
            result &= "\n"


proc newForest(filename: string): Forest =
    for line in lines(filename):
        if result.size == 0:
            result.size = line.len
        for c in line:
            result.trees.add(parseInt($c))


proc countVisibleTrees(forest: Forest): int =
    for i in 0..forest.trees.len-1:
        if isTreeVisible(forest, i):
            result += 1


proc run*(filename: string): (int, int) =
    let forest = newForest(filename)
    result[0] = countVisibleTrees(forest)
    echo forest
