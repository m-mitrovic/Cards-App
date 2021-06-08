//
//  CardView.swift
//  CustomCardsApp
//
//  Created by Mihajlo Mit on 2021-06-07.
//

import SwiftUI

struct CardView: View {
    let card: Card
    
    var body: some View {
        VStack {
            switch (card.CardType) {
            case CardType.moonPhases.rawValue:
                MoonPhaseCardView(card: card)
            case CardType.calendar.rawValue:
                VStack { }
            default:
                VStack { }
            }
        }.background(PlaceholderCardView())
    }
}
