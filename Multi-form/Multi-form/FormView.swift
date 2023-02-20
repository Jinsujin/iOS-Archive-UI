import ComposableArchitecture
import SwiftUI

struct Form: ReducerProtocol {
    struct State: Equatable {
        /// 약속테마(필수값)
        /// 초기값:  아무것도 선택하지 않은 상태
        var theme: ThemeType?
        
        /// 약속명: optional
        var title: String = ""
        
        /// 장소: optional
        var place: String = ""
        
        var themes: IdentifiedArrayOf<Theme.State> = [
            .init(type: .meal),
            .init(type: .travel),
            .init(type: .meeting),
            .init(type: .etc)
        ]
    }
    
    enum Action: Equatable {
        case updateTitle(String)
        case updatePlace(String)
        case updateTheme(ThemeType)
        case theme(id: Theme.State.ID, action: Theme.Action)
    }
    
    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .updateTitle(let title):
                state.title = title
                return .none
            case .updateTheme(let theme):
                state.theme = theme
                return .none
            case .theme(id: let id, action: .toggled):
                print("FormReducer:: theme 토글됨, id = ", id)
                state.theme = ThemeType(rawValue: id)
                return .none
            case .updatePlace(let place):
                state.place = place
                return .none
            }
        }
        .forEach(\.themes, action: /Action.theme(id:action:)) {
            Theme()
        }
    }
}

struct FormView: View {
    @Environment(\.dismiss) var dismiss
        
    /// isVerify 가 true 인 경우, '다음' 버튼 활성화
    /// 1 페이지: 하나 체크한 경우
    /// 2 페이지: 텍스트필드 2개에 값이 모두 있는 경우
    @State private var isVerify = true
    @State private var currentPageIndex = 0
    
    private let titleList = [
        "약속 테마를 선택해 주세요!",
        "약속명과 장소를 입력해 주세요!"
    ]
    
    let store: StoreOf<Form>
    
    var body: some View {
        VStack {
            HStack {
                Text("\(currentPageIndex + 1)/5")
                Spacer()
                Button {
                    dismiss()
                 } label: {
                     Image(systemName: "x.circle")
                 }
            }
            .padding(.bottom)
            Text(titleList[currentPageIndex])
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom)
            // MARK: - 하위뷰
            TabView {
//                TitleFormView(title: $model.title, place: $model.place)
                ThemeFormView(store: store)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            // ----
            Spacer()
            
            Button {
                print("next button")
                // TODO: -
                // 다음 버튼을 누르면 현재 페이지인덱스 += 1
                // 이전 버튼을 누르면 현재 페이지인덱스 -= 1
                currentPageIndex = 1
            } label: {
                Text("다음")
                    .padding()
                    .border(.black)
                    .frame(maxWidth: .infinity)
            }
            .foregroundColor(.white)
            .background(.pink)
            .cornerRadius(10)
        }
        .padding()
    }
}


struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormView(store: Store(
            initialState: Form.State(),
            reducer: Form())
        )
    }
}
