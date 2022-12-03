import strutils


type 
    Move = enum rock = 1, paper = 2, scissors = 3
    Outcome = enum loss = 0, draw = 3, win = 6


proc toMove(name: string): Move =
    case name:
    of "A", "X": rock
    of "B", "Y": paper
    of "C", "Z": scissors
    else: raise newException(ValueError, "cannot resolve move: " & name)


proc toOutcome(name: string): Outcome =
    case name:
    of "X": loss
    of "Y": draw
    of "Z": win
    else: raise newException(ValueError, "cannot resolve outcome: " & name)


proc nextMove(move: Move, outcome: Outcome): Move =
    case outcome:
    of draw: move
    of win: 
        case move:
        of rock: paper
        of paper: scissors
        of scissors: rock
    of loss:
        case move:
        of rock: scissors
        of paper: rock
        of scissors: paper


proc computeOutcome(opponent: Move, me: Move): Outcome =
    if opponent == me: draw
    elif opponent.nextMove(win) == me: win
    else: loss


proc computeScore(opponent: Move, me: Move): int =
    ord(me) + ord(computeOutcome(opponent, me))


proc part1(filename: string): int =
    for line in lines(filename):
        let moves = split(line)
        result += computeScore(moves[0].toMove, moves[1].toMove)


proc part2(filename: string): int =
    for line in lines(filename):
        let 
            moves = split(line)
            opponent = moves[0].toMove
            expectedOutcome = moves[1].toOutcome
            me = nextMove(opponent, expectedOutcome)
        result += computeScore(opponent, me)


proc run*(filename: string): tuple[part1: int, part2: int] =
    (part1(filename), part2(filename))
