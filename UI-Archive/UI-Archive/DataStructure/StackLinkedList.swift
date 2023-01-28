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
    
    func isEmpty() -> Bool {
        return count == 0
    }
}
