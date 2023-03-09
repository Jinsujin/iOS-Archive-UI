import ComposableArchitecture
import SwiftUI


struct RootFeature: ReducerProtocol {
    struct State: Equatable {
        var activeMenu: Menu = .menu1
    }
    
    enum Action {
        case activeMenuChanged(Menu)
    }
    
    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case let .activeMenuChanged(menu):
                state.activeMenu = menu
                return .none
            }
        }
    }
}


struct ContentView: View {
    
    let store: StoreOf<RootFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationView {
                // 하위뷰(HeaderTabView)에 상위뷰(VStack)의 크기를 넣어주기 위해 사용
                GeometryReader { geo in
                    VStack {
                        HeaderTabView(
                            activeMenu: viewStore.binding(
                                get: \.activeMenu,
                                send: RootFeature.Action.activeMenuChanged),
                            menus: Menu.allCases,
                            fullWidth: geo.size.width,
                            spacing: 32,
                            horizontalInset: 40)
                        
                        // Pages
                        TabView(selection:
                                    viewStore.binding(get: \.activeMenu, send: RootFeature.Action.activeMenuChanged)
                        ) {
                            ContentListView()
                                .tag(Menu.menu1)
                            
                            Text(Menu.menu2.title)
                                .tag(Menu.menu2)
                            
                            ContentListView()
                                .tag(Menu.menu3)
                            
                            Text(Menu.settings.title)
                                .tag(Menu.settings)
                        }
                        // selectedIndex 가 바뀌었을때 컨텐츠 슬라이드
                        .animation(.default, value: viewStore.activeMenu)
                        .background(.gray)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 200)
                        .tabViewStyle(.page(indexDisplayMode: .never))
                    }
                    .background(.orange)
                    .navigationTitle("Tab Menu")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                print("Add Item")
                            } label: {
                                Image(systemName: "plus")
                                    .foregroundColor(.black)
                            }
                        }
                    }
                }
            }
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(store:
                .init(initialState: RootFeature.State(),
                      reducer: RootFeature()._printChanges()
                     )
        )
    }
}
