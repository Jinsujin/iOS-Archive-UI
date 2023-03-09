import ComposableArchitecture
import SwiftUI


public struct RootFeature: ReducerProtocol {
    public init() {}
    
    public struct State: Equatable {
        var activeMenu: Menu = .menu1
        var secondTab = SecondTabFeature.State()
        
        public init() {}
    }
    
    public enum Action: Equatable {
        case activeMenuChanged(Menu)
        case secondTab(SecondTabFeature.Action)
    }
    
    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case let .activeMenuChanged(menu):
                state.activeMenu = menu
                return .none
                
            // delegate 적용 전
//            case .secondTab(.goSettingButtonTapped):
//                state.activeMenu = .settings
//                return .none
                
            // delegate 적용 후
            case let .secondTab(.delegate(action)):
                switch action {
                case .switchSettingTab:
                    state.activeMenu = .settings
                    return .none
                }
                
            default:
                return .none
            }
        }
        Scope(state: \.secondTab, action: /Action.secondTab) {
            SecondTabFeature()
        }
    }
}


public struct ComposableExampleContentView: View {
    
    let store: StoreOf<RootFeature>
    
    public init(store: StoreOf<RootFeature>) {
        self.store = store
    }
    
    public var body: some View {
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
                            
                            SecondTabView(store: self.store.scope(
                                state: \.secondTab,
                                action: RootFeature.Action.secondTab)
                            )
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
        ComposableExampleContentView(store:
                .init(initialState: RootFeature.State(),
                      reducer: RootFeature()._printChanges()
                     )
        )
    }
}
