//
//  CalendarCardView.swift
//  CustomCardsApp
//
//  Created by Mihajlo Mit on 2021-06-14.
//

import SwiftUI

struct CalendarCardView: View {
    let card: Card
    
    var body: some View {
        VStack {
            CalendarGridView(card: card, interval: Calendar.current.dateInterval(of: .month, for: Date())!) { date in
                // Customize each date component
                Text(date.toShortDateString)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Calendar.current.isDateInToday(date) ? card.Background.color() : card.TextColor.color())
                    .frame(width: 25, height: 25)
                    .multilineTextAlignment(.trailing)
                    .background(Calendar.current.isDateInToday(date) ? (Rectangle().fill(card.TextColor.color()).cornerRadius(5)) : nil)
            }
        }.padding(.all, 10).padding(.top, 10).background(card.Background.color())
    }
}
