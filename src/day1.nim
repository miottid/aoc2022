import strutils

proc part1(filename: string): int =
    var calories = @[0]
    for line in lines filename:
        if line == "":
            calories.add(0)
        else:
            calories[calories.high] += parseInt(line)
    calories.max

proc run*() = 
    echo "Part 1 (test): " & part1("./inputs/day1_test.txt").intToStr
    echo "Part 1: " & part1("./inputs/day1.txt").intToStr
