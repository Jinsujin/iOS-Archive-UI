import ComposableArchitecture
import SwiftUI


struct ThemeForm: ReducerProtocol {
    struct State: Equatable {
        var themes: IdentifiedArrayOf<Theme.State> = []
        var selectedTheme: ThemeType?
        /// isValidate 가 true 일때 다음 화면 입력으로 넘어갈 수 있다!
        var isValidate: Bool {
            return selectedTheme != nil
        }
    }

    enum Action: Equatable {
        case onAppear
        case theme(id: Theme.State.ID, action: Theme.Action)
    }
    
    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                let themeStates = ThemeType.allCases.map { Theme.State(type: $0) }
                state.themes.append(contentsOf: themeStates)
                return .none
                
            case .theme(id: let id, action: .toggled):
                // 하위에 발생한 이벤트를 받아서 상위인 여기서 이벤트를 받을 수 있음(하위에서 부터 상위로 순서대로 이벤트가 전파)
                // => 하위에 변경이 발생하면, 상위인 여기서 그 변경사항을 적용해야 한다면 여기서 처리
                if let selectedTheme = state.selectedTheme,
                   selectedTheme != state.themes[id:id]?.type {
                    state.selectedTheme = state.themes[id:id]?.type
                    return .send(.theme(id: selectedTheme.rawValue, action: .cancel))
                }
                state.selectedTheme = state.themes[id:id]?.type
                return .none
                
            case .theme(id: _, action: .cancel):
                return .none
            }
        }
        .forEach(\.themes, action: /Action.theme(id:action:)) {
            Theme()
        }
    }
}

struct ThemeFormView: View {

    let store: StoreOf<ThemeForm>
    
    init(store: StoreOf<ThemeForm>) {
        self.store = store
    }
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                List {
                    ForEachStore(self.store.scope(
                        state: \.themes,
                        action: ThemeForm.Action.theme(id:action:))
                    ) {
                        ThemeCellView(store: $0)
                    }
                }
                .listStyle(.plain)
                .padding(EdgeInsets(top: -10, leading: -20, bottom: -10, trailing: -20))
                Spacer()
                Text(viewStore.isValidate ? "OK" : "Please Check!")
            }
            .padding()
            .onAppear{ viewStore.send(.onAppear) }
        }
    }
}

struct ThemeFormView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeFormView(store: Store(
            initialState: ThemeForm.State(),
            reducer: ThemeForm())
        )
    }
}
