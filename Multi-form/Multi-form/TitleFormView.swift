import SwiftUI

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


// MARK: - TitleCellView
struct TitleCellView: View {
    @Binding var inputText: String
    @Binding var state: ViewState {
        didSet {
            print("didset - ",state)
        }
    }
    let onChange: (String) -> Void
    var title: String = "(선택)"
    var placeholder: String = "입력해 주세요"
    
    // 1. 초기값: gray line, x button 비활성화
    // 2. 값 입력: x button 활성화 => titleText.count 가 0 인지 판단
    //  2-1. 유효한값 입력: blue line
    //  2-2. 유효하지 않은값 입력: red line, "10글자 초과 text 보이기"
    
    var body: some View {
        VStack {
            Text(title)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            ZStack {
                TextField(placeholder, text: $inputText)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(
                                state.strokeColor
                                , lineWidth: 1)
                    )
                    .onChange(of: inputText) {
                        onChange($0)
                    }
//                    .overlay(
//                        Button {
//                            print("글자제거")
//                        } label: {
//                            Image(systemName: "x.circle")
//                        }
//                        .frame(width: 30, height: 30)
//                        , alignment: .bottomTrailing)

            }
            HStack {
                Text(state.warningText)
                    .foregroundColor(.red)
                Text("\(inputText.count)/10")
                    .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .listRowSeparator(.hidden)
    }
}

struct TitleFormView: View {
    enum InputType {
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
        let type: InputType
        var text = ""
        var viewState: ViewState = .none
    }
    
    private let maxInputTextCount = 10
//    private let inputs: [InputType] = [ .title, .place ]
    
//    @State private var titleInput = Input(type: .title)
//    @State private var placeInput = Input(type: .place)
    
    
    @State private var titleText = ""
    @State private var titleViewState: ViewState = .none

    @State private var placeText = ""
    @State private var placeViewState: ViewState = .none
    
    // TODO: - titleText 가 10자가 넘으면, 해당 텍스트필드에 더 이상 입력할 수 없다 => 버튼은 상위뷰에 있으므로, 위에까지 이벤트를 전달해줘야함
    // 약속명.valid && 장소명.valid 일때만 상위뷰에 이벤트 전파!
    
    var body: some View {
        VStack {
            List {
                TitleCellView(inputText: $titleText, state: $titleViewState) { onChangeText in
                    if onChangeText.count <= 0 {
                        titleViewState = .none
                    } else if (onChangeText.count > 0) && (onChangeText.count <= maxInputTextCount) {
                        titleViewState = .valid
                    } else {
                        titleViewState = .notValid
                    }
                }
                
                TitleCellView(inputText: $placeText, state: $placeViewState) { onChangeText in
                    if onChangeText.count <= 0 {
                        placeViewState = .none
                    } else if (onChangeText.count > 0) && (onChangeText.count <= maxInputTextCount) {
                        placeViewState = .valid
                    } else {
                        placeViewState = .notValid
                    }
                }
            }
            .listStyle(.plain)
            .padding(EdgeInsets(top: -10, leading: -20, bottom: -10, trailing: -20))
            Spacer()
            Text("Input = \(titleText), \(placeText)")
        }
        .padding()
    }
}

struct TitleFormView_Previews: PreviewProvider {
    static var previews: some View {
        TitleFormView()
    }
}
