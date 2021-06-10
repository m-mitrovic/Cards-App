//
//  ContentView.swift
//  CustomCardsApp
//
//  Created by Mihajlo Mit on 2021-06-01.
//

import SwiftUI

let cardWidth = UIScreen.screenWidth-35
let placeholderCard = Card(type: CardType.moonPhases.rawValue, textColor: "#000000", background: "#ffffff")
let secondaryCard = Card(type: CardType.moonPhases.rawValue, textColor: "#ffffff", background: "#e67e22")
let mainColor = Color(UIColor.systemPink)

struct ContentView: View {
    @State var smc: SunMoonCalculator? = nil
    @State var cards: [Card] = Save.decodeCards()
    @State var sheet: Int?
    
    var body: some View {
        ZStack {
            VStack {
                LinearGradient(gradient: Gradient(colors: [mainColor, Color.black]), startPoint: .top, endPoint: .bottom).frame(width: UIScreen.screenWidth, height: 250).offset(x: 0, y: -50)
                Spacer()
            }.background(Color.black).edgesIgnoringSafeArea(.top)
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    Text(greetingTitle).font(appTitleFont).padding(.vertical, 15)
                    HStack {
                        Text("Today's Brief").font(.headline)
                        Spacer()
                        Button(action: {
                            sheet = 1
                        }) {
                            Text("Edit")
                        }.buttonStyle(CustomSmallRoundedButtonStyle())
                    }
                    VStack(spacing: 15) {
                        ForEach(cards.indices, id: \.self) { i in
                            //Rectangle().fill(Color.white.opacity(0.12)).frame(width: cardWidth, height: cardWidth/1.8).cornerRadius(12)
                            CardView(card: cards[i]).background(Color.white.opacity(0.12)).frame(width: cardWidth, height: cardWidth/1.8).cornerRadius(12)
                        }
                    }.padding(.bottom, 15).padding(.top, 5)
                }.padding(.horizontal, (UIScreen.screenWidth-cardWidth)/2).frame(width: UIScreen.screenWidth)
            }
        }.sheet(item: $sheet) { item in
            if item == 1 { // Edit view
                EditCardView(cards: $cards)
            } else {
                AddCardView(cards: $cards, index: 0)
            }
        }
    }
    
    /**
     Time dependant messages (such as "Good Morning", "Good Evening", "Good Afternoon"
     */
    var greetingTitle: String {
        let hour = Int(Date().hour)!
        let pmOrAm = Date().A
        if (hour == 12 || hour >= 1) && hour < 6 && pmOrAm == "PM" {
            return "Good Afternoon"
        } else if hour >= 6 && pmOrAm == "PM" {
            return "Good Evening"
        } else {
            return "Good Morning"
        }
    }
    
    init() {
        UINavigationBar.appearance().tintColor = UIColor(mainColor)
    }
}

extension Date {
    var hour: String {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "h"
        let stringDate = timeFormatter.string(from: self)
        return stringDate.uppercased()
    }
    
    // pm or am
    var A: String {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "a"
        let stringDate = timeFormatter.string(from: self)
        return stringDate.uppercased()
    }
}

struct CustomSmallRoundedButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 21)
            .padding(.vertical, 6)
            .foregroundColor(Color.black)
            .background(Capsule().fill(Color.white))
            .font(.headline)
            .scaleEffect(configuration.isPressed ? 0.95: 1)
            .animation(.spring())
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension UIScreen {
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

extension Int: Identifiable {
    public var id: Int { self }
}
