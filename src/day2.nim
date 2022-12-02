import strutils
import ./result


type 
    Move = enum
        rock = 1, paper = 2, scissors = 3


proc initMove(name: string): Move =
    if name == "A" or name == "X":
        result = Move.rock
    elif name == "B" or name == "Y":
        result = Move.paper
    elif name == "C" or name == "Z":
        result = Move.scissors
    else:
        raise newException(ValueError, "cannot resolve move: " & name)


proc computeOutcome(opponent: Move, me: Move): int =
    if opponent == me: return 3
    if (
        opponent == Move.rock and me == Move.paper or 
        opponent == Move.scissors and me == Move.rock or 
        opponent == Move.paper and me == Move.scissors
    ): return 6
    0


proc computeScore(opponent: Move, me: Move): int = ord(me) + computeOutcome(opponent, me)


proc part1(filename: string): int =
    for line in lines(filename):
        let moves = split(line)
        result += computeScore(initMove(moves[0]), initMove(moves[1]))


proc run*(filename: string): DayResult = 
    let part1 = part1(filename)
    (part1, 0)
