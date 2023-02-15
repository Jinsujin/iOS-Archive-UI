import SwiftUI

struct HomeView: View {
    var userID: String
    let processor: ActionProcessor
    
    func unFollow(from: UserID, to: UserID) {
        print("unFollow, \(from) -> \(to)")
        let result = processor.play(action: .unfollow(from, to))
        print(result)
    }
    
    var body: some View {
        NavigationView {
            TabView {
                let followingList = processor.store.graph[userID]?.followingList ?? []
                
                UserView(followingList: followingList) { to in
                    unFollow(from: userID, to: to)
                    }.tabItem {
                        Label("Home", systemImage: "person")
                    }
                SearchView()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass.circle.fill")
                    }
            }
            .navigationTitle("\(userID) 로 로그인 되었습니다")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(userID: "UserID", processor: ActionProcessor(system: SocialSystem(with: Store())))
    }
}
