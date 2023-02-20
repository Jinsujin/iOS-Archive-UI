import Foundation

struct Theme: Identifiable, CaseIterable {
    static var allCases: [Theme] = [
        Theme(type: .meal, isCheck: false),
        Theme(type: .meeting, isCheck: false),
        Theme(type: .travel, isCheck: false),
        Theme(type: .etc, isCheck: false)
    ]
    
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
