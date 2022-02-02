public struct LazyDictionary<Key, Value>: LazyDictionaryProtocol where Key: Hashable {
    private let dictionary: [Key: Value]
    
    internal init(dictionary: [Key: Value]) {
        self.dictionary = dictionary
    }
    
    public var count: Int { dictionary.count }
    public var keys: Dictionary<Key, Value>.Keys { dictionary.keys }
    public var values: Dictionary<Key, Value>.Values { dictionary.values }
    
    public subscript(key: Key) -> Value? {
        dictionary[key]
    }

    public func makeIterator() -> Dictionary<Key, Value>.Iterator {
        dictionary.makeIterator()
    }
}

extension Dictionary {
    public var lazyDictionary: LazyDictionary<Key, Value> {
        LazyDictionary(dictionary: self)
    }
}
