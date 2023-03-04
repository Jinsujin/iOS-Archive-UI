import SwiftUI

struct ContentView: View {
    @State private var activeMenu = Menu.menu1
    
    var body: some View {
        
        NavigationView {
            // 하위뷰(HeaderTabView)에 상위뷰(VStack)의 크기를 넣어주기 위해 사용
            GeometryReader { geo in
                VStack {
                    HeaderTabView(
                        activeMenu: $activeMenu,
                        menus: Menu.allCases,
                        fullWidth: geo.size.width,
                        spacing: 32,
                        horizontalInset: 40)
                    
                    // Pages
                    TabView(selection: $activeMenu) {
                        ContentListView()
                            .tag(Menu.menu1)

                        Text(Menu.menu2.title)
                            .tag(Menu.menu2)
                        
                        ContentListView()
                            .tag(Menu.menu3)

                        Text(Menu.menu4.title)
                            .tag(Menu.menu4)
                    }
                    // selectedIndex 가 바뀌었을때 컨텐츠 슬라이드
                    .animation(.default, value: activeMenu)
                    .background(.gray)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 200)
                    .tabViewStyle(.page(indexDisplayMode: .never))
                }
                .background(.orange)
                .navigationTitle("Tab Menu")
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
