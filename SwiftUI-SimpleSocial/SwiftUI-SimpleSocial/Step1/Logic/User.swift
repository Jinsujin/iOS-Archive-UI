import Foundation

typealias UserID = String

// MARK: - User struct
struct User {
    private(set) var followingList = [UserID]()
    private(set) var followerCount: Int = 0
    
    var followingCount: Int {
        get {
            return followingList.count
        }
    }
    
    @discardableResult
    mutating func follow(_ to: UserID) -> Bool {
        followingList.append(to)
        return true
    }
    
    mutating func plusFollow() {
        followerCount += 1
    }
    
    mutating func minusFollow() {
        followerCount -= 1
    }
    
    mutating func unfollow(_ to: UserID) -> Bool {
        guard let index = followingList.firstIndex(of: to) else {
            return false
        }
        followingList.remove(at: index)
        return true
    }
    
    func isFollow(_ to: UserID) -> Bool {
        if followingList.contains(to) {
            return true
        }
        return false
    }
}
