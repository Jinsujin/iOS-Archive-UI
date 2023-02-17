import SwiftUI


struct Theme: Identifiable {
    let type: ThemeType
    var id: String { type.title }
    var isCheck: Bool
}

enum ThemeType {
    case meal
    case meeting
    case travel
    case etc
    
    var title: String {
        switch self {
        case .meal:
            return "식사 약속"
        case .meeting:
            return "미팅 약속"
        case .travel:
            return "여행 약속"
        case .etc:
            return "기타 약속"
        }
    }
}

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



struct FormView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var themes = [
        Theme(type: .meal, isCheck: false),
        Theme(type: .meeting, isCheck: false),
        Theme(type: .travel, isCheck: false),
        Theme(type: .etc, isCheck: false)
    ]
    
    var body: some View {
        HStack {
            VStack {
                HStack {
                    Text("1/5")
                    Spacer()
                    Button {
                        dismiss()
                     } label: {
                         Image(systemName: "x.circle")
                     }
                }
                .padding(.bottom)
                Text("약속 테마를 선택해 주세요!")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom)
                List($themes) { $theme in
                    ThemeCellView(theme: $theme)
                }
                .listStyle(.plain)
                .padding(EdgeInsets(top: -10, leading: -20, bottom: -10, trailing: -20))

                Spacer()
                Text("Check Count = \(themes.filter{ $0.isCheck }.count)")
                Button {
                    print("next button")
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
}


struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormView()
    }
}
