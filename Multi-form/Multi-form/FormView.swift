import ComposableArchitecture
import SwiftUI

struct Form: ReducerProtocol {
    struct State: Equatable {
        var themeForm = ThemeForm.State()
        var titleForm = TitleForm.State()
    }
    
    enum Action: Equatable {
        case onAppear
        case themeForm(ThemeForm.Action)
        case titleForm(TitleForm.Action)
    }
    
    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                state = .init()
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
    
    init(store: StoreOf<Form>) {
      self.store = store
    }
    
    var body: some View {
        WithViewStore(store) { viewStore in
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
                    TitleFormView(
                        store: self.store.scope(
                            state: \.titleForm,
                            action: Form.Action.titleForm
                        )
                    )
                    
//                    ThemeFormView(
//                        store: self.store.scope(
//                            state: \.themeForm,
//                            action: Form.Action.themeForm
//                        )
//                    )
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
                .background(viewStore.titleForm.isValidate ? .pink: .gray)
//                .background(viewStore.themeForm.isValidate ? .pink: .gray)
                .cornerRadius(10)
                
            }
            .padding()
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
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
