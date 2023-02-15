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

// MARK: - Store ObservableObject
class Store: ObservableObject {
    @Published var graph: Dictionary<UserID, User> = [:]
    
    init() {
        self.graph = DummyGenerator().make()
    }
}

typealias UserCollection = Dictionary<UserID, User>

// MARK: - FollowSystem class
class SocialSystem {
    private(set) var store: Store
    
    init(with store: Store) {
        self.store = store
    }
    
    @discardableResult
    func follow(_ from: UserID, _ to: UserID) -> Bool {
        if var existUser = store.graph[from] {
            if (existUser.isFollow(to)) {
                return false
            }
            existUser.follow(to)
            store.graph.updateValue(existUser, forKey: from)
            plusFollowing(to)
            return true
        }
        var newUser = User()
        newUser.follow(to)
        plusFollowing(to)
        store.graph[from] = newUser
        return true
    }
    
    @discardableResult
    func unfollow(_ from: UserID, _ to: UserID) -> Bool {
        guard var fromUser = store.graph[from],
              var toUser = store.graph[to] else {
            return false
        }
        if !fromUser.unfollow(to) {
            return false
        }
        store.graph.updateValue(fromUser, forKey: from)
        toUser.minusFollow()
        store.graph.updateValue(toUser, forKey: to)
        return true
    }

    func followerCount(_ userId: UserID) -> Int {
        if let existUser = store.graph[userId] {
            return existUser.followerCount
        }
        return 0
    }
    
    func followingCount(_ userId: UserID) -> Int {
        if let existUser = store.graph[userId] {
            return existUser.followingCount
        }
        return 0
    }

    func isMutualFollowing(_ user1Id: UserID, _ user2Id: UserID) -> Bool {
        if let existUser1 = store.graph[user1Id],
           let existUser2 = store.graph[user2Id],
           existUser1.isFollow(user2Id),
           existUser2.isFollow(user1Id) {
            return true
        }
        return false
    }

    func commonFollowList(_ user1Id: UserID, _ user2Id: UserID) -> [UserID] {
        if let existUser1 = store.graph[user1Id],
           let existUser2 = store.graph[user2Id] {
            let user1Set = Set(existUser1.followingList)
            let user2Set = Set(existUser2.followingList)
            return Array(user1Set.intersection(user2Set))
        }
        return []
    }
    
    // MARK: - private functions
    private func plusFollowing(_ to: UserID) {
        if var existUser = store.graph[to] {
            existUser.plusFollow()
            store.graph.updateValue(existUser, forKey: to)
            return
        }
        var newUser = User()
        newUser.plusFollow()
        store.graph[to] = newUser
    }
}
