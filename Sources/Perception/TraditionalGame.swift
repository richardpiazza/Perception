import Foundation

/// The classic **SET** game play. 81 cards, 12 cards on the board.
public class TraditionalGame: Game, Codable {
    
    public enum Error: Swift.Error {
        case gameOver
        case deal(cardsRequested: Int, cardsAvailable: Int)
        case cardNotPlayable(Card)
    }
    
    static let cardsRequiredToStart: Int = 12
    static let cardsDealtEachRound: Int = 3
    
    public internal(set) var deck: [Card] = Card.makeDeck()
    public internal(set) var board: [Card] = []
    public internal(set) var discard: [Card] = []
    public internal(set) var selected: [Card] = []
    
    public init() {
    }
    
    public func shuffle() {
        deck = Card.makeDeck().shuffled()
        board = []
        discard = []
        selected = []
    }
    
    public func deal() throws {
        guard !gameOver else {
            throw Error.gameOver
        }
        
        let triads = availablePlays
        let hasPlays = !triads.isEmpty
        let hasEnoughCards = board.count >= Self.cardsRequiredToStart
        
        if hasPlays && hasEnoughCards {
            return
        }
        
        let cardsToDeal = max(Self.cardsRequiredToStart - board.count, Self.cardsDealtEachRound)
        guard deck.count >= cardsToDeal else {
            // Endgame conditions
            guard hasPlays else {
                // Not sure this is even possible, but it protects against the handling below.
                throw Error.deal(cardsRequested: cardsToDeal, cardsAvailable: deck.count)
            }
            
            return
        }
        
        let draw = Array(deck.prefix(cardsToDeal))
        board.append(contentsOf: draw)
        deck.removeFirst(cardsToDeal)
        
        // Recursively called to handle the special condition where a standard draw
        // does not provide the game with any additional sets/triads.
        try deal()
    }
    
    public func play(_ card: Card) throws {
        guard board.contains(card) else {
            throw Error.cardNotPlayable(card)
        }
        
        // If previously selected, deselect.
        if let idx = selected.firstIndex(of: card) {
            selected.remove(at: idx)
            return
        }
        
        selected.append(card)
        
        guard selected.count == Triad.cardsRequired else {
            return
        }
        
        do {
            try Triad.validate(cards: selected)
        } catch {
            selected.removeAll()
            throw error
        }
        
        discard.append(contentsOf: selected)
        board.removeAll(where: { selected.contains($0) })
        selected.removeAll()
    }
    
    /// Returns the discarded cards to the deck (infinite play)
    public func reshuffleDiscard() {
        deck.append(contentsOf: discard)
        discard.removeAll()
        deck.shuffle()
    }
}

public extension TraditionalGame {
    var availablePlays: [Triad] { Triad.triads(in: board) }
    var gameOver: Bool { deck.isEmpty && availablePlays.isEmpty }
}
