import XCTest
@testable import SwiftUI_SimpleSocial

final class SocialSystemTests: XCTestCase {

    var sut: SocialSystem!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = SocialSystem()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    func test_afterFollow_compareFollowingCount() throws {
        sut.follow("A", "B")
        sut.follow("A", "C")
        let result = sut.followingCount("A")
        XCTAssertEqual(2, result)
    }
    
    func test_afterUnFollow_compareFollowingCount() throws {
        sut.follow("A", "B")
        sut.unfollow("A", "B")
        let result = sut.followingCount("A")
        XCTAssertEqual(0, result)
    }

    func test_afterFollow_isMutualFollowing() throws {
        sut.follow("A", "B")
        sut.follow("B", "A")
        let result = sut.isMutualFollowing("A", "B")
        XCTAssertEqual(true, result)
    }
    
    func test_afterFollow_compareFollowerCount() throws {
        sut.follow("B", "A")
        sut.follow("C", "A")
        let result = sut.followerCount("A")
        XCTAssertEqual(2, result)
    }

    func testPerformance() throws {
        // A -> B | A <-> C | C -> B
        sut.follow("A", "B")
        sut.follow("A", "C")
        sut.follow("C", "A")
        sut.follow("C", "B")
        
        self.measure {
            let _ = sut.commonFollowList("A", "C")
        }
    }
}
