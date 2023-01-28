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
    
}
