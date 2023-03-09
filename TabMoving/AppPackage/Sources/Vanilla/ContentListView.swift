import SwiftUI

struct ContentListView: View {
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
        }
    }
}

struct ContentListView_Previews: PreviewProvider {
    static var previews: some View {
        ContentListView()
    }
}
