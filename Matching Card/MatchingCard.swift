//
//  MatchingCard.swift
//  Matching Card
//
//  Created by Django on 2019/3/31.
//  Copyright © 2019 Caner Ates. All rights reserved.
//

import Foundation

struct MatchingCard
{
    private(set) var cards = [Card]()
    var matches = 0
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
            //            var foundIndex: Int?
            //            for index in cards.indices {
            //                if cards[index].isFaceUp {
            //                    if foundIndex == nil {
            //                        foundIndex = index
            //                    } else {
            //                        return nil
            //                    }
            //                }
            //            }
            //            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
                //if index == newValue { cards[index].isFaceUp = true }
                //else {cards[index].isFaceUp = false}
            }
        }
    }
    
    mutating func chooseCard(at index: Int){
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    matches += 1
                }
                cards[index].isFaceUp = true
            } else {
                //either no cards or 2 cards are face up
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int){
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of")
        var tempCards = [Card]()
        for _ in 1...numberOfPairsOfCards{
            let card = Card()
            tempCards += [card, card]
        }
        for _ in tempCards {
            let randomIndex = tempCards.count.arc4random
            let randomCard = tempCards[randomIndex]
            cards.append(randomCard)
            tempCards.remove(at: randomIndex)
        }
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
