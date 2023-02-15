import SwiftUI

@main
struct SwiftUI_SimpleSocialApp: App {
    
    @StateObject var store = Store()
    
    var body: some Scene {
        WindowGroup {
            LoginView(
                processor: ActionProcessor(
                    system: SocialSystem(with: store)
                )
            )
        }
    }
}
