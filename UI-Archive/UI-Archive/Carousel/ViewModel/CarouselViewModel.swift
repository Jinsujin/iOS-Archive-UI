import Foundation


struct CarouselViewModel {
    typealias ImageName = String
    
    private var imageNameList = CarouselList<ImageName>()
    private var currentNode: Node<ImageName>?
    
    mutating func prepare() {
        imageNameList = ["1", "2", "3", "4"]
        currentNode = imageNameList.peekFirst()
    }
    
    mutating func nextItem() -> ImageName? {
        let data = currentNode?.next?.data
        currentNode = currentNode?.next
        return data
    }
    
    mutating func prevItem() -> ImageName? {
        let data = currentNode?.prev?.data
        currentNode = currentNode?.prev
        return data
    }
    
    func currentImageName() -> ImageName {
        return currentNode?.data ?? ""
    }
}


// MARK: - CarouselList
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
        head?.prev = newNode
        tail?.next = newNode
        newNode.next = head
        newNode.prev = tail
        head = newNode
    }
    
    mutating func append(_ data: T) {
        count += 1
        let newNode = Node(data: data)
        if (head == nil && tail == nil) {
            head = newNode
            tail = newNode
            newNode.prev = newNode
            newNode.next = newNode
            return
        }
        newNode.next = head
        newNode.prev = tail
        tail?.next = newNode
        tail = newNode
        head?.prev = tail
    }
    
    func printAll() {
        var currentNode = head
        repeat {
            print("→", currentNode?.data)
            currentNode = currentNode?.next
        } while (currentNode !== head)
    }
    
    func printReverse() {
        var currentNode = tail
        repeat {
            print("→", currentNode?.data)
            currentNode = currentNode?.prev
        } while (currentNode !== tail)
    }
    
    func peekLask() -> Node<T>? {
        return tail
    }
    
    func peekFirst() -> Node<T>? {
        return head
    }
}

extension CarouselList: ExpressibleByArrayLiteral {
    typealias ArrayLiteralElement = T
    
    public init(arrayLiteral elements: ArrayLiteralElement...) {
        for el in elements {
            append(el)
        }
    }
}
