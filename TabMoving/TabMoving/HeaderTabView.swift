import SwiftUI

struct HeaderTabView: View {
    
    let menus: [Menu]
    
    @Binding var activeIndex: Int
    @State private var barX: CGFloat = 0
    
    /// 각 버튼의 leading X position : 바 애니메이션에 필요
    private let spacing: CGFloat
    private let buttonLeadings: [CGFloat]
    private let barWidth: CGFloat
    private let buttonWidth: CGFloat
    private let fullWidth: CGFloat
    
    // 초기화할때 각 버튼의 leading 값을 배열에 넣어두기
    // -> widths[activeIndex] 로 접근 가능
    init(
        activeIndex: Binding<Int>,
        menus: [Menu],
        fullWidth: CGFloat,
        spacing: CGFloat,
        horizontalInset: CGFloat
    ) {
        self.menus = menus
        self._activeIndex = activeIndex
        
        // |옆간격|버튼| 패딩 |버튼|옆간격|
        // 전체크기 = (버튼*2) + 패딩 + 양옆 간격
        self.fullWidth = fullWidth - horizontalInset
        self.spacing = spacing
        self.buttonWidth = (self.fullWidth-spacing)/CGFloat(menus.count)
        self.barWidth = buttonWidth
        self.buttonLeadings = [0, barWidth+spacing]
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: spacing) {
                ForEach(0..<menus.count, id: \.self) { row in
                    Button {
                        activeIndex = row
                        withAnimation {
                            barX = buttonLeadings[row]
                        }
                    } label: {
                        Text(menus[row].title)
                            .frame(maxWidth: buttonWidth)
                        //                            .border(.orange, width: 1)
                            .foregroundColor(.black)
                            .bold()
                    }
                }
            }
            .frame(width: fullWidth, height: 40)
            
            Rectangle()
                .frame(width: barWidth, height: 2)
                .alignmentGuide(.leading) { $0[.leading] }
                .offset(.init(width: barX, height: 0))
        }
        // 이 view 에서 특정한값(activeIndex) 이 변경되었을때, 이벤트 발생!
        // 1. 컨텐츠를 스크롤 제스쳐로 이동했을때
        // 2. 탭 아이템을 터치했을때
        .onChange(of: activeIndex) { selectedRow in
            withAnimation {
                barX = buttonLeadings[selectedRow]
            }
        }
        .background(.yellow)
    }
}

struct HeaderTabView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderTabView(
            activeIndex: .constant(0),
            menus: [.menu1, .menu2],
            fullWidth: UIScreen.main.bounds.width,
            spacing: 40,
            horizontalInset: 10)
    }
}
