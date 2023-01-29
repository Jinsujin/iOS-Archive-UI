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

struct StackLinkedList<T> {
    private var head: Node<T>?
    private var count: Int = 0
    
    /// 기존 배열을 사용해 값을 초기화할 수 있는 생성자
    init<S: Sequence>(_ s: S) where S.Iterator.Element == T {
        for el in s {
            push(data: el)
        }
    }
    
    func isEmpty() -> Bool {
        return count == 0
    }
    
    func getCount() -> Int {
        return count
    }
    
    /// 가장 상위에 있는 데이터를 반환
    func peek() -> T? {
        return head?.data
    }
    
    /// head 에 새로운 데이터 추가
    mutating func push(data: T) {
        let newNode = Node(data: data)
        
        // 이미 데이터가 들어있다면
        if !isEmpty() {
            newNode.prev = head
        }
        head = newNode
        count += 1
    }
    

    /// 가장 위에있는 데이터를 삭제하고, 삭제한 데이터 반환
    mutating func pop() -> T? {
        if isEmpty() {
            return nil
        }
        let data = head?.data
        head = head?.prev
        count -= 1
        return data
    }
}

extension StackLinkedList: ExpressibleByArrayLiteral {
    typealias ArrayLiteralElement = T
    
    public init(arrayLiteral elements: ArrayLiteralElement...) {
        for el in elements {
            push(data: el)
        }
    }
}


struct NodeIterator<T>: IteratorProtocol {
    typealias Element = T
    private var head: Node<Element>?
    
    init(head: Node<T>?) {
        self.head = head
    }
    
    mutating func next() -> T? {
        if (head != nil) {
            let item = head?.data
            head = head?.prev
            return item
        }
        return nil
    }
}

extension StackLinkedList: Sequence {
    typealias Iterator = NodeIterator<T>
    func makeIterator() -> Iterator {
        return Iterator(head: head)
    }
}
