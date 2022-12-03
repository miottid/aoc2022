import ./day1
import ./day2
import ./day3


when isMainModule:
    for i, r in [
        day1.run("./inputs/day1.txt"),
        day2.run("./inputs/day2.txt"),
        day3.run("./inputs/day3.txt"),
    ]: echo "D", i + 1, " ", r
