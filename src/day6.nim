proc run*(filename: string): (int, int) =
    let line = readLines(filename, 1)[0]
    var pastChars: seq[char]
    for i, c in line:
        let idx = pastChars.find(c)
        if idx > -1:
            pastChars = pastChars[(idx+1)..pastChars.high]
        pastChars.add(c)
        if pastChars.len == 4:
            result[0] = i + 1
            break
