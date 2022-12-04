import strscans


proc run*(filename: string): (int, int) =
    for line in lines(filename):
        var a, b, c, d: int
        discard line.scanf("$i-$i,$i-$i", a, b, c, d)
        if c < b and d > a: result[0].inc
        if a <= d and b >= c: result[1].inc
