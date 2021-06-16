//
//  ContentView.swift
//  CustomCardsApp
//
//  Created by Mihajlo Mit on 2021-06-01.
//

import SwiftUI

// App-wide Variables
let cardWidth = UIScreen.screenWidth-35
let placeholderCard = Card(type: CardType.moonPhases.rawValue, textColor: "#000000", background: "#ffffff")
let secondaryCard = Card(type: CardType.moonPhases.rawValue, textColor: "#ffffff", background: "#e67e22")
let mainColor = "#4b7bec".color()
var appInitialized = userDefaults.bool(forKey: "appInitialized")

/** The main view loaded immediately as the app opens. Hosts the "home" page. */
struct ContentView: View {
    @State var smc: SunMoonCalculator? = nil
    @State var cards: [Card] = Save.decodeCards()
    @State var sheet: Int?
    @State var showIntro = false
    
    var body: some View {
        ZStack {
            VStack {
                LinearGradient(gradient: Gradient(colors: [mainColor, Color(UIColor.systemBackground)]), startPoint: .top, endPoint: .bottom).frame(width: UIScreen.screenWidth, height: 250).offset(x: 0, y: -50)
                Spacer()
            }.background(Color(UIColor.systemBackground)).edgesIgnoringSafeArea(.top)
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
                        if cards.count == 0 && appInitialized == false { // Show 5 placeholder cards if no cards available
                            ForEach(0..<5) { i in
                                PlaceholderCardView().frame(width: cardWidth, height: cardWidth/1.8).cornerRadius(12)
                            }
                        } else {
                            ForEach(cards.indices, id: \.self) { i in
                                CardView(card: cards[i]).background(Color.white.opacity(0.12)).frame(width: cardWidth, height: cardWidth/1.8).cornerRadius(12).onTapGesture {
                                    sheet = 100 + (i + 1)
                                }
                            }
                        }
                        footerView
                    }.padding(.bottom, 15).padding(.top, 5)
                }.padding(.horizontal, (UIScreen.screenWidth-cardWidth)/2).frame(width: UIScreen.screenWidth)
            }
            IntroPopupViewLogic(show: $showIntro, sheet: $sheet)
        }.sheet(item: $sheet) { item in
            if item == 1 { // Edit view
                EditCardView(cards: $cards)
            } else if item >= 100 {
                // If the sheet presented is greater than 100, that means that the user is looking to edit
                // a card at the index of item-100
                AddCardView(cards: $cards, index: item-100)//.onAppear() { editCard = 0 }
            } else if item == 0 {
                AddCardView(cards: $cards, index: 0)
            }
        }.onAppear() {
            showIntroView()
        }
    }
    
    var footerView: some View {
        HStack(alignment: .center, spacing: 30) {
            Image("logo").resizable().scaledToFit().frame(width: 45, height: 45)
            VStack(alignment: .leading) {
                Text("Cards - V1.0.0").font(.headline)
                Text("By Mihajlo M.").opacity(0.7)
                Text("ICS 4U - Mr. Tedesco").opacity(0.7)
            }
        }.padding(.vertical, 20)
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
    
    /** If user hasent initialized the app, show welcome message */
    func showIntroView() {
        if appInitialized != true {
            showIntro.toggle()
        }
    }
}

// Helper extensions
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
