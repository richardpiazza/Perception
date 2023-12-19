import XCTest
@testable import Perception

final class TrioTests: XCTestCase {
    
    func testTriadsIn() {
        var trios = [Card]().trios
        XCTAssertEqual(trios.count, 0)
        
        var cards: [Card] = .invalidBoard_0Triads_requiresAdditionalDeal
        trios = cards.trios
        XCTAssertEqual(trios.count, 0)
        XCTAssertEqual(Set(cards).count, 12) // No duplicate cards
        
        cards = .validBoard_3Triads
        trios = cards.trios
        XCTAssertEqual(trios.count, 3)
        XCTAssertEqual(Set(cards).count, 12) // No duplicate cards
    }
    
    func testValidate() throws {
        var cards: [Card] = []
        
        XCTAssertThrowsError(try cards.validateTrio()) { error in
            XCTAssertEqual(error as? PerceptionError, .numberOfCards)
        }
        
        cards = [
            .init(number: .one, fill: .outlined, color: .dark, shape: .circle),
            .init(number: .one, fill: .outlined, color: .dark, shape: .circle),
            .init(number: .one, fill: .outlined, color: .dark, shape: .circle),
        ]
        
        XCTAssertThrowsError(try cards.validateTrio()) { error in
            XCTAssertEqual(error as? PerceptionError, .uniqueCards)
        }
        
        cards = [
            .init(number: .one, fill: .outlined, color: .dark, shape: .circle),
            .init(number: .one, fill: .shaded, color: .dark, shape: .circle),
            .init(number: .two, fill: .solid, color: .dark, shape: .circle),
        ]
        
        XCTAssertThrowsError(try cards.validateTrio()) { error in
            XCTAssertEqual(error as? PerceptionError, .numberAttribute)
        }
        
        cards = [
            .init(number: .one, fill: .outlined, color: .dark, shape: .circle),
            .init(number: .two, fill: .shaded, color: .dark, shape: .circle),
            .init(number: .three, fill: .shaded, color: .dark, shape: .circle),
        ]
        
        XCTAssertThrowsError(try cards.validateTrio()) { error in
            XCTAssertEqual(error as? PerceptionError, .fillAttribute)
        }
        
        cards = [
            .init(number: .one, fill: .outlined, color: .dark, shape: .circle),
            .init(number: .two, fill: .shaded, color: .dark, shape: .circle),
            .init(number: .three, fill: .solid, color: .medium, shape: .circle),
        ]
        
        XCTAssertThrowsError(try cards.validateTrio()) { error in
            XCTAssertEqual(error as? PerceptionError, .colorAttribute)
        }
        
        cards = [
            .init(number: .one, fill: .outlined, color: .dark, shape: .circle),
            .init(number: .two, fill: .shaded, color: .dark, shape: .circle),
            .init(number: .three, fill: .solid, color: .dark, shape: .square),
        ]
        
        XCTAssertThrowsError(try cards.validateTrio()) { error in
            XCTAssertEqual(error as? PerceptionError, .shapeAttribute)
        }
        
        cards = [
            .init(number: .one, fill: .outlined, color: .dark, shape: .circle),
            .init(number: .two, fill: .shaded, color: .dark, shape: .circle),
            .init(number: .three, fill: .solid, color: .dark, shape: .circle),
        ]
        
        XCTAssertNoThrow(try cards.validateTrio())
        
        let triad = try Trio(cards)
        XCTAssertEqual(triad.first, cards[0])
        XCTAssertEqual(triad.second, cards[1])
        XCTAssertEqual(triad.third, cards[2])
    }
}
