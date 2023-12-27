import Perception

public class InfiniteGame: TraditionalGame {
    public override func deal() throws {
        reshuffleDiscard()
        try super.deal()
    }
}
