public struct LazyMapValuesDictionary<Base, Value>: LazyDictionaryProtocol where Base: LazyDictionaryProtocol {
    private let base: Base
    private let transform: (Base.Value) -> Value

    internal init(base: Base, transform: @escaping (Base.Value) -> Value) {
        self.base = base
        self.transform = transform
    }

    public var count: Int { base.count }

    public var keys: Base.Keys { base.keys }
    public var values: LazyMapSequence<Base.Values, Value> { base.values.lazy.map(transform) }

    public subscript(key: Base.Key) -> Value? {
        base[key].map(transform)
    }
    
    public func makeIterator() -> LazyMapSequence<LazySequence<Base>.Elements, (key: Base.Key, value: Value)>.Iterator {
        base.lazy.map { element in (element.key, transform(element.value)) }.makeIterator()
    }
}
