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


// MARK: - Type Eraser Wrapper
private protocol AnyTypeBase {
    var value: Any { get }
}

/// AnyTypeBase 을 채택한 구체 인스턴스를 담는 상자
private struct AnyComparableBox<T: Comparable>: AnyTypeBase {
    let origin: T
    var value: Any { self.origin }
}

/// `Public Wrapper` (값을 감싸는 타입)
/// - private box 에 구체 인스턴스를 담는다
struct AnyCompare: Comparable {
    private var box: AnyTypeBase

    public init<T>(_ value: T) where T : Comparable {
        box = AnyComparableBox(origin: value)
    }
    
    var value: Any {
        return box.value
    }
    
    static func < (lhs: AnyCompare, rhs: AnyCompare) -> Bool {
        return false
    }
    static func == (lhs: AnyCompare, rhs: AnyCompare) -> Bool {
        return false
    }
}

// MARK: - Bool extension
extension Bool: Comparable {
    public static func < (lhs: Bool, rhs: Bool) -> Bool {
        return false
    }
}
