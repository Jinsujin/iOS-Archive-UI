import Foundation

// MARK: - Store ObservableObject
class Store: ObservableObject {
    @Published var graph: Dictionary<UserID, User> = [:]
    
    init() {
        self.graph = DummyGenerator().make()
    }
}
