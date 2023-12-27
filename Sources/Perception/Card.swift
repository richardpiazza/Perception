import Foundation

public struct Card: Hashable, Codable {
    
    public let number: Number
    public let fill: Fill
    public let color: Color
    public let shape: Shape
    
    public init(
        number: Number = .random,
        fill: Fill = .random,
        color: Color = .random,
        shape: Shape = .random
    ) {
        self.number = number
        self.fill = fill
        self.color = color
        self.shape = shape
    }
}

extension Card: Identifiable {
    public var id: String {
        [
            number.rawValue,
            fill.rawValue,
            color.rawValue,
            shape.rawValue
        ]
            .joined(separator: ",")
    }
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
