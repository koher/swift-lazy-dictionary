import XCTest
import LazyDictionary

private let original: [String: Int] = ["a": 0, "b": 1, "c": 1, "d": 2, "e": 3, "f": 5, "g": 8]
private let d = original.lazyDictionary

final class LazyDictionaryTests: XCTestCase {
    func testCount() {
        let r = d.count
        XCTAssertEqual(r, 7)
    }
    
    func testKeys() {
        let r = d.keys
        XCTAssertEqual(
            Set(r),
            ["a", "b", "c", "d", "e", "f", "g"]
        )
    }
    
    func testValues() {
        let r = d.values
        XCTAssertEqual(
            r.reduce(into: [:]) { $0[$1, default: 0] += 1 },
            [0: 1, 1: 2, 2: 1, 3: 1, 5: 1, 8: 1]
        )
    }
    
    func testSubscript() {
        XCTContext.runActivity(named: "Contained") { _ in
            let r = d["g"]
            XCTAssertEqual(r, 8)
        }
        
        XCTContext.runActivity(named: "Not Contained Key") { _ in
            let r = d["x"]
            XCTAssertNil(r)
        }
    }
    
    func testMakeIterator() {
        var r = d.makeIterator()
        var elements: [(key: String, value: Int)] = []
        while let element = r.next() {
            elements.append(element)
        }
        XCTAssertEqual(
            [String: Int](uniqueKeysWithValues: elements),
            original
        )
    }
    
    func testDescription() {
        let r = d.description
        XCTAssertEqual(r.count, original.description.count)
        XCTAssertTrue(r.hasPrefix("["))
        XCTAssertTrue(r.hasSuffix("]"))
        XCTAssertTrue(r.contains(#""a": 0"#))
        XCTAssertTrue(r.contains(#""b": 1"#))
        XCTAssertTrue(r.contains(#""c": 1"#))
        XCTAssertTrue(r.contains(#""d": 2"#))
        XCTAssertTrue(r.contains(#""e": 3"#))
        XCTAssertTrue(r.contains(#""f": 5"#))
        XCTAssertTrue(r.contains(#""g": 8"#))
        XCTAssertEqual(r.filter { $0 == "," }.count, 6)
    }
    
    func testDebugDescription() {
        let r = d.debugDescription
        XCTAssertEqual(r.count, original.description.count)
        XCTAssertTrue(r.hasPrefix("["))
        XCTAssertTrue(r.hasSuffix("]"))
        XCTAssertTrue(r.contains(#""a": 0"#))
        XCTAssertTrue(r.contains(#""b": 1"#))
        XCTAssertTrue(r.contains(#""c": 1"#))
        XCTAssertTrue(r.contains(#""d": 2"#))
        XCTAssertTrue(r.contains(#""e": 3"#))
        XCTAssertTrue(r.contains(#""f": 5"#))
        XCTAssertTrue(r.contains(#""g": 8"#))
        XCTAssertEqual(r.filter { $0 == "," }.count, 6)
    }
}
