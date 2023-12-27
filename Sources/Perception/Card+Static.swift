public extension Card {
    /// Create a new 'deck' of `Card`s.
    ///
    /// A total of 81 cards will be created, one for each combination of available attributes:
    /// * `Card.Number`
    /// * `Card.Fill`
    /// * `Card.Color`
    /// * `Card.Shape`
    static func makeDeck() -> [Card] {
        var cards: [Card] = [Card]()
        
        Card.Number.allCases.forEach { number in
            Card.Fill.allCases.forEach { fill in
                Card.Color.allCases.forEach { color in
                    Card.Shape.allCases.forEach { shape in
                        cards.append(
                            Card(
                                number: number,
                                fill: fill,
                                color: color,
                                shape: shape
                            )
                        )
                    }
                }
            }
        }
        
        return cards
    }
}

public extension Array where Element == Card {
    /// The _unique_ `Trio`s that are contained in the collection.
    var trios: [Trio] {
        var uniques: [Trio] = []
        
        guard count > Trio.cardsRequired else {
            return uniques
        }
        
        // [***_______] through [_______***]
        for i in 0..<(count - 2) {
            for j in (i + 1)..<(count - 1) {
                for k in (j + 1)..<count {
                    if let trio = try? Trio(self[i], self[j], self[k]) {
                        uniques.append(trio)
                    }
                }
            }
        }
        
        return uniques
    }
    
    /// Asserts that the collection represents a valid `Trio`.
    ///
    /// - throws: `PerceptionError`
    func validateTrio() throws {
        guard count == Trio.cardsRequired else {
            throw PerceptionError.numberOfCards
        }
        
        guard Set(self).count == Trio.cardsRequired else {
            throw PerceptionError.uniqueCards
        }
        
        guard map(\.number).allEqualOrAllUnique else {
            throw PerceptionError.numberAttribute
        }
        
        guard map(\.fill).allEqualOrAllUnique else {
            throw PerceptionError.fillAttribute
        }
        
        guard map(\.color).allEqualOrAllUnique else {
            throw PerceptionError.colorAttribute
        }
        
        guard map(\.shape).allEqualOrAllUnique else {
            throw PerceptionError.shapeAttribute
        }
    }
}
