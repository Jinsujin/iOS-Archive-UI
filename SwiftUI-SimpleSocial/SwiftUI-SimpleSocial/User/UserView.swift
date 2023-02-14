import SwiftUI

struct UserView: View {
    var followingList: [UserID]
    
    var body: some View {
        List(followingList, id: \.self) { id in
            FollowingCell(userID: id)
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
