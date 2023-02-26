import ComposableArchitecture
import Foundation

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

