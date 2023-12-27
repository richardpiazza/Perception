import Perception

public protocol Game {
    /// Prepares the `Game` to be played.
    ///
    /// All `Card`s are returned to the deck and randomized.
    func shuffle()
    
    /// Ready the _board_ for continued play.
    ///
    /// Cards are drawn from the deck until the board is in a playable state.
    ///
    /// - throws `PerceptionGameplayError` (primarily 'game-over' indications).
    func deal() throws
    
    /// Processes a `Card`.
    func play(_ card: Card) throws
}

public extension Game {
    /// Return the `Game` to an initial playable state by _shuffling_ (`shuffle()`) and _dealing_ (`deal()`).
    func restart() throws {
        shuffle()
        try deal()
    }
}
