import SwiftUI

struct ListView: View {
    struct CellModel: Identifiable {
        var id = UUID()
        let title: String
        let names: [String]
    }
    
    private var models: [CellModel] = [.init(title: "타이틀1", names: ["A", "B", "C"])]
    
    var body: some View {
        List(models) { item in
            VStack {
                Text(item.title)
                    .bold()
                
                Text(item.names.joined(separator: ", "))
            }
            .background(.purple)
        }
    }
}

enum Menu: Int, CaseIterable {
    case menu1 = 0
    case menu2 = 1
    
    var title: String {
        switch self {
        case .menu1: return "메뉴1"
        case .menu2: return "메뉴2"
        }
    }
}

struct ContentView: View {
    @State private var selectedIndex = Menu.menu1.rawValue
    private let menus: [Menu] = Menu.allCases
    
    var body: some View {
        
        NavigationView {
            // 하위뷰(HeaderTabView)에 상위뷰(VStack)의 크기를 넣어주기 위해 사용
            GeometryReader { geo in
                VStack {
                    HeaderTabView(
                        activeIndex: $selectedIndex,
                        menus: menus,
                        fullWidth: geo.size.width,
                        spacing: 60,
                        horizontalInset: 40)
                    
                    // Pages
                    TabView(selection: $selectedIndex) {
                        ListView()
                            .tag(0)
                        
                        ListView()
                            .tag(1)
                    }
                    // selectedIndex 가 바뀌었을때 컨텐츠 슬라이드
                    .animation(.default, value: selectedIndex)
                    .background(.gray)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 200)
                    .tabViewStyle(.page(indexDisplayMode: .never))
                }
                .background(.orange)
                .navigationTitle("약속 관리")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            print("Add Item")
                        } label: {
                            Image(systemName: "plus")
                                .foregroundColor(.black)
                        }
                    }
                }
            }
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
