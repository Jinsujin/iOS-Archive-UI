import Foundation

public protocol ReuseIdentiable {
    static var identifier: String { get }
}

extension ReuseIdentiable {
    public static var identifier: String {
        return String(describing: self)
    }
}
