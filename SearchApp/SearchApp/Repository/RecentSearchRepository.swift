import Foundation

class RecentSearchRepository {
    
    private let tree = TrieTree()
    
    init(words: [String] = []) {
        words.forEach({ tree.insert($0) })
    }
    
    func append(_ text: String) {
        tree.insert(text)
    }
    
    func all() -> [String] {
        return tree.all()
    }
    
    func prefixWords(with text: String) -> [String] {
        return tree.startsWith(text)
    }
}
