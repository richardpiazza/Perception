import Perception

/// The classic **SET** game play. 81 cards, 12 cards on the board.
public class TraditionalGame: Game, Codable {
    
    @available(*, deprecated, renamed: "PerceptionGameplayError")
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
    
    public var availablePlays: [Trio] { board.trios }
    public var gameOver: Bool { deck.isEmpty && availablePlays.isEmpty }
    public var inProgress: Bool {
        if board.isEmpty {
            return false
        }
        if availablePlays.isEmpty {
            return false
        }
        if gameOver {
            return false
        }
        
        return true
    }
    
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
            throw PerceptionGameplayError.gameOver
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
                throw PerceptionGameplayError.deal(cardsRequested: cardsToDeal, cardsAvailable: deck.count)
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
            throw PerceptionGameplayError.cardNotPlayable(card)
        }
        
        // If previously selected, deselect.
        if let idx = selected.firstIndex(of: card) {
            selected.remove(at: idx)
            return
        }
        
        selected.append(card)
        
        guard selected.count == Trio.cardsRequired else {
            return
        }
        
        do {
            try selected.validateTrio()
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

extension TraditionalGame: Equatable {
    public static func == (lhs: TraditionalGame, rhs: TraditionalGame) -> Bool {
        guard lhs.deck == rhs.deck else {
            return false
        }
        
        guard lhs.board == rhs.board else {
            return false
        }
        
        guard lhs.discard == rhs.discard else {
            return false
        }
        
        guard lhs.selected == rhs.selected else {
            return false
        }
        
        return true
    }
}
