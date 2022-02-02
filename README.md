# LazyDictionary

Provides lazy `filter`, `mapValues` and `compactMapValues` for `Dictionary`.

```swift
let dictionary = ["a": 0, "b": 1, "c": 1, "d": 2, "e": 3]
let lazy = dictionary.lazyDictionary

// ["a": 0, "d": 2]
let a = lazy.filter { $0.value.isMultiple(of: 2) }

// ["a": 0, "b": 1, "c": 1, "d": 4, "e": 9]
let b = lazy.mapValues { $0 * $0 }

// ["a": 0, "d": 4]
let c = lazy.compactMapValues { $0.isMultiple(of: 2) ? $0 * $0 : nil }
```

## License

[MIT](LICENSE)
