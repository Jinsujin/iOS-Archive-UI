import SwiftUI

// TODO: - titleText 가 10자가 넘으면, 해당 텍스트필드에 더 이상 입력할 수 없다 => 버튼은 상위뷰에 있으므로, 위에까지 이벤트를 전달해줘야함
// 약속명.valid && 장소명.valid 일때만 상위뷰에 이벤트 전파!
struct TitleFormView: View {
    private let maxInputTextCount = 10
    @State private var titleInput = Input(info: .title)
    @State private var placeInput = Input(info: .place)
    
    var body: some View {
        VStack {
            List {
                TitleFormCellView(input: .init(get: {
                    return titleInput
                }, set: { input in
                    if input.text.count <= 0 {
                        titleInput.viewState = .none
                    } else if (input.text.count > 0) && (input.text.count <= maxInputTextCount) {
                        titleInput.viewState = .valid
                        titleInput.text = input.text
                    } else {
                        titleInput.viewState = .notValid
                    }
                }))
                
                TitleFormCellView(input: .init(get: {
                    placeInput
                }, set: { input in
                    if input.text.count <= 0 {
                        placeInput.viewState = .none
                    } else if (input.text.count > 0) && (input.text.count <= maxInputTextCount) {
                        placeInput.viewState = .valid
                        placeInput.text = input.text
                    } else {
                        placeInput.viewState = .notValid
                    }
                }))
            }
            .listStyle(.plain)
            .padding(EdgeInsets(top: -10, leading: -20, bottom: -10, trailing: -20))
            Spacer()
            Text("Input = \(titleInput.text), \(placeInput.text)")
        }
        .padding()
    }
}

struct TitleFormView_Previews: PreviewProvider {
    static var previews: some View {
        TitleFormView()
    }
}

// MARK: - CellInfo
extension TitleFormView {
    enum CellInfo {
        case title
        case place
        
        var text: String {
            switch self {
            case .title:
                return "약속명(선택)"
            case .place:
                return "장소(선택)"
            }
        }
        
        var placeholder: String {
            switch self {
            case .title:
                return "YUMMY"
            case .place:
                return "강남, 온라인 등"
            }
        }
    }
    
    struct Input {
        let info: CellInfo
        var text = ""
        var viewState: FormViewState = .none
    }

}
