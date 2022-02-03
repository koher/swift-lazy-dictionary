public protocol LazyDictionaryProtocol: DictionaryProtocol {
    func filter(_ isIncluded: @escaping (Element) -> Bool) -> LazyFilterDictionary<Self>
    func mapValues<T>(_ transform: @escaping (Value) -> T) -> LazyMapValuesDictionary<Self, T>
    func compactMapValues<T>(_ transform: @escaping (Value) -> T?) -> LazyMapValuesDictionary<LazyFilterDictionary<LazyMapValuesDictionary<Self, T?>>, T>
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
    
    public var description: String {
        var description = ""
        for (key, value) in self {
            if description.isEmpty {
                description.append("[")
            } else {
                description.append(", ")
            }
            description.append("\"\(key)\": \(value)")
        }
        description.append("]")
        return description
    }
    
    public var debugDescription: String {
        description
    }
}
