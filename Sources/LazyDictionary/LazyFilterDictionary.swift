public struct LazyFilterDictionary<Base>: LazyDictionaryProtocol where Base: LazyDictionaryProtocol {
    private let base: Base
    private let isIncluded: (Base.Element) -> Bool

    internal init(base: Base, isIncluded: @escaping (Base.Element) -> Bool) {
        self.base = base
        self.isIncluded = isIncluded
    }

    /// O(n)
    public var count: Int { base.lazy.filter(isIncluded).reduce(0) { r, _ in r + 1 } }

    public var keys: Keys {
        Keys(base: self)
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
    
    public struct Keys: SetProtocol {
        fileprivate let base: LazyFilterDictionary<Base>
        
        /// O(n)
        public var count: Int { base.count }
        
        public func contains(_ member: Base.Key) -> Bool {
            guard let value = base[member] else { return false }
            return base.isIncluded((key: member, value: value))
        }
        
        public func makeIterator() -> LazyMapSequence<LazyFilterSequence<LazyMapSequence<LazySequence<LazyFilterDictionary<Base>>.Elements, Base.Key?>>, Base.Key>.Iterator {
            base.lazy.compactMap { element -> Base.Key? in
                guard base.isIncluded(element) else { return nil }
                return element.key
            }.makeIterator()
        }
    }
}
