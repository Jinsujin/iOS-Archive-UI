import Foundation


// MARK: - Type Eraser Wrapper
private protocol AnyTypeBase {
    var value: Any { get }
}

/// AnyTypeBase 을 채택한 구체 인스턴스를 담는 상자
private struct AnyComparableBox<T: Comparable>: AnyTypeBase {
    let origin: T
    var value: Any { self.origin }
}

/// `Public Wrapper` (값을 감싸는 타입)
/// - private box 에 구체 인스턴스를 담는다
struct AnyCompare: Comparable {
    private var box: AnyTypeBase

    public init<T>(_ value: T) where T : Comparable {
        box = AnyComparableBox(origin: value)
    }
    
    var value: Any {
        return box.value
    }
    
    static func < (lhs: AnyCompare, rhs: AnyCompare) -> Bool {
        return false
    }
    static func == (lhs: AnyCompare, rhs: AnyCompare) -> Bool {
        return false
    }
}

// MARK: - Bool extension
extension Bool: Comparable {
    public static func < (lhs: Bool, rhs: Bool) -> Bool {
        return false
    }
}
