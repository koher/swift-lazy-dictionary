import XCTest
import LazyDictionary

final class Examples: XCTestCase {
    func testExample() {
        let dictionary = ["a": 0, "b": 1, "c": 1, "d": 2, "e": 3]
        let lazy = dictionary.lazyDictionary
        
        // ["a": 0, "d": 2]
        let a = lazy.filter { $0.value.isMultiple(of: 2) }
        
        // ["a": 0, "b": 1, "c": 1, "d": 4, "e": 9]
        let b = lazy.mapValues { $0 * $0 }
        
        // ["a": 0, "d": 4]
        let c = lazy.compactMapValues { $0.isMultiple(of: 2) ? $0 * $0 : nil }

        XCTAssertEqual(
            [String: Int](uniqueKeysWithValues: a.map { ($0.key, $0.value) }),
            ["a": 0, "d": 2]
        )
        
        XCTAssertEqual(
            [String: Int](uniqueKeysWithValues: b.map { ($0.key, $0.value) }),
            ["a": 0, "b": 1, "c": 1, "d": 4, "e": 9]
        )

        XCTAssertEqual(
            [String: Int](uniqueKeysWithValues: c.map { ($0.key, $0.value) }),
            ["a": 0, "d": 4]
        )
    }
}
