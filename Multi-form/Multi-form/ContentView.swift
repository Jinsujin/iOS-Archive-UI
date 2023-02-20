import SwiftUI

struct ContentView: View {
    @State private var showEntryView = false
    
    var body: some View {
        VStack {
            Button {
                print("touched button")
                showEntryView.toggle()
            } label: {
                Text("입력하기")
            }
            .fullScreenCover(isPresented: self.$showEntryView, content: FormView.init)
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
