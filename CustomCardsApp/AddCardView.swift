//
//  AddCardView.swift
//  CustomCardsApp
//
//  Created by Mihajlo Mit on 2021-06-09.
//

import SwiftUI

let appTitleFont = Font.system(size: 24, weight: .semibold)
let colors = ["#000000", "#ffffff", "#2ecc71", "#9b59b6", "#f1c40f"]

struct AddCardView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var cards: [Card]
    @State var currentCard: Card = placeholderCard
    var index: Int
    
    var body: some View {
        ZStack {
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 25) {
                        Text("Create Your Card").font(appTitleFont)
                        previewCard
                        cardTypeView
                        textColorPicker
                        backgroundColorPicker
                        
                        Spacer()
                    }.padding(.vertical, 45).padding(.bottom, 15)
                }
            }.padding(.horizontal, 15)
            VStack {
                Spacer()
                Button(action: {
                    if index == 0 { // Add card
                        cards.insert(currentCard, at: 0)
                    } else { // Replace card
                        cards[index-1] = currentCard
                    }
                    
                    Save.saveCards(cards) {
                        print("Done!")
                        presentationMode.wrappedValue.dismiss() // Dismiss view
                    }
                }) {
                    Text("Add Card")
                }.buttonStyle(MultiColoredLargeButtonStyle()).padding(.bottom, 8)
            }
            ClosureIndicator()
        }.navigationBarHidden(true)
    }
    
    //MARK: Card Type Segment --------------------------
    
    // Select the different card types
    var cardTypeView: some View {
        VStack(alignment: .leading) {
            Text("Card Type").font(.headline)
            ForEach(cardCategories.indices, id: \.self) { i in
                Button(action: {
                    currentCard = editCard(type: cardCategories[i].id)
                }) {
                    VStack(alignment: .leading) {
                        HStack(spacing: 15) {
                            cardCategories[i].icon.resizable().frame(width: 20, height: 20)
                            Text(cardCategories[i].name).font(.title3)
                            Spacer()
                            Image(systemName: currentCardType(i) ? "checkmark" : "chevron.down").font(.system(size: 23))
                        }.padding(.vertical, 8).opacity(currentCardType(i) ? 1 : 0.5)
                        
                        if currentCardType(i) { // Card selected
                            Text(cardCategories[i].description).padding(.bottom, 15)
                        }
                        
                        Divider()
                    }.animation(.spring())
                }.foregroundColor(.white)
            }
        }
    }
    
    func currentCardType(_ index: Int) -> Bool {
        return cardCategories[index].id == currentCard.CardType
    }
    
    func editCard(type: Int? = nil, textColor: String? = nil, backgroundColor: String? = nil) -> Card {
        let Type = type ?? currentCard.CardType
        let TextColor = textColor ?? currentCard.TextColor
        let BackgroundColor = backgroundColor ?? currentCard.Background
        
        return Card(type: Type, textColor: TextColor, background: BackgroundColor)
    }
    
    //MARK: Card Preview Segment --------------------------
    
    var previewCard: some View {
        VStack(alignment: .leading) {
            Text("Preview").font(.headline).padding(.bottom, 3)
            CardView(card: currentCard).background(Color.white.opacity(0.12)).frame(width: cardWidth, height: cardWidth/1.8).cornerRadius(12)
        }
    }
    
    //MARK: Card Color Picker Segment --------------------------
    var textColorPicker: some View {
        VStack(alignment: .leading) {
            Text("Text Color").font(.headline).padding(.bottom, 3)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(colors.indices, id: \.self) { i in
                        CustomColorItem(color: colors[i], selectedColor: currentCard.TextColor).onTapGesture {
                            currentCard = editCard(textColor: colors[i])
                        }
                    }
                }.padding(.horizontal, 20)
            }.padding(.horizontal, -15)
        }
    }
    
    var backgroundColorPicker: some View {
        VStack(alignment: .leading) {
            Text("Background Color").font(.headline).padding(.bottom, 3)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(colors.indices, id: \.self) { i in
                        CustomColorItem(color: colors[i], selectedColor: currentCard.Background).onTapGesture {
                            currentCard = editCard(backgroundColor: colors[i])
                        }
                    }
                }.padding(.horizontal, 20)
            }.padding(.horizontal, -15)
        }
    }
    
}

//struct AddCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddCardView(cards: .constant([]))
//    }
//}

struct CardTypeClass {
    var icon: Image
    var id: Int
    var name: String
    var description: String
}

var cardCategories = [
    CardTypeClass(icon: Image(systemName: "moon.fill"), id: CardType.moonPhases.rawValue, name: "Moon Phases", description: "Follow the phases of the moon."),
    CardTypeClass(icon: Image(systemName: "person.2.circle.fill"), id: CardType.contacts.rawValue, name: "Contacts", description: "Quickly call or message your most frequent contacts."),
]

struct MultiColoredLargeButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(mainColor)
            .font(.headline)
            .frame(width: UIScreen.screenWidth-60, height: 45)
            .background(mainColor.opacity(0.2))
            .background(Color(UIColor.systemBackground))
            .cornerRadius(12)
            .scaleEffect(configuration.isPressed ? 0.95: 1)
            .animation(.spring())
    }
}

struct CustomColorItem: View {
    let color: String
    let selectedColor: String
    
    var body: some View {
        VStack {
            if selectedColor == color { // Current color selected
                colorBlock
                    .padding(3.5).background(Color(UIColor.systemBackground)).cornerRadius(14.5)
                    .padding(2.5).background(mainColor).cornerRadius(15)
            } else {
                colorBlock
            }
        }
    }
    
    var colorBlock: some View {
        Rectangle().fill(color.color()).frame(width: 45, height: 45).cornerRadius(12).padding(1).background(Color(UIColor.systemGray3).cornerRadius(13))
    }
}
