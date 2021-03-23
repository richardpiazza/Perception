import XCTest
@testable import Perception
@testable import PerceptionGameplay

final class TraditionalGameTests: XCTestCase {
    
    static var allTests = [
        ("testShuffle", testShuffle),
        ("testDeal", testDeal),
        ("testDeal_gameOverConditions", testDeal_gameOverConditions),
        ("testDeal_invalidInitialDeal", testDeal_invalidInitialDeal),
        ("testPlay", testPlay),
        ("testReshuffleDiscard", testReshuffleDiscard),
    ]
    
    let game = TraditionalGame()
    
    // Taken from [Card].validBoard_3Triads
    let triad2 = try! Triad([
        .init(number: .two, fill: .outlined, color: .dark, shape: .star),
        .init(number: .two, fill: .solid, color: .dark, shape: .star),
        .init(number: .two, fill: .shaded, color: .dark, shape: .star),
    ])
    
    // Taken from [Card].validBoard_3Triads
    let triad3 = try! Triad([
        .init(number: .one, fill: .outlined, color: .medium, shape: .circle),
        .init(number: .one, fill: .outlined, color: .dark, shape: .star),
        .init(number: .one, fill: .outlined, color: .light, shape: .square),
    ])
    
    func testShuffle() {
        game.shuffle()
        
        XCTAssertEqual(game.deck.count, 81)
        XCTAssertEqual(game.board.count, 0)
        XCTAssertEqual(game.discard.count, 0)
        XCTAssertEqual(game.selected.count, 0)
    }
    
    func testDeal() throws {
        game.shuffle()
        try game.deal()
        
        XCTAssertEqual(game.deck.count, 69)
        XCTAssertEqual(game.board.count, 12)
        XCTAssertEqual(game.discard.count, 0)
        XCTAssertEqual(game.selected.count, 0)
        
        XCTAssertNoThrow(try game.deal())
    }
    
    func testDeal_gameOverConditions() throws {
        game.deck = []
        game.board = .validBoard_3Triads
        
        // Empty Deck, Playable triads
        XCTAssertNoThrow(try game.deal())
        
        try game.play(triad2.first)
        try game.play(triad2.second)
        try game.play(triad2.third)
        
        // Empty Deck, Playable triads
        XCTAssertNoThrow(try game.deal())
        
        try game.play(triad3.first)
        try game.play(triad3.second)
        try game.play(triad3.third)
        
        // Empty Deck, No Plays Available
        XCTAssertThrowsError(try game.deal()) { (error) in
            guard let gameError = error as? TraditionalGame.Error else {
                return XCTFail("Unexpected Error")
            }
            
            guard case .gameOver = gameError else {
                return XCTFail("Unexpected Error")
            }
        }
    }
    
    func testDeal_invalidInitialDeal() {
        var cards: [Card] = []
        cards.append(contentsOf: [Card].invalidBoard_0Triads_requiresAdditionalDeal)
        cards.append(contentsOf: [Card].invalidBoard_0Triads_nextDeal)
        XCTAssertEqual(Set(cards).count, 15)
        XCTAssertFalse(Triad.triads(in: cards).isEmpty)
        
        game.deck = cards
        XCTAssertNoThrow(try game.deal())
        
        XCTAssertEqual(game.deck.count, 0) // 66 if playing with real deck
        XCTAssertEqual(game.board.count, 15)
        XCTAssertEqual(game.discard.count, 0)
        XCTAssertEqual(game.selected.count, 0)
    }
    
    func testDeal_doubleInvalidDeal() {
        game.deck = .invalidBoard_requires2Deals
        XCTAssertNoThrow(try game.deal())
        XCTAssertEqual(game.board.count, 18)
    }
    
    func testPlay() throws {
        game.deck = .validBoard_3Triads_remainingDeck
        game.board = .validBoard_3Triads
        
        XCTAssertEqual(game.deck.count, 69)
        XCTAssertEqual(game.board.count, 12)
        XCTAssertEqual(game.discard.count, 0)
        XCTAssertEqual(game.selected.count, 0)
        
        let invalid: Card = .init(number: .one, fill: .outlined, color: .light, shape: .circle)
        XCTAssertThrowsError(try game.play(invalid)) { (error) in
            guard let gameError = error as? TraditionalGame.Error else {
                return XCTFail("Unexpected Error")
            }
            
            guard case .cardNotPlayable = gameError else {
                return XCTFail("Unexpected Error")
            }
        }
        
        try game.play(triad2.first)
        XCTAssertEqual(game.selected.count, 1)
        try game.play(triad2.first)
        XCTAssertEqual(game.selected.count, 0)
        try game.play(triad2.first)
        try game.play(triad2.second)
        XCTAssertEqual(game.selected.count, 2)
        
        XCTAssertThrowsError(try game.play(triad3.third)) { (error) in
            XCTAssertEqual(error as? Triad.Error, .numberAttribute)
        }
        
        try game.play(triad2.first)
        try game.play(triad2.second)
        try game.play(triad2.third)
        
        XCTAssertEqual(game.deck.count, 69)
        XCTAssertEqual(game.board.count, 9)
        XCTAssertEqual(game.discard.count, 3)
        XCTAssertEqual(game.selected.count, 0)
        
        try game.deal()
        
        XCTAssertEqual(game.deck.count, 66)
        XCTAssertEqual(game.board.count, 12)
        XCTAssertEqual(game.discard.count, 3)
        XCTAssertEqual(game.selected.count, 0)
    }
    
    func testReshuffleDiscard() throws {
        game.deck = .validBoard_3Triads_remainingDeck
        game.board = .validBoard_3Triads
        
        XCTAssertEqual(game.deck.count, 69)
        XCTAssertEqual(game.board.count, 12)
        XCTAssertEqual(game.discard.count, 0)
        XCTAssertEqual(game.selected.count, 0)
        
        try game.play(triad2.first)
        try game.play(triad2.second)
        try game.play(triad2.third)
        
        XCTAssertEqual(game.deck.count, 69)
        XCTAssertEqual(game.board.count, 9)
        XCTAssertEqual(game.discard.count, 3)
        XCTAssertEqual(game.selected.count, 0)
        
        game.reshuffleDiscard()
        
        XCTAssertEqual(game.deck.count, 72)
        XCTAssertEqual(game.board.count, 9)
        XCTAssertEqual(game.discard.count, 0)
        XCTAssertEqual(game.selected.count, 0)
        
        try game.deal()
        
        XCTAssertEqual(game.deck.count, 69)
        XCTAssertEqual(game.board.count, 12)
        XCTAssertEqual(game.discard.count, 0)
        XCTAssertEqual(game.selected.count, 0)
    }
}
