import ./day1
import ./day2


when isMainModule:
    for i, r in [
        day1.run("./inputs/day1.txt"),
        day2.run("./inputs/day2.txt")
    ]: echo "D", i, " ", r
