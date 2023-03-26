import Foundation

final class Node {
    var key: Character?
    var children: [Character: Node] = [:]
    var isFinish = false
    
    init(key: Character? = nil) {
        self.key = key
    }
}


final class TrieTree {
    private let root: Node
    
    init() {
        root = Node(key: nil)
    }
    
    func insert(_ word: String) {
        var currentNode = root
        
        for w in Array(word) {
            if currentNode.children[w] == nil {
                currentNode.children[w] = Node(key: w)
            }
            currentNode = currentNode.children[w]!
        }

        currentNode.isFinish = true
    }
    
    func isContain(_ word: String) -> Bool {
        var currentNode = root
        for w in word {
            guard let childNode = currentNode.children[w] else {
                return false
            }
            currentNode = childNode
        }
        return currentNode.isFinish
    }
    
    private func startNode(prefix: String, start: Node) -> Node? {
        var currentNode = start
        for w in prefix {
            if let child = currentNode.children[w] {
                currentNode = child
            } else {
                return nil
            }
        }
        return currentNode
    }
    
    func recusiveSearch(startNode: Node, prefixText: String) -> [String] {
        var result: [String] = []
        dfs(startNode, word: prefixText)
        
        func dfs(_ current: Node, word: String) {
            if current.isFinish {
                result.append(word)
            }
            for (key, childNode) in current.children {
                let appendedWord = "\(word)\(key)"
                dfs(childNode, word: appendedWord)
            }
        }
        return result
    }
    
    func all() -> [String] {
        return recusiveSearch(startNode: self.root, prefixText: "")
    }
    
    func startsWith(_ prefix: String) -> [String] {
        guard let startNode = startNode(prefix: prefix, start: self.root) else {
            return []
        }
        return recusiveSearch(startNode: startNode, prefixText: prefix)
    }
}
