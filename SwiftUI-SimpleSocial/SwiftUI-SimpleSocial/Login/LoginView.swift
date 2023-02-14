import SwiftUI

struct LoginView: View {
    
    let system: SocialSystem
    
    var body: some View {
        NavigationView {
            let userIDs: [UserID] = system.graph.map { $0.key }
            
            List(userIDs, id: \.self) { key in
                LoginCellView(userID: key, followingList: system.graph[key]?.followingList ?? [])
            }
            .navigationTitle("로그인 유저 선택")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct LoginCellView: View {
    var userID: UserID
    var followingList: [UserID]
    
    var body: some View {
        NavigationLink(destination: HomeView(userID: userID, followingList: followingList)) {
            HStack {
                Image(systemName: "person")
                Text(userID)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(
            system: SocialSystem(with: DummyGenerator().make())
        )
    }
}

