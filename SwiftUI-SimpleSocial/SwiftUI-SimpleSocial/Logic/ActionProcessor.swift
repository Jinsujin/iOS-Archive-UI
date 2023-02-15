import Foundation

// MARK: - ActionType enum
enum ActionType {
    case follow(UserID, UserID)
    case unfollow(UserID, UserID)
    case isMutualFollowing(UserID, UserID)
    case followerCount(UserID)
    case followingCount(UserID)
    case commonFollowList(UserID, UserID)
    case fetchGraph
}

// MARK: - ActionProcessor
struct ActionProcessor {
    private let system: SocialSystem
    let store: Store
    
    init(system: SocialSystem) {
        self.system = system
        self.store = system.store
    }
    
    func play(action: ActionType) -> AnyCompare {
        switch action {
        case .follow(let from, let to):
            return AnyCompare(system.follow(from, to))
        case .unfollow(let from, let to):
            return AnyCompare(system.unfollow(from, to))
        case .isMutualFollowing(let user1Id, let user2Id):
            let result = system.isMutualFollowing(user1Id, user2Id)
            return AnyCompare(result)
        case .followerCount(let userId):
            return AnyCompare(system.followerCount(userId))
        case .followingCount(let userId):
            return AnyCompare(system.followingCount(userId))
        case .commonFollowList(let user1Id, let user2Id):
            let result = system.commonFollowList(user1Id, user2Id)
            // TODO: - Array 반환
            return AnyCompare(0)
        case .fetchGraph:
            let result = system.store.graph
            print("fetch Graph: " ,result.count)
            // TODO: - dictionary 반환
            return AnyCompare(true)
        }
    }
}
