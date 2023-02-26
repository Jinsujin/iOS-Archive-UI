import ComposableArchitecture
import Foundation

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
