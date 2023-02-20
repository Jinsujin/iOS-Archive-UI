import ComposableArchitecture
import SwiftUI


struct ThemeForm: ReducerProtocol {
    struct State: Equatable {
        var themes: IdentifiedArrayOf<Theme.State> = [
            .init(type: .meal),
            .init(type: .travel),
            .init(type: .meeting),
            .init(type: .etc)
        ]
        var isAlreadyCheck: Bool {
            return themes.filter({ $0.isChecked }).count > 0
        }
    }

    // 하위뷰에서 일어나는 이벤트를 받아 처리
    enum Action: Equatable {
        case theme(id: Theme.State.ID, action: Theme.Action)
    }
    
    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .theme(id: let id, action: .toggled):
                // state.themes 가 업데이트 되고 난 후에 진입
                // NOTE: - toggle 됨
                var theme = state.themes
                    .filter({ $0.id == id })
                    .first
                theme?.isChecked.toggle()
                    
                // NOTE: - toggle 이 안됨 ⚠️
//                for i in 0..<state.themes.count {
//                    if id == state.themes[i].id {
//                        state.themes[i].isChecked.toggle() // 안됨
//                        state.themes[i].isChecked = true // 됨
//                    }
//                }
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
                Text(viewStore.isAlreadyCheck ? "Check" : "not yet")
            }
            .padding()
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
