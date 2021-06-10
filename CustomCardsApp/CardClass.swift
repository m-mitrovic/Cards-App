//
//  CardClass.swift
//  CustomCardsApp
//
//  Created by Mihajlo Mit on 2021-06-01.
//

import UIKit
import SwiftUI

// Initialize Card Class
class Card: Encodable, Decodable {
    var CardType: Int
    var TextColor: String
    var Background: String
    
    init(type: Int, textColor: String, background: String) {
        self.CardType = type
        self.TextColor = textColor
        self.Background = background
    }
}

enum CardType: Int {
    case moonPhases = 0
    case contacts = 1
    case motivational = 2
    case calendar  = 3
}

extension Card {
    
    var cardTypeName: String {
        if self.CardType == 0 {
            return "Moon Phases Card"
        } else if self.CardType == 1 {
            return "Contacts Card"
        } else if self.CardType == 2 {
            return "Motivational Quotes Card"
        } else {
            return "Calendar Card"
        }
    }
    
}

extension String {
    // Convert HEX color to SwiftUI Color
     func color() -> Color {
        var cString:String = "\(self)".trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return Color.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return Color(
            red: Double((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: Double((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: Double(rgbValue & 0x0000FF) / 255.0
        )
    }
}

func savedCards() -> [Card] {
    return [placeholderCard, placeholderCard, placeholderCard, placeholderCard, secondaryCard]
}
