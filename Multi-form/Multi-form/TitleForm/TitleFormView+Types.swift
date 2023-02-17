import SwiftUI

extension TitleFormView {
    
    enum CellType {
        case title
        case place
        
        var text: String {
            switch self {
            case .title:
                return "약속명(선택)"
            case .place:
                return "장소(선택)"
            }
        }
        
        var placeholder: String {
            switch self {
            case .title:
                return "YUMMY"
            case .place:
                return "강남, 온라인 등"
            }
        }
    }
        
    enum ViewState {
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
}
