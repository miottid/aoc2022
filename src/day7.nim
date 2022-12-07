import algorithm, sequtils, strutils, sugar


type
    Node[T] = ref object
        value: T
        children: seq[Node[T]]
        parent: Node[T]

    File = ref object
        name: string
        size: int
        isDirectory: bool


proc cd(node: Node[File], dirname: string): Node[File] =
    case dirname:
    of ".":
        result = node
    of "..":
        result = node.parent
    else:
        for child in node.children:
            if child.value.name == dirname:
                return child
        result = Node[File](value: File(name: dirname, isDirectory: true))
        result.parent = node
        node.children.add(result)


proc `$`(file: File): string =
    let
        fileType = (if file.isDirectory: "dir" else: "file")
        details = "(" & fileType & ", size=" & file.size.intToStr & ")"
    file.name & " " & details


proc `$`(node: Node[File], level: int = 0): string =
    let sorted = node.children.sorted((a, b) => a.value.name.cmp(b.value.name))
    for child in sorted:
        result &= " ".repeat(level) & "- " & $child.value & "\n"
        if child.children.len > 0:
            result &= child$(level + 1)


proc computeDirSize(node: Node[File]) =
    for child in node.children:
        computeDirSize(child)
        node.value.size += child.value.size


proc findDirsMaxSize(node: Node[File], maxSize: int = 100_000): seq[Node[File]] =
    for child in node.children:
        if child.value.isDirectory:
            if child.value.size <= maxSize:
                result.add(child)
        result.add(findDirsMaxSize(child))


proc run*(filename: string): (int, int) = 
    var
        head = Node[File](value: File(name: "root"))
        current = head

    for line in lines(filename):
        if line.isEmptyOrWhitespace:
            continue
        let parts = split(line)
        if parts[0] == "$":
            if parts[1] == "cd":
                current = current.cd(parts[2])
        elif parts[0] != "dir":
            let file = File(name: parts[1], size: parseInt(parts[0]))
            current.children.add(Node[File](value: file))

    computeDirSize(head)

    result[0] = findDirsMaxSize(head).mapIt(it.value.size).foldl(a + b)
