import ComposableArchitecture
import SwiftUI

struct Theme: ReducerProtocol {
    struct State: Equatable, Identifiable {
        let type: ThemeType
        var id : String { type.rawValue }
        var isChecked = false
    }
    
    enum Action: Equatable {
        case toggled
    }
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .toggled:
            state.isChecked.toggle()
            return .none
        }
    }
}

struct ThemeCellView: View {
    let store: StoreOf<Theme>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            HStack {
                Text(viewStore.type.title)
                    .foregroundColor(.gray)
                Spacer()
                Image(systemName:
                        viewStore.isChecked ? "checkmark.circle.fill" : "checkmark.circle")
                .foregroundColor(.gray)
            }
            .padding()
            .background(Color(red: 0.94,green: 0.94,blue: 0.94))
            .cornerRadius(10)
            .listRowSeparator(.hidden)
            .onTapGesture {
                viewStore.send(.toggled)
            }
        }
    }
}
