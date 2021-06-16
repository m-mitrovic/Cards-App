//
//  QuoteCardView.swift
//  CustomCardsApp
//
//  Created by Mihajlo Mit on 2021-06-13.
//

import SwiftUI

var quoteCategories = ["Motivational", "Entreprenurial", "Religious", "Funny", "Love", "Happiness"]
var cachedQuote: Quote? = nil

struct QuotesCardView: View {
    let card: Card
    @State var quote: Quote? = nil
    
    var body: some View {
        GeometryReader { geo in
            if quote != nil { // If the quote hasnt loaded, show placeholder
                VStack {
                    ZStack {
                        ExpandedView()
                        VStack(alignment: .center, spacing: 10) {
                            Spacer()
                            HStack {
                                Text("\"").font(.system(size: 55))
                                Spacer()
                            }.padding(.bottom, -40)
                            Text(quote!.quoteText)
                                .font(.system(size: 25))
                                .lineLimit(5)
                                .minimumScaleFactor(0.25) // Scale down text incase the text is very large
                            Text(quote!.quoteAuthor).font(.headline)
                            Spacer()
                        }.foregroundColor(card.TextColor.color()).padding(.top, -10).padding(.horizontal, 15)
                    }.background(card.Background.color())
                }
            }
        }.onAppear() {
            getQuote()
        }
    }
    
    func getQuote() { // If a quote has already loaded in the app session (cachedQuote != nil), then it would load from the cached variable. Otherwise it will load from the network request.
        if cachedQuote == nil {
            getRandomQuote { quote in
                self.quote = quote  // Update the placeholder quote with a random one
                cachedQuote = quote
            }
        } else {
            self.quote = cachedQuote
        }
    }
}
