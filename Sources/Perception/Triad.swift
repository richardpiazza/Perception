import Foundation

public struct Triad {
    
    public enum Error: Swift.Error {
        case numberOfCards
        case uniqueCards
        case numberAttribute
        case fillAttribute
        case colorAttribute
        case shapeAttribute
    }
    
    public static let cardsRequired: Int = 3
    
    static func triads(in cards: [Card]) -> [Triad] {
        var triads = [Triad]()
        
        guard cards.count >= Triad.cardsRequired else {
            return triads
        }
        
        // [***_______] through [_______***]
        for i in 0..<(cards.count - 2) {
            for j in (i + 1)..<(cards.count - 1) {
                for k in (j + 1)..<cards.count {
                    if let triad = try? Triad(cards[i], cards[j], cards[k]) {
                        triads.append(triad)
                    }
                }
            }
        }
        
        return triads
    }
    
    static func validate(cards: [Card]) throws {
        guard cards.count == Self.cardsRequired else {
            throw Error.numberOfCards
        }
        
        guard Set(cards).count == Self.cardsRequired else {
            throw Error.uniqueCards
        }
        
        let numbers = cards.map({ $0.number.rawValue })
        guard [numbers.allEqual, numbers.allUnique].contains(true) else {
            throw Error.numberAttribute
        }
        
        let fills = cards.map({ $0.fill.rawValue })
        guard [fills.allEqual, fills.allUnique].contains(true) else {
            throw Error.fillAttribute
        }
        
        let colors = cards.map({ $0.color.rawValue })
        guard [colors.allEqual, colors.allUnique].contains(true) else {
            throw Error.colorAttribute
        }
        
        let shapes = cards.map({ $0.shape.rawValue })
        guard [shapes.allEqual, shapes.allUnique].contains(true) else {
            throw Error.shapeAttribute
        }
    }
    
    public let cards: [Card]
    
    public var first: Card { cards[0] }
    public var second: Card { cards[1] }
    public var third: Card { cards[2] }
    
    public init(_ cards: [Card]) throws {
        try Self.validate(cards: cards)
        self.cards = cards
    }
    
    public init(_ cards: Card...) throws {
        try Self.validate(cards: cards)
        self.cards = cards
    }
}

private extension Array where Element == String {
    var allEqual: Bool { Set(self).count == 1 }
    var allUnique: Bool { Set(self).count == count }
}
