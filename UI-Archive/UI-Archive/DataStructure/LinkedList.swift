import Foundation

struct CircularLinkedList<T> {
    private var count: Int = 0
    private var head: Node<T>?
    private var tail: Node<T>?
    private var current: Node<T>?
    
    func isEmpty() -> Bool {
        return count == 0
    }
    
    func getCount() -> Int {
        return count
    }
    
    mutating func insertFront(_ data: T) {
        count += 1
        let newNode = Node(data: data)
        if (head == nil && tail == nil) {
            head = newNode
            tail = newNode
            return
        }
        
        tail?.next = newNode
        newNode.next = head
        head = newNode
    }
    
    mutating func append(_ data: T) {
        count += 1
        let newNode = Node(data: data)
        if (head == nil && tail == nil) {
            head = newNode
            tail = newNode
            return
        }
        tail?.next = newNode
        tail = newNode
        newNode.next = head
    }
    
    func printAll() {
        var currentNode = head
        repeat {
            print("→", currentNode?.data)
            currentNode = currentNode?.next
        } while (currentNode !== head)
    }
    
    func peekLask() -> T? {
        return tail?.data
    }
    
    func peekFirst() -> T? {
        return head?.data
    }
}
