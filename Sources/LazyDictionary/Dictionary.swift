extension Dictionary {
    // T does not conform to `DictionaryProtocol`
    // because when the standard library provides `.init(_: Dictionary<Key, Value>)`
    // calling `.init` for `Dictionary` may be ambiguous.
    public init<T>(_ dictionary: T) where T: LazyDictionaryProtocol, T.Key == Key, T.Value == Value {
        let uniqueKeysWithValues = dictionary.lazy.map { ($0.key, $0.value) }
        self.init(uniqueKeysWithValues: uniqueKeysWithValues)
    }
    
    public var lazyDictionary: LazyDictionary<Key, Value> {
        LazyDictionary(dictionary: self)
    }
}

extension Dictionary: DictionaryProtocol {}
