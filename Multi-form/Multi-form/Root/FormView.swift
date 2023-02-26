import ComposableArchitecture
import SwiftUI

struct FormView: View {
    let store: StoreOf<Form>
    
    @ObservedObject var viewStore: ViewStore<ViewState, Form.Action>
    @Environment(\.dismiss) var dismiss

    init(store: StoreOf<Form>) {
        self.store = store
        self.viewStore = ViewStore(self.store.scope(state: ViewState.init(state:)))
    }
    
    struct ViewState: Equatable {
        let currentPageIndex: Int
        let pageTitle: String
        let pageIndicatorText: String
        var isVerify: Bool = false
        
        init(state: Form.State) {
            self.currentPageIndex = state.currentPageIndex
            if state.currentPageIndex == 0 {
                self.pageTitle = "약속 테마를 선택해 주세요!"
                if state.titleForm.isValidate {
                    self.isVerify = true
                }
            } else {
                self.pageTitle = "약속명과 장소를 입력해 주세요!"
                if state.themeForm.isValidate {
                    self.isVerify = true
                }
            }
            
            pageIndicatorText = "\(state.currentPageIndex+1)/\(state.maxPageIndex+1)"
        }
    }
    
    
    var body: some View {
        VStack {
            HStack {
                Text(viewStore.pageIndicatorText)
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "x.circle")
                }
            }
            .padding(.bottom)
            Text(viewStore.pageTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom)
            // MARK: - 하위뷰
            TabView(selection:
                        viewStore.binding(
                            get: \.currentPageIndex,
                            send: Form.Action.changePageIndex)) {
                TitleFormView(
                    store: self.store.scope(
                        state: \.titleForm,
                        action: Form.Action.titleForm
                    )
                ).tag(0)
                
                ThemeFormView(
                    store: self.store.scope(
                        state: \.themeForm,
                        action: Form.Action.themeForm
                    )
                ).tag(1)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            // TODO: - 스크롤 제스쳐 막기(버튼으로만 다음페이지 이동)
            //                .onAppear(perform: {
            //                   UIScrollView.appearance().bounces = false
            //                 })
            
            // ----
            Spacer()
            
            Button {
                viewStore.send(.nextPage)
            } label: {
                Text("다음")
                    .padding()
                    .frame(maxWidth: .infinity)
            }
            .disabled(!viewStore.isVerify)
            .foregroundColor(.white)
            .background(viewStore.isVerify ? .pink: .gray)
            .cornerRadius(10)
        }
        .padding()
        .onAppear { viewStore.send(.onAppear) }
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
