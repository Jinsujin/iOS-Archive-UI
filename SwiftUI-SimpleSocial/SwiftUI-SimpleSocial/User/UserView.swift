import SwiftUI

struct UserView: View {
    var followingList: [UserID]
    var unFollowAction: (UserID) -> Void
    
    var body: some View {
        List {
            Section {
                if (followingList.isEmpty) {
                    NoDataView()
                } else {
                    ForEach(followingList, id: \.self) { id in
                        FollowingCell(userID: id) {
                            unFollowAction(id)
                        }
                    }
                }
            } header: {
                Text("Follow List")
            }
        }
    }
}

struct FollowingCell: View {
    var userID: UserID
    let cancelAction: () -> Void
    
    var body: some View {
        HStack {
            Text(userID)
            Spacer()
            Button(action: { cancelAction() }) {
                Text("팔로우 취소")
            }
            .buttonStyle(BorderlessButtonStyle())
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(followingList: ["userID"], unFollowAction: { _ in })
    }
}
