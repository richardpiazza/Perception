import Foundation
@testable import Perception

extension Array where Element == Card {
    static var validBoard_3Triads: [Card] {
        [
            .init(number: .one, fill: .shaded, color: .light, shape: .star),
            .init(number: .two, fill: .outlined, color: .light, shape: .star),
            .init(number: .two, fill: .shaded, color: .light, shape: .square),
            .init(number: .two, fill: .outlined, color: .dark, shape: .star), // 1, 2
            .init(number: .three, fill: .outlined, color: .light, shape: .star),
            .init(number: .one, fill: .outlined, color: .medium, shape: .circle), // 1, 3
            .init(number: .one, fill: .outlined, color: .dark, shape: .star), // 3
            .init(number: .one, fill: .outlined, color: .light, shape: .square), // 3
            .init(number: .two, fill: .solid, color: .dark, shape: .star),  // 2
            .init(number: .two, fill: .shaded, color: .dark, shape: .star),  // 2
            .init(number: .three, fill: .outlined, color: .light, shape: .square), // 1
            .init(number: .two, fill: .shaded, color: .light, shape: .circle),
        ]
    }
    
    static var validBoard_3Triads_remainingDeck: [Card] {
        let board = self.validBoard_3Triads
        var deck = Card.makeDeck()
        deck.removeAll(where: { board.contains($0) })
        return deck
    }
    
    static var invalidBoard_0Triads_requiresAdditionalDeal: [Card] {
        [
            .init(number: .three, fill: .solid, color: .dark, shape: .square),
            .init(number: .two, fill: .shaded, color: .light, shape: .square),
            .init(number: .one, fill: .outlined, color: .dark, shape: .star),
            .init(number: .one, fill: .shaded, color: .dark, shape: .circle),
            .init(number: .three, fill: .shaded, color: .light, shape: .star),
            .init(number: .one, fill: .outlined, color: .light, shape: .circle),
            .init(number: .two, fill: .solid, color: .dark, shape: .star),
            .init(number: .three, fill: .outlined, color: .light, shape: .star),
            .init(number: .one, fill: .outlined, color: .light, shape: .star),
            .init(number: .two, fill: .solid, color: .light, shape: .circle),
            .init(number: .three, fill: .outlined, color: .medium, shape: .square),
            .init(number: .one, fill: .shaded, color: .medium, shape: .square),
        ]
    }
    
    static var invalidBoard_0Triads_nextDeal: [Card] {
        [
            .init(number: .two, fill: .shaded, color: .medium, shape: .circle),
            .init(number: .three, fill: .solid, color: .medium, shape: .square),
            .init(number: .three, fill: .outlined, color: .medium, shape: .circle),
        ]
    }
}
