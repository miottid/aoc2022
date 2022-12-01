import unittest
import ../src/day1

const testInput = "./inputs/day1_test.txt"


test "part 1": check run(testInput).part1 == 24000


test "part 2": check run(testInput).part2 == 45000
