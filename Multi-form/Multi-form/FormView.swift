import SwiftUI

struct FormView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var currentPageIndex = 0
    
    /// isVerify 가 true 인 경우, '다음' 버튼 활성화
    /// 1 페이지: 하나 체크한 경우
    /// 2 페이지: 텍스트필드 2개에 값이 모두 있는 경우
    @State var isVerify = true
    
    private let titleList = [
        "약속 테마를 선택해 주세요!",
        "약속명과 장소를 입력해 주세요!"
    ]
    
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
                TitleFormView()
                ThemeFormView()
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
        FormView()
    }
}
