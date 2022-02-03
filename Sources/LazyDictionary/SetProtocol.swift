public protocol SetProtocol: Sequence where Element: Hashable {
    var count: Int { get }
    func contains(_ member: Element) -> Bool
}

extension Set: SetProtocol {}
extension Dictionary.Keys: SetProtocol {}
