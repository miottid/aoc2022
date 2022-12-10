import unittest
import ../src/day1
import ../src/day2
import ../src/day3
import ../src/day4
import ../src/day5
import ../src/day6
import ../src/day7
import ../src/day8
import ../src/day9


test "day1": check day1.run("./tests/inputs/day1.txt") == (24000, 45000)
test "day2": check day2.run("./tests/inputs/day2.txt") == (15, 12)
test "day3": check day3.run("./tests/inputs/day3.txt") == (157, 70)
test "day4": check day4.run("./tests/inputs/day4.txt") == (2, 4)
test "day5": check day5.run("./tests/inputs/day5.txt") == ("CMZ", "MCD")
test "day6-1": check day6.run("./tests/inputs/day6_1.txt") == (7, 19)
test "day6-2": check day6.run("./tests/inputs/day6_2.txt") == (5, 23)
test "day6-3": check day6.run("./tests/inputs/day6_3.txt") == (6, 23)
test "day6-4": check day6.run("./tests/inputs/day6_4.txt") == (10, 29)
test "day6-5": check day6.run("./tests/inputs/day6_5.txt") == (11, 26)
test "day7": check day7.run("./tests/inputs/day7.txt") == (95437, 24933642)
test "day8": check day8.run("./tests/inputs/day8.txt") == (21, 8)
test "day9-1": check day9.run("./tests/inputs/day9_1.txt") == (13, 1)
test "day9-2": check day9.run("./tests/inputs/day9_2.txt") == (88, 36)
