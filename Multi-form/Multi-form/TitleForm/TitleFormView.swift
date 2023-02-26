import ComposableArchitecture
import SwiftUI


struct TitleForm: ReducerProtocol {
    struct State: Equatable {
        var titles: IdentifiedArrayOf<TitleCell.State> = []
        var title: String = ""
        var place: String = ""
        var isValidate: Bool {
            return (title.count <= 10 && place.count <= 10)
        }
    }

    // 하위뷰에서 일어나는 이벤트를 받아 처리
    enum Action: Equatable {
        case onAppear
        case textChange(id: TitleCell.State.ID, action: TitleCell.Action)
    }
    
    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                let titleStates = TitleFormView.CellType.allCases.map { TitleCell.State(type: $0) }
                state.titles.append(contentsOf: titleStates)
                return .none
                
            case .textChange(id: let id, action: .textChanged(let text)):
                let selected = state.titles[id:id]
                if selected?.type == .title {
                    state.title = text
                }
                if selected?.type == .place {
                    state.place = text
                }
                return .none
            }
        }.forEach(\.titles, action: /Action.textChange(id:action:)) {
            TitleCell()
        }
    }
}


// TODO: - titleText 가 10자가 넘으면, 해당 텍스트필드에 더 이상 입력할 수 없다 => 버튼은 상위뷰에 있으므로, 위에까지 이벤트를 전달해줘야함
// 약속명.valid && 장소명.valid 일때만 상위뷰에 이벤트 전파!
struct TitleFormView: View {
    private let maxInputTextCount = 10
    let store: StoreOf<TitleForm>
    
    init(store: StoreOf<TitleForm>) {
        self.store = store
    }
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                List {
                    ForEachStore(self.store.scope(
                        state: \.titles,
                        action: TitleForm.Action.textChange(id: action:))) {
                        TitleFormCellView(store: $0)
                    }
                }
                .listStyle(.plain)
                .padding(EdgeInsets(top: -10, leading: -20, bottom: -10, trailing: -20))
                Spacer()
                Text("Input = \(viewStore.title), \(viewStore.place)")
            }
            .padding()
            .onAppear{ viewStore.send(.onAppear) }
        }
    }
}
    

struct TitleFormView_Previews: PreviewProvider {
    static var previews: some View {
        TitleFormView(store:
                        Store(
                            initialState: TitleForm.State(),
                            reducer: TitleForm()
                        )
        )
    }
}
