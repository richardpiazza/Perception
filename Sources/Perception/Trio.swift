import Foundation

@available(*, deprecated, renamed: "Trio")
public typealias Triad = Trio

/// Represents a _set_ of three cards that have attributes all unique or all equal.
public struct Trio {
    
    @available(*, deprecated, renamed: "PerceptionError")
    public enum Error: Swift.Error {
        case numberOfCards
        case uniqueCards
        case numberAttribute
        case fillAttribute
        case colorAttribute
        case shapeAttribute
    }
    
    public static let cardsRequired: Int = 3
    
    @available(*, deprecated, message: "Use Array<Card>.trios")
    public static func triads(in cards: [Card]) -> [Trio] {
        return cards.trios
    }
    
    @available(*, deprecated, message: "Use Array<Card>.validateTrio()")
    public static func validate(cards: [Card]) throws {
        try cards.validateTrio()
    }
    
    public let cards: [Card]
    
    public var first: Card { cards[0] }
    public var second: Card { cards[1] }
    public var third: Card { cards[2] }
    
    public init(_ cards: [Card]) throws {
        try cards.validateTrio()
        self.cards = cards
    }
    
    public init(_ cards: Card...) throws {
        try cards.validateTrio()
        self.cards = cards
    }
}
