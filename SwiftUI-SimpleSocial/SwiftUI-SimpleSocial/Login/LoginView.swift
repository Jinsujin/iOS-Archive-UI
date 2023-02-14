import SwiftUI

struct LoginView: View {
    
    private let socialGraph = [
        "A": ["B", "C"],
        "B": [],
        "C": ["B"]
    ]

    var body: some View {
        NavigationView {
            let userIDs: [String] = socialGraph .map { $0.key }
            List(userIDs, id: \.self) { key in
                LoginCell(userID: key)
            }
            .navigationTitle("로그인 유저 선택")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct LoginCell: View {
    var userID: String
    
    var body: some View {
        NavigationLink(destination: HomeView(userID: userID)) {
            HStack {
                Image(systemName: "person")
                Text(userID)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

