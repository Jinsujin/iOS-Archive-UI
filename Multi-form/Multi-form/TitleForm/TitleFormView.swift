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
                TitleFormCellView(input: $titleInput) { onChangeText in
                    if onChangeText.count <= 0 {
                        titleInput.viewState = .none
                    } else if (onChangeText.count > 0) && (onChangeText.count <= maxInputTextCount) {
                        titleInput.viewState = .valid
                    } else {
                        titleInput.viewState = .notValid
                    }
                }
                
                TitleFormCellView(input: $placeInput) { onChangeText in
                    if onChangeText.count <= 0 {
                        placeInput.viewState = .none
                    } else if (onChangeText.count > 0) && (onChangeText.count <= maxInputTextCount) {
                        placeInput.viewState = .valid
                    } else {
                        placeInput.viewState = .notValid
                    }
                }
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

// MARK: - TitleFormView: InputType enum
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
        var viewState: ViewState = .none
    }

}

// MARK: - ViewState enum
enum ViewState {
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
