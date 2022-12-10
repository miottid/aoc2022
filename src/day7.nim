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


func cd(node: Node[File], dirname: string): Node[File] =
    case dirname:
    of ".":
        result = node
    of "..":
        result = node.parent
    else:
        for child in node.children:
            if child.value.name == dirname:
                return child
        let file = File(name: dirname, isDirectory: true)
        result = Node[File](value: file, parent: node)
        node.children.add(result)


func computeDirSizes(head: Node[File]) =
    for child in head.children:
        computeDirSizes(child)
        head.value.size += child.value.size


func minMaxDirs(head: Node[File], op: proc(x: int): bool): seq[Node[File]] =
    for child in head.children:
        if child.value.isDirectory:
            if op(child.value.size):
                result.add(child)
        result.add(minMaxDirs(child, op))


proc run*(filename: string): (int, int) =
    let head = Node[File](value: File())
    var current = head

    for line in lines(filename):
        if line.isEmptyOrWhitespace:
            continue
        let parts = split(line)
        if parts[0] == "$":
            if parts[1] == "cd":
                current = current.cd(parts[2])
        elif parts[0] != "dir":
            let
                file = File(name: parts[1], size: parseInt(parts[0]))
                node = Node[File](value: file, parent: current)
            current.children.add(node)

    computeDirSizes(head)

    result[0] = minMaxDirs(head, d => d <= 100_000)
        .mapIt(it.value.size)
        .foldl(a + b)

    let
        remaining = 30_000_000 - (70_000_000 - head.value.size)
        candidates = minMaxDirs(head, d => d >= remaining)
            .mapIt(it.value.size)
            .sorted()

    result[1] = candidates[0]
