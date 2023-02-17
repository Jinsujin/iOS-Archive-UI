import SwiftUI

// 1. 초기값: gray line, x button 비활성화
// 2. 값 입력: x button 활성화 => titleText.count 가 0 인지 판단
//  2-1. 유효한값 입력: blue line
//  2-2. 유효하지 않은값 입력: red line, "10글자 초과 text 보이기"

struct TitleFormCellView: View {
    let viewType: TitleFormView.CellType
    @Binding var viewState: TitleFormView.ViewState
    @Binding var value: String
    
    var body: some View {
        VStack {
            Text(viewType.text)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
//            TextField(viewInfo.cellType.placeholder, text: $value)
            TextField(viewType.placeholder, text: $value)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(
                            viewState.strokeColor
                            , lineWidth: 1)
                )
            // TODO: - 텍스트위에 버튼 올리기
            
            HStack {
                Text(viewState.warningText)
                    .foregroundColor(.red)
                Text("\(value.count)/10")
                    .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .listRowSeparator(.hidden)
    }
}
