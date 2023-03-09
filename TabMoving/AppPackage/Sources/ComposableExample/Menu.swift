import Foundation

enum Menu: Int, CaseIterable {
    case menu1 = 0
    case menu2 = 1
    case menu3 = 2
    case settings = 3
    
    var title: String {
        switch self {
        case .menu1: return "메뉴1"
        case .menu2: return "메뉴2"
        case .menu3: return "메뉴3"
        case .settings: return "설정"
        }
    }
}
