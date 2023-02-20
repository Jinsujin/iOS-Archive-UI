import SwiftUI

struct ThemeCellView: View {
    @Binding var theme: Theme
    
    var body: some View {
        HStack {
            Text(theme.type.title)
                .foregroundColor(.gray)
            Spacer()
            Image(systemName:
                    theme.isCheck ? "checkmark.circle.fill" : "checkmark.circle")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(red: 0.94,green: 0.94,blue: 0.94))
        .cornerRadius(10)
        .listRowSeparator(.hidden)
        .onTapGesture {
            theme.isCheck.toggle()
        }
    }
}
