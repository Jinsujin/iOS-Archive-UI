import SwiftUI

struct SettingDetailView: View {
    @Binding var userSetting: UserSetting
    
    var body: some View {
        Text(userSetting.nickName)
    }
}

struct SettingDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SettingDetailView(
            userSetting: .constant(.mock)
        )
    }
}
