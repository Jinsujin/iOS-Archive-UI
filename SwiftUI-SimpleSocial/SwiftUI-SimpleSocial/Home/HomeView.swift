import SwiftUI

struct HomeView: View {
    var userID: String
    var followingList: [UserID]
    
    var body: some View {
        NavigationView {
            TabView {
                UserView(followingList: followingList)
                    .tabItem {
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
        HomeView(userID: "UserID", followingList: ["Follow ID"])
    }
}
