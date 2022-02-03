public protocol DictionaryProtocol: Sequence where Element == (key: Key, value: Value) {
    associatedtype Key: Hashable
    associatedtype Value
    associatedtype Keys: Sequence where Keys.Element == Key
    associatedtype Values: Sequence where Values.Element == Value
    
    var count: Int { get }
    
    var keys: Keys { get }
    var values: Values { get }
    
    subscript(key: Key) -> Value? { get }
}

extension Dictionary: DictionaryProtocol {}
