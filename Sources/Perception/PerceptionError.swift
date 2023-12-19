public enum PerceptionError: Error {
    /// The count of `Card` provided did not match expectations (typically `Trio.cardsRequired`).
    case numberOfCards
    /// The `Set<Card>` provided did not match expectations (typically `Trio.cardsRequired`).
    case uniqueCards
    /// An invalid `Card.Number` attribute was encountered.
    case numberAttribute
    /// An invalid `Card.Fill` attribute was encountered.
    case fillAttribute
    /// An invalid `Card.Color` attribute was encountered.
    case colorAttribute
    /// An invalid `Card.Shape` attribute was encountered.
    case shapeAttribute
}
