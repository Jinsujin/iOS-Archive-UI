import SwiftUI

struct LoginView: View {
    let processor: ActionProcessor
    
    var body: some View {
        
        NavigationView {
            let userIDs = processor.store.graph.map{ $0.key }
            List(userIDs, id: \.self) { key in
                LoginCellView(userID: key, processor: processor)
            }
            .navigationTitle("로그인 유저 선택")
            .navigationBarTitleDisplayMode(.inline)
        }.onAppear {
            // TODO: - Test
            let result = processor.play(action: .isMutualFollowing("A", "C"))
            print("LoginView isMutualFollowing = ", result.value)
        }
    }
}

struct LoginCellView: View {
    var userID: UserID
    let processor: ActionProcessor
    
    var body: some View {
        let homeView = HomeView(userID: userID, processor: processor)
        
        NavigationLink(destination: homeView) {
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
            processor: ActionProcessor(
                system: SocialSystem(
                    with: Store()
                )
            )
        )
    }
}

