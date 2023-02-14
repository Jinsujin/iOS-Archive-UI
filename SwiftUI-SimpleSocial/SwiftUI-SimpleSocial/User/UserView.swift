import SwiftUI

struct UserView: View {
    var followingList: [UserID]
    
    var body: some View {
        List {
            Section {
                if (followingList.isEmpty) {
                    NoDataView()
                } else {
                    ForEach(followingList, id: \.self) { id in
                        FollowingCell(userID: id)
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
    
    var body: some View {
        HStack {
            Text(userID)
            Spacer()
            Button(action: { print("touched Button") }) {
                Text("팔로우 취소")
            }
            .buttonStyle(BorderlessButtonStyle())
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(followingList: ["userID"])
    }
}
