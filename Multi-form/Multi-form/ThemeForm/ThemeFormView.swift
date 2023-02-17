import SwiftUI


struct ThemeFormView: View {
    
    @Binding var theme: ThemeType?
    
    @State private var themes = [
        Theme(type: .meal, isCheck: false),
        Theme(type: .meeting, isCheck: false),
        Theme(type: .travel, isCheck: false),
        Theme(type: .etc, isCheck: false)
    ]
    
    var body: some View {
        VStack {
            List($themes) { $theme in
                ThemeCellView(theme: .init(get: {
                    theme
                }, set: { selected in
                    let totalSelectCount = themes.filter{ $0.isCheck }.count
                    
                    if totalSelectCount == 1 && !selected.isCheck {
                        // 1개 선택된 아이템을 취소하는 경우
                        self.theme = nil
                        theme = selected
                    }
                    
                    if totalSelectCount == 0 && selected.isCheck {
                        // 처음으로 아이템을 선택하는 경우
                        self.theme = selected.type
                        theme = selected
                    }
                }))
            }
            .listStyle(.plain)
            .padding(EdgeInsets(top: -10, leading: -20, bottom: -10, trailing: -20))
            Spacer()
            Text("Check Count = \(themes.filter{ $0.isCheck }.count)")
        }
        .padding()
    }
}

struct ThemeFormView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeFormView(theme: .constant(nil))
    }
}
