import SwiftUI

@main
struct SwiftUI_SimpleSocialApp: App {
    var body: some Scene {
        WindowGroup {
            LoginView(
                system: SocialSystem(with: DummyGenerator().make())
            )
        }
    }
}

struct DummyGenerator {
    func make() -> Dictionary<UserID, User> {
        let graph = [
            "A": User(followingList: ["B", "C"], followerCount: 0),
            "B": User(followingList: [], followerCount: 2),
            "C": User(followingList: ["B"], followerCount: 1),
        ]
        return graph
    }
}
