//
//  QuoteCardView.swift
//  CustomCardsApp
//
//  Created by Mihajlo Mit on 2021-06-13.
//

import SwiftUI

var quoteCategories = ["Motivational", "Entreprenurial", "Religious", "Funny", "Love", "Happiness"]

struct QuotesCardView: View {
    let card: Card
    let quote: Quote = placeholderQuote
    
    var body: some View {
        ZStack {
            ExpandedView()
            VStack(alignment: .center, spacing: 10) {
                Spacer()
                HStack {
                    Text("\"").font(.system(size: 55))
                    Spacer()
                }.padding(.bottom, -40)
                Text(quote.quote).font(.system(size: 25))
                    .lineLimit(5).minimumScaleFactor(0.7)
                Text(quote.author).font(.headline)
                Spacer()
            }.foregroundColor(card.TextColor.color()).padding(.top, -15).padding(.horizontal, 15)
        }.background(card.Background.color())
    }
}

struct Quote: Encodable, Decodable {
    var quote: String
    var author: String
    var category: String
}
let placeholderQuote = Quote(quote: "An awesome quote here.", author: "Mihajlo Mitrovic", category: "Motivational")
