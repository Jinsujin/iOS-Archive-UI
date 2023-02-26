import ComposableArchitecture
import SwiftUI

// MARK: - Theme Reducer
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


// MARK: - ThemeCellView
struct ThemeCellView: View {
    let store: StoreOf<Theme>
    
    @ObservedObject var viewStore: ViewStore<ViewState, Theme.Action>
    
    init(store: StoreOf<Theme>) {
        self.store = store
        self.viewStore = ViewStore(self.store.scope(state: ViewState.init(state:)))
    }
    
    struct ViewState: Equatable {
        let title: String
        let accentColor: Color
        let systemIconName: String
        
        init(state: Theme.State) {
            self.title = state.type.title
            if !state.isChecked {
                accentColor = .gray
                systemIconName = "checkmark.circle"
                return
            }
            accentColor = .blue
            systemIconName = "checkmark.circle.fill"
        }
    }
    
    var body: some View {
        HStack {
            Text(viewStore.title)
                .foregroundColor(viewStore.accentColor)
            Spacer()
            Image(systemName: viewStore.systemIconName)
                .foregroundColor(viewStore.accentColor)
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(viewStore.accentColor, lineWidth: 1)
        )
        .background(Color(red: 0.94,green: 0.94,blue: 0.94))
        .cornerRadius(8)
        .listRowSeparator(.hidden)
        .onTapGesture {
            viewStore.send(.toggled)
        }
    }
}
