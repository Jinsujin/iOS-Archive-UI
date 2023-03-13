import SwiftUI

// MARK: - Models
struct Todo: Identifiable {
    let id = UUID()
    let title: String
    let endDate: String
    let startDate: String
}

struct Cook: Identifiable {
    let id = UUID()
    let title: String
    let emoji: String
}


// MARK: - ContentListView
struct ContentListView: View {
    struct CellModel: Identifiable {
        var id = UUID()
        let title: String
        let names: [String]
    }
    
    private var models: [CellModel] = [
        .init(title: "타이틀1", names: ["A", "B", "C"])
    ]
    
    private let todoList = [
        Todo(title: "Todo1", endDate: "03-11", startDate: "03-24"),
        Todo(title: "Todo2", endDate: "04-02", startDate: "03-09")
    ]
    
    private let cookList = [
        Cook(title: "김치찜", emoji: "🍝"),
        Cook(title: "계란말이", emoji: "🍳"),
        Cook(title: "카레", emoji: "🍛")
    ]
    
    var body: some View {
        List {
            Section("할일 리스트") {
                ForEach(todoList) { todo in
                    DetailView(
                        item: todo,
                        keyPaths: .init(titleKeyPath: \.title, subtitleKeyPath: \.endDate)
                    )
                }
            }
                
            Section("요리 리스트") {
                ForEach(cookList) { cook in
                    DetailView(
                        item: cook,
                        keyPaths: .init(titleKeyPath: \.title, subtitleKeyPath: \.emoji)
                    )
                }
            }
        }
    }
}
  
// MARK: - DetailView<Model>
struct DetailView<Model>: View {
    struct KeyPaths {
        let titleKeyPath: KeyPath<Model, String>
        let subtitleKeyPath: KeyPath<Model, String>
    }
    
    let title: String
    let description: String
    
    init(item: Model, keyPaths: KeyPaths) {
        self.title = item[keyPath: keyPaths.titleKeyPath]
        self.description = item[keyPath: keyPaths.subtitleKeyPath]
    }
    
    var body: some View {
        HStack {
            Text(title)
            Text(description)
        }
    }
}

struct ContentListView_Previews: PreviewProvider {
    static var previews: some View {
        ContentListView()
    }
}
