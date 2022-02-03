import XCTest
import LazyDictionary

final class DictionaryTests: XCTestCase {
    func testInit() {
        let a = ["a": 0, "b": 1, "c": 1, "d": 2, "e": 3, "f": 5, "g": 8]
        let b = a.lazyDictionary
        let r: [String: Int] = .init(b)
        XCTAssertEqual(r, a)
    }
}
