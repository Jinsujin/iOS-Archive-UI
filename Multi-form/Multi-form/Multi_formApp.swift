import ComposableArchitecture
import SwiftUI

@main
struct Multi_formApp: App {
    var body: some Scene {
        WindowGroup {
            FormView(
                store: Store(
                    initialState: Form.State(),
                    reducer: Form()._printChanges()
                )
            )
        }
    }
}
