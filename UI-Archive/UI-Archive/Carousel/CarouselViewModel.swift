import Foundation


struct CarouselViewModel {
    typealias ImageName = String
    
    private var imageNameList = CarouselList<ImageName>()
    private var currentNode: Node<ImageName>?
    
    mutating func prepare() {
        let imageNames = ["1", "2", "3", "4"]
        for name in imageNames {
            imageNameList.append(name)
        }
        currentNode = imageNameList.peekFirst()
    }
    
    func currentImageName() -> ImageName {
        return currentNode?.data ?? ""
    }
    
    mutating func nextItem() -> ImageName? {
        let data = currentNode?.next?.data
        currentNode = currentNode?.next
        return data
    }
    
    // TODO: test
    mutating func prevItem() -> ImageName? {
        let data = currentNode?.prev?.data
        currentNode = currentNode?.prev
        return data
    }
}


struct CarouselList<T> {
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
    
    func peekLask() -> Node<T>? {
        return tail
    }
    
    func peekFirst() -> Node<T>? {
        return head
    }
}
