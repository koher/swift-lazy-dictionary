extension Dictionary {
    public var lazyDictionary: LazyDictionary<Key, Value> {
        LazyDictionary(dictionary: self)
    }
}

extension Dictionary: DictionaryProtocol {}
