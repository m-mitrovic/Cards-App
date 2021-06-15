//
//  CalendarGridView.swift
//  CustomCardsApp
//
//  Created by Mihajlo Mit on 2021-06-14.
//

import SwiftUI

struct CalendarGridView<DateView>: View where DateView: View {
    init(
        card: Card,
        interval: DateInterval,
        showHeaders: Bool = true,
        @ViewBuilder content: @escaping (Date) -> DateView
    ) {
        self.interval = interval
        self.content = content
        self.card = card
    }

    @Environment(\.calendar) var calendar
    let card: Card
    let interval: DateInterval
    let content: (Date) -> DateView

    var body: some View {
        headerView()
        Spacer()
        weekDaysView()
        daysGridView()
        Spacer()
    }

    private var months: [Date] {
        calendar.generateDates(
            inside: interval,
            matching: DateComponents(day: 1, hour: 0, minute: 0, second: 0)
        )
    }

    private var weeks: [Date] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: Date()) else { return [] }

        return calendar.generateDates(
            inside: monthInterval,
            matching: DateComponents(hour: 0, minute: 0, second: 0, weekday: calendar.firstWeekday)
        )
    }

    /** The month heading "June" */
    private func headerView(month: Date = Date()) -> some View {
        let component = calendar.component(.month, from: month)
        let formatter = component == 1 ? DateFormatter.monthAndYear : .month

        return HStack {
            Text(formatter.string(from: month).localizedUppercase)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(card.TextColor.color())
            Spacer()
        }.padding(.leading, 15)
    }

    /** Returns view of all weeks. For example, S M T W T F S. */
    private func weekDaysView() -> some View {
        HStack(spacing: (cardWidth-80)/7) {
            ForEach(0 ..< 7, id: \.self) { index in
                Text(getWeekDaysSorted()[index].localizedUppercase)
                    .opacity(0.7)
                    .scaledToFill()
                    .foregroundColor(card.TextColor.color())
                    .font(.system(size: 14, weight: .bold))
                    .minimumScaleFactor(0.5)
            }
        }
    }

    /** Returns unformatted grid of monthly days formated for the current month */
    private func daysGridView() -> some View {
        LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
            ForEach(months, id: \.self) { month in
                ForEach(days(month: month), id: \.self) { date in
                    if calendar.isDate(date, equalTo: month, toGranularity: .month) {
                        content(date).id(date)
                    } else {
                        content(date).hidden()
                    }
                }
            }
        }
    }

    private func days(month: Date) -> [Date] {
        guard
            let monthInterval = calendar.dateInterval(of: .month, for: month),
            let monthFirstWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.start),
            let monthLastWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.end)
        else { return [] }

        return calendar.generateDates(
            inside: DateInterval(start: monthFirstWeek.start, end: monthLastWeek.end),
            matching: DateComponents(hour: 0, minute: 0, second: 0)
        )
    }

    private func getWeekDaysSorted() -> [String] {
        let weekDays = Calendar.current.veryShortWeekdaySymbols
        let sortedWeekDays = Array(weekDays[Calendar.current.firstWeekday - 1 ..< Calendar.current.shortWeekdaySymbols.count] + weekDays[0 ..< Calendar.current.firstWeekday - 1])
        return sortedWeekDays
    }
}


extension Calendar {
    /** Generates dates of a given interval */
    func generateDates(inside interval: DateInterval, matching components: DateComponents) -> [Date] {
        var dates: [Date] = []
        dates.append(interval.start) // Add starting date

        enumerateDates(
            startingAfter: interval.start,
            matching: components,
            matchingPolicy: .nextTime
        ) { date, _, stop in
            if let date = date {
                if date < interval.end { // Append date if before ending interval
                    dates.append(date)
                } else {
                    stop = true
                }
            }
        }
        return dates
    }
}


extension DateFormatter {
    static var month: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale.autoupdatingCurrent
        formatter.setLocalizedDateFormatFromTemplate("MMMM")
        return formatter
    }

    static var monthAndYear: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale.autoupdatingCurrent
        formatter.setLocalizedDateFormatFromTemplate("MMMM yyyy")
        return formatter
    }
}

//struct CalendarCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CalendarCardView()
//    }
//}

extension Date {
    var toShortDateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: self)
    }
}
