import ComposableArchitecture
import SwiftUI

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
