proc run*(filename: string): (int, int) =
    let line = readLines(filename, 1)[0]
    var unique: seq[char]
    for i, c in line:
        let idx = unique.find(c)
        if idx > -1:
            unique = unique[(idx+1)..unique.high]
        unique.add(c)
        if result[0] == 0 and unique.len == 4:
            result[0] = i + 1
        elif unique.len == 14:
            result[1] = i + 1
            break
