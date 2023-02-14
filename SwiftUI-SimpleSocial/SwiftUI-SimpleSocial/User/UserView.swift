import SwiftUI

struct UserView: View {
    var followingList: [UserID]
    
    var body: some View {
        List {
            Section {
                ForEach(followingList, id: \.self) { user in
                    Text(user)
                }
            } header: {
                Text("Follow List")
            }
        }
    }
}

struct FollowingCell: View {
    var userID: UserID
    
    var body: some View {
        Text(userID)
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(followingList: ["userID"])
    }
}
