import ComposableArchitecture
import Foundation

struct Theme: ReducerProtocol {
    struct State: Equatable, Identifiable {
        let type: ThemeType
        var id : String { type.rawValue }
        var isChecked = false
    }
    
    enum Action: Equatable {
        case toggled
        case cancel
    }
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .toggled:
            state.isChecked.toggle()
            return .none
        case .cancel:
            state.isChecked = false
            return .none
        }
    }
}

