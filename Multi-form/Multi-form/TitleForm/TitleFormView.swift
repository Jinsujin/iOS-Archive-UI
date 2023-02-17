import SwiftUI

// TODO: - titleText 가 10자가 넘으면, 해당 텍스트필드에 더 이상 입력할 수 없다 => 버튼은 상위뷰에 있으므로, 위에까지 이벤트를 전달해줘야함
// 약속명.valid && 장소명.valid 일때만 상위뷰에 이벤트 전파!
struct TitleFormView: View {
    private let maxInputTextCount = 10
    
    // 상위에서 전달받는 상태값
    @Binding var title: String
    @Binding var place: String

    // 화면을 그릴때 필요한 값
    @State private var titleViewState = ViewState.none
    @State private var placeViewState = ViewState.none
    
    var body: some View {
        VStack {
            let list = [
                (type: CellType.title, viewState: $titleViewState, value: title),
                (type: CellType.place, viewState: $placeViewState, value: place)
            ]
            
            List(list, id: \.type) {
                (type, viewState, value) in
                
                TitleFormCellView(viewType: type, viewState: viewState, value: .init(get: {
                    value
                }, set: { input in
                    var updateViewState: TitleFormView.ViewState = .none
                    let inputTextCount = input.count
                    
                    if inputTextCount <= 0 {
                        updateViewState = .none
                    } else if (inputTextCount > 0) && (inputTextCount <= maxInputTextCount) {
                        updateViewState = .valid
                    } else {
                        updateViewState = .notValid
                    }
                    switch type {
                    case .title:
                        title = input
                        titleViewState = updateViewState
                    case .place:
                        place = input
                        placeViewState = updateViewState
                    }
                }))
            }
            .listStyle(.plain)
            .padding(EdgeInsets(top: -10, leading: -20, bottom: -10, trailing: -20))
            Spacer()
            Text("Input = \(title), \(place)")
        }
        .padding()
    }
}

struct TitleFormView_Previews: PreviewProvider {
    static var previews: some View {
        TitleFormView(title: .constant("약속명"), place: .constant("장소"))
    }
}
