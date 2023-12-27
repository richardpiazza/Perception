import Foundation

public extension Card {
    enum Number: String, CaseIterable, Equatable, Codable, CustomStringConvertible {
        case one
        case two
        case three
        
        public static var random: Number { allCases.randomElement()! }
        public var description: String { rawValue.capitalized }
    }

    enum Fill: String, CaseIterable, Equatable, Codable, CustomStringConvertible {
        case outlined
        case shaded
        case solid
        
        public static var random: Fill { allCases.randomElement()! }
        public var description: String { rawValue.capitalized }
    }
    
    enum Color: String, CaseIterable, Equatable, Codable, CustomStringConvertible {
        case light
        case medium
        case dark
        
        public static var random: Color { allCases.randomElement()! }
        public var description: String { rawValue.capitalized }
    }
    
    enum Shape: String, CaseIterable, Equatable, Codable, CustomStringConvertible {
        case circle
        case square
        case star
        
        public static var random: Shape { allCases.randomElement()! }
        public var description: String { rawValue.capitalized }
    }
}

public extension Array where Element == Card.Number {
    var allEqual: Bool { Set(self).count == 1 }
    var allUnique: Bool { Set(self).count == count }
    var allEqualOrAllUnique: Bool { allEqual || allUnique }
}

public extension Array where Element == Card.Fill {
    var allEqual: Bool { Set(self).count == 1 }
    var allUnique: Bool { Set(self).count == count }
    var allEqualOrAllUnique: Bool { allEqual || allUnique }
}

public extension Array where Element == Card.Color {
    var allEqual: Bool { Set(self).count == 1 }
    var allUnique: Bool { Set(self).count == count }
    var allEqualOrAllUnique: Bool { allEqual || allUnique }
}

public extension Array where Element == Card.Shape {
    var allEqual: Bool { Set(self).count == 1 }
    var allUnique: Bool { Set(self).count == count }
    var allEqualOrAllUnique: Bool { allEqual || allUnique }
}
