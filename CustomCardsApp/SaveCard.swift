//
//  SaveCard.swift
//  CustomCardsApp
//
//  Created by Mihajlo Mit on 2021-06-09.
//

import UIKit

let userDefaults = UserDefaults()

// Save the card configurations to the user's device so that way when they refresh the app, their data is still maintained.
class Save {
    
    /** Save the cards to the users permanent device data */
    static func saveCards(_ cards: [Card], onCompletion: @escaping () -> Void) {
        let wait = DispatchGroup()
        var encodedCards: [Data] = []
        
        for i in 0..<cards.count {
            wait.enter()
            do {
                let jsonData = try JSONEncoder().encode(cards[i])
                encodedCards.append(jsonData)
                wait.leave()
            } catch {
                print("Error saving card.")
            }
        }
        
        wait.notify(queue: DispatchQueue.main) { // All cards successfully encoded & added to the array
            userDefaults.setValue(encodedCards, forKey: "cards")
            onCompletion()
            print("All cards permanently saved")
        }
    }
    
    /** Decode the cards from the users permanent storage to the `Card` class*/
    static func decodeCards() -> [Card] {
        if let cardsArray = userDefaults.object(forKey: "cards") as? [Data] {
            var finalArray: [Card] = []
            for i in 0..<cardsArray.count {
                do {
                    let card = try JSONDecoder().decode(Card.self, from: cardsArray[i])
                    finalArray.append(card)
                } catch {
                    print("Error decoding")
                }
            }
            return finalArray
        } else {
            return [placeholderCard]
        }
    }
    

    
}
