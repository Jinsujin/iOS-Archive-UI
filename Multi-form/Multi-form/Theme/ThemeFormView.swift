import SwiftUI


struct ThemeFormView: View {
    
    @State private var themes = [
        Theme(type: .meal, isCheck: false),
        Theme(type: .meeting, isCheck: false),
        Theme(type: .travel, isCheck: false),
        Theme(type: .etc, isCheck: false)
    ]
    
    var body: some View {
        VStack {
            List($themes) { $theme in
                ThemeCellView(theme: $theme)
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
        ThemeFormView()
    }
}
