import ComposableArchitecture
import SwiftUI

struct ThemeFormView: View {
    
    // 상위뷰로 부터 전달받은 객체
    let store: StoreOf<Form>
    
    // 현재 뷰에서 사용할 객체
    // 현재뷰의 상태, 상위뷰 Action을 사용해 viewStore 객체 생성
//    @ObservedObject var viewStore: ViewStore<ViewState, Form.Action>
    
    init(store: StoreOf<Form>) {
      self.store = store
//      self.viewStore = ViewStore(self.store.scope(state: ViewState.init(state:)))
    }
    
    // 상위뷰의 상태값을 사용해 현재뷰의 상태값으로 만든다?
//    struct ViewState: Equatable {
//        var themes: IdentifiedArrayOf<Theme.State> = [
//            .init(type: .meal),
//            .init(type: .travel),
//            .init(type: .meeting),
//            .init(type: .etc)
//        ]
//
//        init(state: Form.State) {
//            // 전체 themes 배열을 초기화 하는데, 부모로 부터 받아온 state 값이 있다면
//            // 해당 객체를 true 로 설정
//            for i in 0..<self.themes.count {
//                if themes[i].type == state.theme {
//                    themes[i].isChecked = true
//                }
//            }
//        }
//    }
    
    var body: some View {
        VStack {
            List {
                ForEachStore(self.store.scope(state: \.themes, action: Form.Action.theme(id:action:))) {
                    ThemeCellView(store: $0)
                }
            }
            .listStyle(.plain)
            .padding(EdgeInsets(top: -10, leading: -20, bottom: -10, trailing: -20))
            Spacer()
            
            // 값 안바뀜
//            Text("Check Count = \(viewStore.state.themes.filter { $0.isChecked }.count)")
        }
        .padding()
    }
}

//struct ThemeFormView_Previews: PreviewProvider {
//    static var previews: some View {
//        ThemeFormView(theme: .constant(nil))
//    }
//}
