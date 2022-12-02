import ./day1
import ./day2

when isMainModule:
    let d1 = day1.run("./inputs/day1.txt")
    echo "[D1] 1: " & $d1.part1 & ", 2: " & $d1.part2

    let d2 = day2.run("./inputs/day2.txt")
    echo "[D2] 2: " & $d2.part1 & ", 2: " & $d2.part2
