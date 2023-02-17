import SwiftUI

enum FormViewState {
    case none
    case valid
    case notValid
    
    var strokeColor: Color {
        switch self {
        case .none:
            return Color(red: 0.94, green: 0.94, blue: 0.94)
        case .valid:
            return Color.blue
        case .notValid:
            return Color.red
        }
    }
    
    var warningText: String {
        switch self {
        case .notValid:
            return "10글자를 초과했습니다."
        default:
            return ""
        }
    }
}

