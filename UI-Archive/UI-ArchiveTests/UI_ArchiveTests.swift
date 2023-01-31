import XCTest
@testable import UI_Archive

class UI_ArchiveTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testStack_whenPushItems() throws {
        var stack = StackLinkedList<Int>()
        stack.push(data: 1)
        stack.push(data: 2)
        stack.push(data: 3)
        let count = stack.getCount()
        let peekItem = stack.peek()
        XCTAssertEqual(3, count)
        XCTAssertEqual(3, peekItem)
    }
    
    func testStack_popItem_whenNoData_expectNil() throws {
        var stack = StackLinkedList<Int>()
        let item = stack.pop()
        XCTAssertNil(item)
    }

    func testStack_push_pop() throws {
        var stack = StackLinkedList<Int>()
        let data1 = 1
        let data2 = 2
        let dataCount = 2
        stack.push(data: data1)
        stack.push(data: data2)
        
        let popItem = stack.pop()
        XCTAssertEqual(2, popItem)
        
        let resultCount1 = stack.getCount()
        XCTAssertEqual(resultCount1, dataCount - 1)
        
        let popItem2 = stack.pop()
        XCTAssertEqual(popItem2, data1)
        
        let resultCount2 = stack.getCount()
        XCTAssertEqual(resultCount2, dataCount - 2)
        
        let popItem3 = stack.pop()
        XCTAssertNil(popItem3)
    }
    
    func testStack_initializedArray() throws {
        let stack: StackLinkedList<Int> = [1,2,3]
        let peekItem = stack.peek()
        XCTAssertEqual(3, peekItem)
    }
    
    func testStack_initializeByArray() throws {
        let array: [Int] = [1, 2, 3]
        let stack = StackLinkedList<Int>(array)
        let peekItem = stack.peek()
        XCTAssertEqual(3, peekItem)
        
        let count = stack.getCount()
        XCTAssertEqual(array.count, count)
    }
    
    func testLinkedList_peekLask_whenNoData_expectNil() throws {
        let list = CircularLinkedList<String>()
        let result = list.peekLask()
        XCTAssertNil(result)
    }
    
    func testLinkedList_appendOne() throws {
        var list = CircularLinkedList<String>()
        let insertData = "1"
        list.append(insertData)
        let resultCount = list.getCount()
        XCTAssertEqual(1, resultCount)
        
        let lastData = list.peekLask()
        XCTAssertEqual(insertData, lastData)
    }
    
    func testLinkedList_appendMultiple() throws {
        var list = CircularLinkedList<String>()
        let insertData = ["1", "2", "3"]
        for d in insertData {
            list.append(d)
        }
        
        let resultCount = list.getCount()
        XCTAssertEqual(insertData.count, resultCount)
        
        let lastData = list.peekLask()
        XCTAssertEqual(insertData.last!, lastData)
        
        let firstData = list.peekFirst()
        XCTAssertEqual(insertData.first!, firstData)
    }
    
    
    func testLinkedList_insertFront() throws {
        var list = CircularLinkedList<String>()
        
        let insertData = ["1", "2", "3"]
        for d in insertData {
            list.insertFront(d)
        }
        
        let resultCount = list.getCount()
        XCTAssertEqual(insertData.count, resultCount)
        
        let lastData = list.peekLask()
        XCTAssertEqual(insertData.first!, lastData)
        
        let firstData = list.peekFirst()
        XCTAssertEqual(insertData.last!, firstData)
    }
    
    func testLinkedList_insertFront_whenExistData() throws {
        var list = CircularLinkedList<String>()
        list.append("0")
        
        let insertData = ["1", "2"]
        for d in insertData {
            list.insertFront(d)
        }
        
        let resultCount = list.getCount()
        XCTAssertEqual(insertData.count + 1, resultCount)
        
        let lastData = list.peekLask()
        XCTAssertEqual("0", lastData)
        
        let firstData = list.peekFirst()
        XCTAssertEqual(insertData.last!, firstData)
    }
    
    
    func testLinkedList_printAll() throws {
        var list = CircularLinkedList<String>()
        let insertData = ["1", "2", "3"]
        for d in insertData {
            list.append(d)
        }
        
        let resultCount = list.getCount()
        XCTAssertEqual(insertData.count, resultCount)
        
        let firstData = list.peekFirst()
        XCTAssertEqual(insertData.first!, firstData)
    }
}
