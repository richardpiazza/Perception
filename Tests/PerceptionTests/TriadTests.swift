import XCTest
@testable import Perception

final class TriadTests: XCTestCase {
    
    static var allTests = [
        ("testTriadsIn", testTriadsIn),
        ("testValidate", testValidate),
    ]
    
    func testTriadsIn() {
        var triads = Triad.triads(in: [])
        XCTAssertEqual(triads.count, 0)
        
        var cards: [Card] = .invalidBoard_0Triads_requiresAdditionalDeal
        triads = Triad.triads(in: cards)
        XCTAssertEqual(triads.count, 0)
        XCTAssertEqual(Set(cards).count, 12) // No duplicate cards
        
        cards = .validBoard_3Triads
        triads = Triad.triads(in: cards)
        XCTAssertEqual(triads.count, 3)
        XCTAssertEqual(Set(cards).count, 12) // No duplicate cards
    }
    
    func testValidate() throws {
        var cards: [Card] = []
        
        XCTAssertThrowsError(try Triad.validate(cards: cards)) { (error) in
            XCTAssertEqual(error as? Triad.Error, .numberOfCards)
        }
        
        cards = [
            .init(number: .one, fill: .outlined, color: .dark, shape: .circle),
            .init(number: .one, fill: .outlined, color: .dark, shape: .circle),
            .init(number: .one, fill: .outlined, color: .dark, shape: .circle),
        ]
        
        XCTAssertThrowsError(try Triad.validate(cards: cards)) { (error) in
            XCTAssertEqual(error as? Triad.Error, .uniqueCards)
        }
        
        cards = [
            .init(number: .one, fill: .outlined, color: .dark, shape: .circle),
            .init(number: .one, fill: .shaded, color: .dark, shape: .circle),
            .init(number: .two, fill: .solid, color: .dark, shape: .circle),
        ]
        
        XCTAssertThrowsError(try Triad.validate(cards: cards)) { (error) in
            XCTAssertEqual(error as? Triad.Error, .numberAttribute)
        }
        
        cards = [
            .init(number: .one, fill: .outlined, color: .dark, shape: .circle),
            .init(number: .two, fill: .shaded, color: .dark, shape: .circle),
            .init(number: .three, fill: .shaded, color: .dark, shape: .circle),
        ]
        
        XCTAssertThrowsError(try Triad.validate(cards: cards)) { (error) in
            XCTAssertEqual(error as? Triad.Error, .fillAttribute)
        }
        
        cards = [
            .init(number: .one, fill: .outlined, color: .dark, shape: .circle),
            .init(number: .two, fill: .shaded, color: .dark, shape: .circle),
            .init(number: .three, fill: .solid, color: .medium, shape: .circle),
        ]
        
        XCTAssertThrowsError(try Triad.validate(cards: cards)) { (error) in
            XCTAssertEqual(error as? Triad.Error, .colorAttribute)
        }
        
        cards = [
            .init(number: .one, fill: .outlined, color: .dark, shape: .circle),
            .init(number: .two, fill: .shaded, color: .dark, shape: .circle),
            .init(number: .three, fill: .solid, color: .dark, shape: .square),
        ]
        
        XCTAssertThrowsError(try Triad.validate(cards: cards)) { (error) in
            XCTAssertEqual(error as? Triad.Error, .shapeAttribute)
        }
        
        cards = [
            .init(number: .one, fill: .outlined, color: .dark, shape: .circle),
            .init(number: .two, fill: .shaded, color: .dark, shape: .circle),
            .init(number: .three, fill: .solid, color: .dark, shape: .circle),
        ]
        
        XCTAssertNoThrow(try Triad.validate(cards: cards))
        
        let triad = try Triad(cards)
        XCTAssertEqual(triad.first, cards[0])
        XCTAssertEqual(triad.second, cards[1])
        XCTAssertEqual(triad.third, cards[2])
    }
}
