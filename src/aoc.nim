import ./day1

when isMainModule:
  let d1 = day1.run("./inputs/day1.txt")
  echo "[D1] 1: " & $d1.part1 & ", 2: " & $d1.part2
  
