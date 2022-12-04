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
    if me == opponent: draw
    elif me == opponent.nextMove(win): win
    else: loss


proc computeScore(opponent: Move, me: Move): int =
    ord(me) + ord(computeOutcome(opponent, me))


proc run*(filename: string): (int, int) =
    for line in lines(filename):
        let 
            parts = split(line)
            opponent = parts[0].toMove
            me = nextMove(opponent, parts[1].toOutcome)
        result[0].inc computeScore(opponent, parts[1].toMove)
        result[1].inc computeScore(opponent, me)
