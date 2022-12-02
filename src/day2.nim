import strutils, tables


type 
    Move = enum rock = 1, paper = 2, scissors = 3
    Outcome = enum loss = 0, draw = 3, win = 6


proc initMove(name: string): Move =
    if name == "A" or name == "X": Move.rock
    elif name == "B" or name == "Y": Move.paper
    elif name == "C" or name == "Z": Move.scissors
    else: raise newException(ValueError, "cannot resolve move: " & name)


proc initOutcome(name: string): Outcome =
    if name == "X": Outcome.loss
    elif name == "Y": Outcome.draw
    elif name == "Z": Outcome.win
    else: raise newException(ValueError, "cannot resolve outcome: " & name)


const
    winingOutcomeMapping = { 
        Move.rock: Move.paper,
        Move.paper: Move.scissors,
        Move.scissors: Move.rock }.toTable

    losingOutcomeMapping = { 
        Move.paper: Move.rock,
        Move.scissors: Move.paper,
        Move.rock: Move.scissors }.toTable


proc computeOutcome(opponent: Move, me: Move): Outcome =
    if opponent == me: Outcome.draw
    elif winingOutcomeMapping[opponent] == me: Outcome.win
    else: Outcome.loss


proc resolveMoveForOutcome(opponent: Move, outcome: Outcome): Move =
    if outcome == Outcome.draw: opponent
    elif outcome == Outcome.win: winingOutcomeMapping[opponent]
    else: losingOutcomeMapping[opponent]


proc computeScore(opponent: Move, me: Move): int =
    ord(me) + ord(computeOutcome(opponent, me))


proc part1(filename: string): int =
    for line in lines(filename):
        let moves = split(line)
        result += computeScore(initMove(moves[0]), initMove(moves[1]))


proc part2(filename: string): int =
    for line in lines(filename):
        let 
            moves = split(line)
            opponent = initMove(moves[0])
            expectedOutcome = initOutcome(moves[1])
            me = resolveMoveForOutcome(opponent, expectedOutcome)
        result += computeScore(opponent, me)


proc run*(filename: string): tuple[part1: int, part2: int] =
    (part1(filename), part2(filename))
