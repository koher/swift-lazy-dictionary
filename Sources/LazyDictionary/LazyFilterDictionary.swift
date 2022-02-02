public struct LazyFilterDictionary<Base>: LazyDictionaryProtocol where Base: LazyDictionaryProtocol {
    private let base: Base
    private let isIncluded: (Base.Element) -> Bool

    internal init(base: Base, isIncluded: @escaping (Base.Element) -> Bool) {
        self.base = base
        self.isIncluded = isIncluded
    }

    /// O(n)
    public var count: Int { base.lazy.filter(isIncluded).reduce(0) { r, _ in r + 1 } }

    public var keys: LazyMapSequence<LazyFilterSequence<LazySequence<Base>.Elements>.Elements, Base.Key> {
        base.lazy.filter(isIncluded).map(\.key)
    }
    
    public var values: LazyMapSequence<LazyFilterSequence<LazySequence<Base>.Elements>.Elements, Base.Value> {
        base.lazy.filter(isIncluded).map(\.value)
    }

    public subscript(key: Base.Key) -> Base.Value? {
        guard let value = base[key] else { return nil }
        guard isIncluded((key, value)) else { return nil }
        return value
    }
    
    public func makeIterator() -> LazyMapSequence<LazyFilterSequence<LazyMapSequence<LazySequence<Base>.Elements, (key: Base.Key, value: Base.Value)?>>, (key: Base.Key, value: Base.Value)>.Iterator {
        base.lazy.compactMap { element -> (key: Base.Key, value: Base.Value)? in
            guard isIncluded(element) else { return nil }
            return (element.key, element.value)
        }.makeIterator()
    }
}
