public protocol DictionaryProtocol: Sequence, CustomStringConvertible, CustomDebugStringConvertible where Element == (key: Key, value: Value) {
    associatedtype Key
    associatedtype Value
    associatedtype Keys: SetProtocol where Keys.Element == Key
    associatedtype Values: Sequence where Values.Element == Value
    
    var count: Int { get }
    
    var keys: Keys { get }
    var values: Values { get }
    
    subscript(key: Key) -> Value? { get }
}

extension Dictionary: DictionaryProtocol {}
