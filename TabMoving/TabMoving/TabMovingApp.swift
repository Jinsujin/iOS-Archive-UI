import SwiftUI
import ComposableExample

@main
struct TabMovingApp: App {
    var body: some Scene {
        WindowGroup {
            ComposableExampleContentView(store:
                    .init(
                        initialState: RootFeature.State(),
                        reducer: RootFeature()._printChanges()
                    )
            )
        }
    }
}
