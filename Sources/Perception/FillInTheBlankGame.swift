import Foundation

/// Two cards are given, options to complete the set are shown.
public class FillInTheBlankGame: Game, Codable {
    
    private enum CodingKeys: String, CodingKey {
        case pair
        case board
    }
    
    public internal(set) var pair: (Card, Card) = (Card(), Card())
    public internal(set) var board: [Card] = []
    
    public init() {
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let pairArray = try container.decode([Card].self, forKey: .pair)
        guard pairArray.count == 2 else {
            throw DecodingError.dataCorruptedError(forKey: CodingKeys.pair, in: container, debugDescription: "Pair must container 2 cards.")
        }
        pair = (pairArray[0], pairArray[1])
        board = try container.decode([Card].self, forKey: .board)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode([pair.0, pair.1], forKey: .pair)
        try container.encode(board, forKey: .board)
    }
    
    public func shuffle() {
        board.removeAll()
    }
    
    public func deal() throws {
        let deck = Card.makeDeck().shuffled()
        var seed = Array(deck.prefix(16))
        
        guard let triad = Triad.triads(in: seed).randomElement() else {
            try deal()
            return
        }
        
        pair = (triad.first, triad.second)
        var cards = [triad.third]
        
        seed.removeAll(where: { triad.cards.contains($0) })
        
        while cards.count < 6 {
            seed.shuffle()
            let card = seed.removeFirst()
            cards.append(card)
        }
        
        board = cards.shuffled()
    }
    
    public func play(_ card: Card) throws {
        let cards = [pair.0, pair.1, card]
        try Triad.validate(cards: cards)
    }
}
