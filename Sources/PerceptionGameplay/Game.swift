import Perception

public protocol Game {
    /// Prepares the game to be played.
    /// All card are returned to the deck and randomized.
    func shuffle()
    
    /// Ready the game for play.
    /// Cards are drawn from the deck until the board is in a playable state.
    ///
    /// - throws Game errors (primarily 'game-over' indications).
    func deal() throws
    
    /// Processes a card.
    func play(_ card: Card) throws
}
