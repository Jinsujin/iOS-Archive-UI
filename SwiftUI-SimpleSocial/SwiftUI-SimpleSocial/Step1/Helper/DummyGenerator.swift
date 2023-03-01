import Foundation

struct DummyGenerator {
    func make() -> Dictionary<UserID, User> {
        let graph = [
            "A": User(followingList: ["B", "C"], followerCount: 0),
            "B": User(followingList: [], followerCount: 2),
            "C": User(followingList: ["B", "A"], followerCount: 1),
        ]
        return graph
    }
}
