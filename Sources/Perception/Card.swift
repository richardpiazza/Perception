import Foundation

public struct Card: Hashable, Codable {
    
    public let number: Number
    public let fill: Fill
    public let color: Color
    public let shape: Shape
    
    public init(number: Number = .random, fill: Fill = .random, color: Color = .random, shape: Shape = .random) {
        self.number = number
        self.fill = fill
        self.color = color
        self.shape = shape
    }
}

extension Card: Identifiable {
    public var id: String { [number.rawValue, fill.rawValue, color.rawValue, shape.rawValue].joined(separator: ",") }
}

extension Card: CustomStringConvertible {
    // TODO: Pluralize where needed
    public var description: String { "\(number) \(fill) \(color) \(shape)" }
}

extension Card: CustomDebugStringConvertible {
    public var debugDescription: String {
        """
        Card:
            - number: \(number)
            -   fill: \(fill)
            -  color: \(color)
            -  shape: \(shape)
        """
    }
}

public extension Card {
    static func makeDeck() -> [Card] {
        var cards: [Card] = [Card]()
        
        Card.Number.allCases.forEach { (number) in
            Card.Fill.allCases.forEach { (fill) in
                Card.Color.allCases.forEach { (color) in
                    Card.Shape.allCases.forEach { (shape) in
                        cards.append(Card(number: number, fill: fill, color: color, shape: shape))
                    }
                }
            }
        }
        
        return cards
    }
}
