import SwiftUI
import SwiftUINavigation

struct UserSetting {
    var nickName: String
    var theme: Theme
    
    static var mock: UserSetting {
        return .init(nickName: "Ace", theme: .light)
    }
}

enum Theme: String {
    case dark
    case light
}

struct LoginUser: Identifiable {
    let id: UUID
    private(set) var followingList = [UserID]()
    private(set) var followerCount: Int = 0
}

final class SettingsModel: ObservableObject {
    @Published var loginUser: LoginUser
    @Published var userSetting: UserSetting
    @Published var destination: Destination?
    
    init(loginUser: LoginUser, destination: Destination? = nil) {
        self.loginUser = loginUser
        self.userSetting = .mock
    }
    
    enum Destination {
        case detail(UserSetting)
    }
    
    func touchedDetailButton() {
        self.destination = .detail(userSetting)
    }
    
    func dismissDetailButtonTouched() {
        self.destination = nil
    }
    
    func confirmButtonTouched() {
        defer { self.destination = nil }
        
        guard case var .detail(userSetting) = self.destination else {
            return
        }
        userSetting.theme = .dark
        self.userSetting = userSetting
    }
}


struct SettingsView: View {
    @ObservedObject var model: SettingsModel
    
    var body: some View {
        NavigationStack {
            List {
                Section("Theme") {
                    Text(self.model.userSetting.theme.rawValue)
                }
                ForEach(0..<self.model.loginUser.followingList.count) { index in
                    let userID = model.loginUser.followingList[index]
                    Text(userID)
                }
            }
            .toolbar {
                Button {
                    self.model.touchedDetailButton()
                } label: {
                    Text("수정")
                }
            }
            .navigationTitle("Settings")
            .sheet(
                unwrapping: $model.destination,
                case: CasePath(SettingsModel.Destination.detail)) { $userSetting in
                    NavigationStack {
                        SettingDetailView(userSetting: $userSetting)
                        .navigationTitle("Detail")
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("닫기") {
                                    model.dismissDetailButtonTouched()
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("테마 변경") {
                                    model.confirmButtonTouched()
                                }
                            }
                        }
                    }
                }
        }
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(model:
                        SettingsModel(
                            loginUser: .init(
                                id: UUID(),
                                followingList: ["B", "C"],
                                followerCount: 0)
                        )
        )
    }
}
