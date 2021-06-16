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
    var Contacts: [Contact]
    var QuoteCategory: String
    
    init(type: Int, textColor: String, background: String, contacts: [Contact] = [], quoteCategory: String = quoteCategories[0]) {
        self.CardType = type
        self.TextColor = textColor
        self.Background = background
        self.Contacts = contacts
        self.QuoteCategory = quoteCategory
    }
}

struct Contact: Encodable, Decodable {
    var id: String
    var name: String
    var phoneNumber: String?
    var email: String?
    var imageData: Data?
}

enum CardType: Int {
    case moonPhases = 0
    case contacts = 1
    case quotes = 2
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
    
    func contactsImage(_ i: Int) -> UIImage {
        if self.Contacts[i].imageData != nil {
            let image = UIImage(data: self.Contacts[i].imageData!)
            return image! //?? CustomContactsIcon(name: self.Contacts[i].name).asImage()!
        } else {
            print("nil image")
            return UIImage(named: "moon")!//CustomContactsIcon(name: self.Contacts[i].name).asImage()!
        }
    }
    
}

extension String {
    /** Convert HEX color to SwiftUI Color */
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

extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
    
    func asImage() -> UIImage? {
        let controller = UIHostingController(rootView: self)
        
        // locate far out of screen
        controller.view.frame = CGRect(x: 0, y: CGFloat(Int.max), width: 1, height: 1)
        UIApplication.shared.windows.first!.rootViewController?.view.addSubview(controller.view)
        
        let size = controller.sizeThatFits(in: UIScreen.main.bounds.size)
        controller.view.bounds = CGRect(origin: .zero, size: size)
        controller.view.sizeToFit()
        
        let image = controller.view.asImage()
        controller.view.removeFromSuperview()
        return image
    }
}

extension UIView {

    func asImage() -> UIImage? {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: bounds)
            return renderer.image { rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
        } else {
            UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0.0)
            defer { UIGraphicsEndImageContext() }
            guard let currentContext = UIGraphicsGetCurrentContext() else {
                return nil
            }
            self.layer.render(in: currentContext)
            return UIGraphicsGetImageFromCurrentImageContext()
        }
    }
}


// MARK: Category Card Class
struct CardTypeClass {
    var icon: Image
    var id: Int
    var name: String
    var description: String
}

// Different card types + description to be used in-app. Allows easily adding new cards - as I plan to do.
var cardCategories = [
    CardTypeClass(icon: Image(systemName: "moon.fill"), id: CardType.moonPhases.rawValue, name: "Moon Phases", description: "Follow the phases of the moon."),
    CardTypeClass(icon: Image(systemName: "person.2.circle.fill"), id: CardType.contacts.rawValue, name: "Contacts", description: "Quickly call or message your most frequent contacts."),
    CardTypeClass(icon: Image(systemName: "quote.bubble.fill"), id: CardType.quotes.rawValue, name: "Quotes", description: "View changing quotes from certain categories."),
    CardTypeClass(icon: Image(systemName: "calendar"), id: CardType.calendar.rawValue, name: "Calendar", description: "A digital calendar."),
]
