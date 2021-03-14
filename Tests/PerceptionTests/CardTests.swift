import XCTest
@testable import Perception

final class CardTests: XCTestCase {
    
    static var allTests = [
        ("testIdentifiable", testIdentifiable),
        ("testCustomStringConvertible", testCustomStringConvertible),
        ("testCustomDebugStringConvertible", testCustomDebugStringConvertible),
        ("testEquatable", testEquatable),
        ("testCodable", testCodable),
        ("testMakeDeck", testMakeDeck),
    ]
    
    func testIdentifiable() throws {
        var card = Card(number: .one, fill: .outlined, color: .light, shape: .circle)
        XCTAssertEqual(card.id, "one,outlined,light,circle")
        
        card = Card(number: .two, fill: .shaded, color: .medium, shape: .square)
        XCTAssertEqual(card.id, "two,shaded,medium,square")
        
        card = Card(number: .three, fill: .solid, color: .dark, shape: .star)
        XCTAssertEqual(card.id, "three,solid,dark,star")
    }
    
    func testCustomStringConvertible() throws {
        var card = Card(number: .one, fill: .outlined, color: .light, shape: .circle)
        XCTAssertEqual(card.description, "One Outlined Light Circle")
        
        card = Card(number: .two, fill: .shaded, color: .medium, shape: .square)
        XCTAssertEqual(card.description, "Two Shaded Medium Square")
        
        card = Card(number: .three, fill: .solid, color: .dark, shape: .star)
        XCTAssertEqual(card.description, "Three Solid Dark Star")
    }
    
    func testCustomDebugStringConvertible() throws {
        var card = Card(number: .one, fill: .outlined, color: .light, shape: .circle)
        XCTAssertEqual(card.debugDescription, """
        Card:
            - number: One
            -   fill: Outlined
            -  color: Light
            -  shape: Circle
        """)
        
        card = Card(number: .two, fill: .shaded, color: .medium, shape: .square)
        XCTAssertEqual(card.debugDescription, """
        Card:
            - number: Two
            -   fill: Shaded
            -  color: Medium
            -  shape: Square
        """)
        
        card = Card(number: .three, fill: .solid, color: .dark, shape: .star)
        XCTAssertEqual(card.debugDescription, """
        Card:
            - number: Three
            -   fill: Solid
            -  color: Dark
            -  shape: Star
        """)
    }
    
    func testEquatable() throws {
        let card1 = Card(number: .one, fill: .shaded, color: .medium, shape: .square)
        var card2 = Card(number: .one, fill: .shaded, color: .medium, shape: .square)
        
        XCTAssertEqual(card1, card2)
        
        card2 = Card(number: .two, fill: .solid, color: .light, shape: .circle)
        
        XCTAssertNotEqual(card1, card2)
    }
    
    func testCodable() throws {
        let decoder = JSONDecoder()
        let encoder = JSONEncoder()
        
        let json = """
        {
            "number": "one",
            "fill": "outlined",
            "color": "medium",
            "shape": "star"
        }
        """
        
        var data = try XCTUnwrap(json.data(using: .utf8))
        var card = try decoder.decode(Card.self, from: data)

        XCTAssertEqual(card.number, .one)
        XCTAssertEqual(card.fill, .outlined)
        XCTAssertEqual(card.color, .medium)
        XCTAssertEqual(card.shape, .star)

        card = Card(number: .three, fill: .solid, color: .light, shape: .square)
        data = try encoder.encode(card)

        XCTAssertEqual(data, "{\"number\":\"three\",\"fill\":\"solid\",\"shape\":\"square\",\"color\":\"light\"}".data(using: .utf8))
    }
    
    func testMakeDeck() throws {
        let deck = Card.makeDeck()
        XCTAssertEqual(deck.count, 81)
        XCTAssertEqual(Set(deck).count, 81)
        
        let card = Card()
        XCTAssertTrue(deck.contains(card))
    }
}
