import Foundation

enum ThemeType: String, CaseIterable {
    case meal = "meal"
    case meeting = "meeting"
    case travel = "travel"
    case etc = "etc"
    
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
