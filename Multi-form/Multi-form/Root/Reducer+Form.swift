import ComposableArchitecture
import Foundation

/// isVerify 가 true 인 경우, '다음' 버튼 활성화
/// 1 페이지: 하나 체크한 경우
/// 2 페이지: 텍스트필드 2개에 값이 모두 있는 경우
struct Form: ReducerProtocol {
    struct State: Equatable {
        var themeForm = ThemeForm.State()
        var titleForm = TitleForm.State()
        var currentPageIndex = 0
        let maxPageIndex = 1
    }
    
    enum Action: Equatable {
        case onAppear
        case themeForm(ThemeForm.Action)
        case titleForm(TitleForm.Action)
        case changePageIndex(Int)
        case nextPage
    }
    
    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                state = .init()
                return .none
                
            case let .changePageIndex(index):
                state.currentPageIndex = index
                return .none
                
            case .nextPage:
                state.currentPageIndex = min(state.currentPageIndex+1, state.maxPageIndex)
                return .none
                
            default:
                return .none
            }
        }
        Scope(state: \.themeForm, action: /Action.themeForm) {
            ThemeForm()
        }
        Scope(state: \.titleForm, action: /Action.titleForm) {
            TitleForm()
        }
    }
}
