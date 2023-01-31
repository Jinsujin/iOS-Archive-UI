import Foundation

class Node<T> {
    var data: T
    var next: Node?
    var prev: Node?
    
    init(data: T) {
        next = nil
        prev = nil
        self.data = data
    }
}
