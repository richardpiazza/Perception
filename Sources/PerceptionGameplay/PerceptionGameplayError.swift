import Perception

public enum PerceptionGameplayError: Error {
    /// The `Game` being played arrived at its termination conditions.
    case gameOver
    /// The number of requested `Card` to be dealt exceeds the number of `Card` available to be dealt.
    case deal(cardsRequested: Int, cardsAvailable: Int)
    /// The `Card` played was not valid to be played in current conditions.
    case cardNotPlayable(Card)
}
