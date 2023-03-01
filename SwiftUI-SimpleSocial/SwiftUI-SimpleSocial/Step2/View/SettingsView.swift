import SwiftUI
import SwiftUINavigation

struct UserSetting {
    var nickName: String
    var theme: Theme
    
    static var mock: UserSetting {
        return .init(nickName: "Ace", theme: .light)
    }
}

enum Theme: String, CaseIterable, Identifiable {
    case dark
    case light
    
    var id: String {
        self.rawValue
    }
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
        case detail(SettingDetailModel)
    }
    
    func touchedDetailButton() {
        let model = SettingDetailModel(userSetting: userSetting)
        self.destination = .detail(model)
    }
    
    func dismissDetailButtonTouched() {
        self.destination = nil
    }
    
    func confirmButtonTouched() {
        defer { self.destination = nil }
        guard case let .detail(detailModel) = self.destination else {
            return
        }
        
        var userSetting = detailModel.userSetting
        userSetting.theme = (userSetting.theme == .light) ? .dark : .light
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
                case: CasePath(SettingsModel.Destination.detail)) { $model in
                    NavigationStack {
                        SettingDetailView(model: model)
                            .navigationTitle("Detail")
                            .toolbar {
                                ToolbarItem(placement: .cancellationAction) {
                                    Button("닫기") {
                                        self.model.dismissDetailButtonTouched()
                                    }
                                }
                                ToolbarItem(placement: .confirmationAction) {
                                    Button("테마 변경") {
                                        self.model.confirmButtonTouched()
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
