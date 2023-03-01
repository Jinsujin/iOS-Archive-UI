import SwiftUI

final class SettingDetailModel: ObservableObject {
    
    @Published var userSetting: UserSetting
    
    init(userSetting: UserSetting) {
        self.userSetting = userSetting
    }
}

struct SettingDetailView: View {
    @ObservedObject var model: SettingDetailModel
    
    var body: some View {
        Form {
            Section {
                TextField("NickName", text: $model.userSetting.nickName)
            }
            Section {
                ForEach(Theme.allCases) { theme in
                    Text(theme.rawValue)
                }
                .onDelete { indexSet in
                    print(indexSet)
                }
            }
        }
    }
}

struct SettingDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {   
            SettingDetailView(model:
                                SettingDetailModel(userSetting: .mock)
            )
        }
    }
}
