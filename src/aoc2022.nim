import ./day1
import ./day2
import ./day3
import ./day4


when isMainModule:
    for i, r in [
        day1.run("./inputs/day1.txt"),
        day2.run("./inputs/day2.txt"),
        day3.run("./inputs/day3.txt"),
        day4.run("./inputs/day4.txt"),
    ]: echo "D", i + 1, " ", r
