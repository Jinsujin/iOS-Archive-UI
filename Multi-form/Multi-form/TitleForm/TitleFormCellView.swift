import ComposableArchitecture
import SwiftUI

// 1. 초기값: gray line, x button 비활성화
// 2. 값 입력: x button 활성화 => titleText.count 가 0 인지 판단
//  2-1. 유효한값 입력: blue line
//  2-2. 유효하지 않은값 입력: red line, "10글자 초과 text 보이기"
struct TitleCell: ReducerProtocol {
    struct State: Equatable, Identifiable {
        let type: TitleFormView.CellType
        var id: String { type.rawValue }
        var text: String = ""
        var isExceedingChar: Bool {
            return text.count > 10
        }
    }
    
    enum Action: Equatable {
        case textChanged(String)
    }
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case let .textChanged(text):
            state.text = text
            return .none
        }
    }
}


struct TitleFormCellView: View {
    
    let store: StoreOf<TitleCell>
    @ObservedObject var viewStore: ViewStore<ViewState, TitleCell.Action>
    
    init(store: StoreOf<TitleCell>) {
        self.store = store
        self.viewStore = ViewStore(self.store.scope(state: ViewState.init(state:)))
    }
    
    struct ViewState: Equatable {
        let title: String
        let text: String
        let placeholder: String
        let viewType: ViewStateType
        
        init(state: TitleCell.State) {
            self.title = state.type.text
            self.text = state.text
            self.placeholder = state.type.placeholder
            
            if state.isExceedingChar {
                viewType = .notValid
            } else if (!state.isExceedingChar && state.text == "") {
                viewType = .none
            } else {
                viewType = .valid
            }
        }
    }
    
    var body: some View {
        VStack {
            Text(viewStore.title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TextField(viewStore.placeholder,
                      text: viewStore.binding(
                        get: \.text,
                        send: TitleCell.Action.textChanged))
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(
                            viewStore.viewType.strokeColor
                            , lineWidth: 1)
                )
            // TODO: - 텍스트위에 버튼 올리기
            
            HStack {
                Text(viewStore.viewType.warningText)
                    .foregroundColor(.red)
                Text("\(viewStore.text.count)/10")
                    .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .listRowSeparator(.hidden)
    }
}

// MARK: - ViewStateType
extension TitleFormCellView {
    
    enum ViewStateType {
        case none
        case valid
        case notValid

        var strokeColor: Color {
            switch self {
            case .none:
                return Color(red: 0.94, green: 0.94, blue: 0.94)
            case .valid:
                return Color.blue
            case .notValid:
                return Color.red
            }
        }

        var warningText: String {
            switch self {
            case .notValid:
                return "10글자를 초과했습니다."
            default:
                return ""
            }
        }
    }
}
