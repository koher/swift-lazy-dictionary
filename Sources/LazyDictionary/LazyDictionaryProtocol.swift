public protocol LazyDictionaryProtocol: Sequence where Element == (key: Key, value: Value) {
    associatedtype Key: Hashable
    associatedtype Value
    associatedtype Keys: Sequence where Keys.Element == Key
    associatedtype Values: Sequence where Values.Element == Value
    
    var count: Int { get }
    
    var keys: Keys { get }
    var values: Values { get }
    
    subscript(key: Key) -> Value? { get }
}

extension LazyDictionaryProtocol {
    public func filter(_ isIncluded: @escaping (Element) -> Bool) -> LazyFilterDictionary<Self> {
        LazyFilterDictionary(base: self, isIncluded: isIncluded)
    }
    
    public func mapValues<T>(_ transform: @escaping (Value) -> T) -> LazyMapValuesDictionary<Self, T> {
        LazyMapValuesDictionary(base: self, transform: transform)
    }
    
    public func compactMapValues<T>(_ transform: @escaping (Value) -> T?) -> LazyMapValuesDictionary<LazyFilterDictionary<LazyMapValuesDictionary<Self, T?>>, T> {
        LazyMapValuesDictionary(
            base: LazyFilterDictionary(
                base: LazyMapValuesDictionary(base: self, transform: transform),
                isIncluded: { $0.value != nil }
            ),
            transform: { $0! }
        )
    }
}
