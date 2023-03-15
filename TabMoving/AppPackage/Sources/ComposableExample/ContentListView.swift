import ComposableArchitecture
import SwiftUI

// MARK: - Counter
struct Counter: ReducerProtocol {
    struct State: Equatable {
        var count: Int
    }
    
    enum Action: Equatable {
        case dismiss
    }
    
    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .dismiss:
                return .none
            }
        }
    }
}

struct CounterView: View {
    let store: StoreOf<Counter>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                Text("Count")
                Text("\(viewStore.count)")
            }
        }
    }
}


// MARK: - ListFeature
struct ListFeature: ReducerProtocol {
    struct State: Equatable {
        var optionalCounter: Counter.State?
    }
    
    enum Action: Equatable {
        case optionalCounter(Counter.Action)
        case onAppear
        case showCounter
    }

    
    
    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .showCounter:
                state.optionalCounter = .init(count: 1)
                return .none
                
            case .onAppear:
                state.optionalCounter = .init(count: 10)
                return .none
                
            case .optionalCounter:
                return .none
            }
        }
        .ifLet(\.optionalCounter, action: /Action.optionalCounter) {
            Counter()
        }
    }
}

struct ContentListView: View {
    struct CellModel: Identifiable {
        var id = UUID()
        let title: String
        let names: [String]
    }
    
    private var models: [CellModel] = [.init(title: "타이틀1", names: ["A", "B", "C"])]
    
    private let store: StoreOf<ListFeature>
    
    init() {
        self.store = .init(
            initialState: ListFeature.State(),
            reducer: ListFeature()._printChanges())
    }
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationStack {
                VStack {
                    IfLetStore(
                        self.store.scope(
                            state: \.optionalCounter,
                            action: ListFeature.Action.optionalCounter
                        )
                    ) {
                        CounterView(store: $0)
                    }
                    
                    List(models) { item in
                        VStack {
                            Text(item.title)
                                .bold()
                            
                            Text(item.names.joined(separator: ", "))
                        }
                    }
                }
                .toolbar {
                    ToolbarItem {
                        Button {
                            viewStore.send(.showCounter)
                        } label: {
                            Text("카운트 시작")
                        }
                    }
                }
            }
        }
    }
}

struct ContentListView_Previews: PreviewProvider {
    static var previews: some View {
        ContentListView()
    }
}
