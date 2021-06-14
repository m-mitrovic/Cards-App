//
//  AddCardView.swift
//  CustomCardsApp
//
//  Created by Mihajlo Mit on 2021-06-09.
//

import SwiftUI
import Contacts

let appTitleFont = Font.system(size: 24, weight: .semibold)
let colors = ["#000000", "#ffffff", "#48dbfb", "#54a0ff", "#5f27cd", "#a55eea", "#ff9ff3", "#ff6b6b", "#eb3b5a", "#ff0000", "#e84118", "#f0932b", "#feca57", "#1dd1a1", "#079992", "#2f3542", "#747d8c", "#dfe4ea"]

struct AddCardView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var cards: [Card]
    @State var currentCard: Card = placeholderCard
    var index: Int
    @State var sheetItem: Int?
    
    var body: some View {
        ZStack {
            VStack {
                previewCard.padding(.top, 45)
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 25) {
                        Text(index == 0 ? "Create A Card" : "Edit Your Card").font(appTitleFont)
                        cardTypeView
                        textColorPicker
                        backgroundColorPicker
                        
                        if currentCard.CardType == CardType.contacts.rawValue {
                            contactsPicker
                        }
                        
                        if currentCard.CardType == CardType.quotes.rawValue {
                            quoteCategoryPicker
                        }
                        Spacer()
                    }.padding(.vertical, 25).padding(.bottom, 40).padding(.horizontal, 15)
                }
            }
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
                    Text(index == 0 ? "Add Card" : "Save Changes")
                }.buttonStyle(MultiColoredLargeButtonStyle()).padding(.bottom, 8)
            }
            ClosureIndicator()
        }.navigationBarHidden(true).sheet(item: $sheetItem) { item in
            if item == 1 {
                ContactPicker(showPicker: .constant(true), onSelectContact: { contacts in
                    let contactClass = Contact(id: contacts.identifier, name: contacts.givenName, phoneNumber: contacts.phoneNumbers[0].value.formatPhoneNumberAsDigits(), imageData: contacts.thumbnailImageData)
                   
                    var array = currentCard
                    array.Contacts.append(contactClass)
                    currentCard = editCard(contacts: array.Contacts)
                })
            }
        }.onAppear() {
            if index != 0 {
                currentCard = cards[index-1]
            }
        }
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
    
    func editCard(type: Int? = nil, textColor: String? = nil, backgroundColor: String? = nil, contacts: [Contact]? = nil, quoteCategory: String? = nil) -> Card {
        let Type = type ?? currentCard.CardType
        let TextColor = textColor ?? currentCard.TextColor
        let BackgroundColor = backgroundColor ?? currentCard.Background
        let Contacts = contacts ?? currentCard.Contacts
        let QuoteCategory = quoteCategory ?? currentCard.QuoteCategory
        
        return Card(type: Type, textColor: TextColor, background: BackgroundColor, contacts: Contacts, quoteCategory: QuoteCategory)
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
    
    
    //MARK: CUSTOM CARD PICKERS
    var contactsPicker: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Contacts").font(.headline).padding(.bottom, 3)
                Spacer()
                
                Button(action: {
                    sheetItem = 1
                }) {
                    Text("Add contact")
                }.buttonStyle(CustomSmallRoundedButtonStyle())
            }
            
            VStack(spacing: 8) {
                ForEach(currentCard.Contacts.indices, id: \.self) { i in
                    HStack {
                        Text(currentCard.Contacts[i].name)
                        Spacer()
                        Button(action: {
                            var array = currentCard
                            array.Contacts.remove(at: i)
                            currentCard = editCard(contacts: array.Contacts)
                        }) {
                            Image(systemName: "trash")
                                .font(.system(size: 20))
                                .padding(5)
                                .foregroundColor(.white)
                                .background(Circle().fill(Color.red))
                        }
                    }.padding(.vertical, 4)
                    Divider()
                }
            }
        }
    }
    
    //MARK: QUOTE CATEGORY PICKER
    var quoteCategoryPicker: some View {
        VStack(alignment: .leading) {
            Text("Quote Category").font(.headline).padding(.bottom, 3)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(quoteCategories.indices, id: \.self) { i in
                        CustomTextItem(text: quoteCategories[i], selectedText: currentCard.QuoteCategory).onTapGesture {
                            currentCard = editCard(quoteCategory: quoteCategories[i])
                        }
                    }
                }.padding(.horizontal, 20)
            }.padding(.horizontal, -15)
        }
    }
}

struct CardTypeClass {
    var icon: Image
    var id: Int
    var name: String
    var description: String
}

var cardCategories = [
    CardTypeClass(icon: Image(systemName: "moon.fill"), id: CardType.moonPhases.rawValue, name: "Moon Phases", description: "Follow the phases of the moon."),
    CardTypeClass(icon: Image(systemName: "person.2.circle.fill"), id: CardType.contacts.rawValue, name: "Contacts", description: "Quickly call or message your most frequent contacts."),
    CardTypeClass(icon: Image(systemName: "quote.bubble.fill"), id: CardType.quotes.rawValue, name: "Quotes", description: "View changing quotes from certain categories."),
    CardTypeClass(icon: Image(systemName: "calendar"), id: CardType.calendar.rawValue, name: "Calendar", description: "A digital calendar."),
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

struct CustomTextItem: View {
    let text: String
    let selectedText: String
    
    var body: some View {
        VStack {
            textBlock
        }
    }
    
    var textBlock: some View {
        VStack {
            Text(text).font(.headline)
        }.frame(height: 35).padding(.horizontal, 20).background(text == selectedText ? mainColor : Color(UIColor.systemGray5)).cornerRadius(35/2)
    }
}

/** Custom function to remove the styling on the phone number. Example: (905) 123-2144    turns to ->     9051232144 */
extension CNPhoneNumber {
    func formatPhoneNumberAsDigits() -> String {
        var phoneNumber = self.stringValue
        phoneNumber = phoneNumber.replacingOccurrences(of: "(", with: "")
        phoneNumber = phoneNumber.replacingOccurrences(of: ")", with: "")
        phoneNumber = phoneNumber.replacingOccurrences(of: " ", with: "")
        phoneNumber = phoneNumber.replacingOccurrences(of: "-", with: "")
        return phoneNumber
    }
}
