import SwiftUI

// 1. 초기값: gray line, x button 비활성화
// 2. 값 입력: x button 활성화 => titleText.count 가 0 인지 판단
//  2-1. 유효한값 입력: blue line
//  2-2. 유효하지 않은값 입력: red line, "10글자 초과 text 보이기"
struct TitleFormCellView: View {
    @Binding var input: TitleFormView.Input
    let onChange: (String) -> Void
    
    var body: some View {
        VStack {
            Text(input.info.text)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            ZStack {
                TextField(input.info.placeholder, text: $input.text)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(
                                input.viewState.strokeColor
                                , lineWidth: 1)
                    )
                    .onChange(of: input.text) {
                        onChange($0)
                    }
                // TODO: - 텍스트위에 버튼 올리기
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
                Text(input.viewState.warningText)
                    .foregroundColor(.red)
                Text("\(input.text.count)/10")
                    .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .listRowSeparator(.hidden)
    }
}
