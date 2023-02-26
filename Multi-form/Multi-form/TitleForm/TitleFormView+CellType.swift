import SwiftUI

extension TitleFormView {

    enum CellType: String, CaseIterable {
        case title = "title"
        case place = "place"

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
}
