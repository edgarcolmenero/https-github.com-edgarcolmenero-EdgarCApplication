// CalendarContainer.swift

import SwiftUI

// ─── Published key-dates (green highlight) ─────────────
private let publishedDates: [Date] = [
    Calendar.current.date(from: DateComponents(year: 2025, month: 4, day: 24))!,
    Calendar.current.date(from: DateComponents(year: 2025, month: 5, day: 4))!
]

// ─── In-Progress key-dates (yellow highlight) ──────────
private let inProgressDates: [Date] = [
    Calendar.current.date(from: DateComponents(year: 2025, month: 6, day: 15))!,
    Calendar.current.date(from: DateComponents(year: 2025, month: 8, day: 15))!
]

// ─ MARK: CalendarMode ────────────────────────────────
enum CalendarMode: Equatable {
    case year
    case month(Date)    // first day of month
    case day(Date)      // specific day
}

// ─ MARK: CalendarContainer ────────────────────────────
struct CalendarContainer: View {
    @Binding var mode: CalendarMode
    @Binding var selectedDate: Date

    private let navy      = Color(red:   0/255, green: 31/255, blue: 63/255)
    private let lightGray = Color(red: 0.95, green: 0.95, blue: 0.95)

    init(mode: Binding<CalendarMode>, selectedDate: Binding<Date>) {
        self._mode = mode
        self._selectedDate = selectedDate
    }

    var body: some View {
        ZStack {
            lightGray.ignoresSafeArea()

            Group {
                switch mode {
                case .year:
                    YearGridView(onMonthTap: { monthDate in
                        withAnimation(.easeInOut) { mode = .month(monthDate) }
                    })
                    .transition(.move(edge: .trailing))

                case .month(let firstOfMonth):
                    MonthView(
                        firstOfMonth: firstOfMonth,
                        onDayTap: { day in
                            selectedDate = day
                            withAnimation(.easeInOut) { mode = .day(day) }
                        },
                        onBack: {
                            withAnimation(.easeInOut) { mode = .year }
                        }
                    )
                    .transition(.move(edge: .trailing))

                case .day(let day):
                    DayTimelineView(
                        day: day,
                        onBack: {
                            withAnimation(.easeInOut) {
                                let comps = Calendar.current
                                    .dateComponents([.year, .month], from: day)
                                let first = Calendar.current.date(from: comps)!
                                mode = .month(first)
                            }
                        }
                    )
                    .transition(.move(edge: .trailing))
                }
            }
        }
    }
}

// ─ MARK: YearGridView ────────────────────────────────
struct YearGridView: View {
    let onMonthTap: (Date) -> Void
    private let navy = Color(red: 0/255, green: 31/255, blue: 63/255)
    private let year = Calendar.current.component(.year, from: Date())

    // Tighter spacing so everything scales down
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 12), count: 3)

    var body: some View {
        VStack(spacing: 16) {
            // — Year title —
            Text(String(year))
                .font(.largeTitle).bold()
                .foregroundColor(navy)
                .padding(.top, 16)

            // — Silver line under the year —
            Divider()
                .background(Color.gray)
                .padding(.horizontal, 16)

            // — 3×4 mini-month grid —
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(1...12, id: \.self) { m in
                    let comps = DateComponents(year: year, month: m, day: 1)
                    let firstOfMonth = Calendar.current.date(from: comps)!

                    MiniMonthView(firstOfMonth: firstOfMonth)
                        // scale down slightly and constrain height
                        .scaleEffect(0.9)
                        .frame(maxWidth: .infinity, minHeight: 100)
                        .onTapGesture {
                            onMonthTap(firstOfMonth)
                        }
                }
            }
            .padding(.horizontal, 12)
            .padding(.bottom, 12)
        }
    }
}


// ─ MARK: MiniMonthView ───────────────────────────────
struct MiniMonthView: View {
    let firstOfMonth: Date
    private let navy     = Color(red: 0/255, green: 31/255, blue: 63/255)
    private let cellSize: CGFloat = 14

    var body: some View {
        let cal       = Calendar.current
        let monthName = DateFormatter()
            .monthSymbols[cal.component(.month, from: firstOfMonth)-1]
        let daysInMonth = cal.range(of: .day, in: .month, for: firstOfMonth)!
        let startWeek   = cal.component(.weekday, from: firstOfMonth) - 1
        let today       = Calendar.current.startOfDay(for: Date())

        VStack(spacing: 4) {
            Text(monthName.prefix(3))
                .font(.caption).bold()
                .foregroundColor(navy)

            LazyVGrid(
                columns: Array(repeating: GridItem(.fixed(cellSize), spacing: 4), count: 7),
                spacing: 4
            ) {
                ForEach(0..<42, id: \.self) { idx in
                    if idx < startWeek || idx >= startWeek + daysInMonth.count {
                        Color.clear
                            .frame(width: cellSize, height: cellSize)
                    } else {
                        let dayNum = idx - startWeek + 1
                        let date = cal.date(from: DateComponents(
                            year: cal.component(.year, from: firstOfMonth),
                            month: cal.component(.month, from: firstOfMonth),
                            day: dayNum
                        ))!

                        ZStack {
                            if inProgressDates.contains(where: {
                                Calendar.current.isDate($0, inSameDayAs: date)
                            }) {
                                Circle().fill(Color.yellow.opacity(0.3))
                                    .frame(width: cellSize, height: cellSize)
                            }
                            if publishedDates.contains(where: {
                                Calendar.current.isDate($0, inSameDayAs: date)
                            }) {
                                Circle().fill(Color.green.opacity(0.3))
                                    .frame(width: cellSize, height: cellSize)
                            }
                            if Calendar.current.isDate(date, inSameDayAs: today) {
                                Circle().fill(navy.opacity(0.3))
                                    .frame(width: cellSize, height: cellSize)
                            }
                            Text("\(dayNum)")
                                .font(.caption2)
                                .foregroundColor(navy.opacity(0.7))
                                .frame(width: cellSize, height: cellSize)
                        }
                    }
                }
            }
        }
        .padding(6)
        .background(Color.white)
        .cornerRadius(6)
        .shadow(color: Color.white.opacity(0.7), radius: 4)
    }
}

// ─ MARK: MonthView ────────────────────────────────────
struct MonthView: View {
    let firstOfMonth: Date
    let onDayTap: (Date) -> Void
    let onBack: () -> Void
    private let navy      = Color(red: 0/255, green: 31/255, blue: 63/255)
    private let lightGray = Color(red: 0.95, green: 0.95, blue: 0.95)

    var body: some View {
        // 1️⃣ Prepare
        let cal         = Calendar.current
        let monthName   = DateFormatter().monthSymbols[cal.component(.month, from: firstOfMonth)-1]
        let year        = cal.component(.year, from: firstOfMonth)
        let month       = cal.component(.month, from: firstOfMonth)
        let daysInMonth = cal.range(of: .day, in: .month, for: firstOfMonth)!
        let startWeek   = cal.component(.weekday, from: firstOfMonth) - 1
        let today       = Calendar.current.startOfDay(for: Date())

        // filter key‐dates
        let publishedThisMonth = publishedDates.filter {
            let c = Calendar.current.dateComponents([.year, .month], from: $0)
            return c.year == year && c.month == month
        }
        let inProgressThisMonth = inProgressDates.filter {
            let c = Calendar.current.dateComponents([.year, .month], from: $0)
            return c.year == year && c.month == month
        }

        // build events list
        let events: [(Color, String)] = {
            var arr: [(Color, String)] = []
            if Calendar.current.component(.year, from: Date()) == year &&
               Calendar.current.component(.month, from: Date()) == month {
                arr.append((navy, "Today's Date"))
            }
            for date in publishedThisMonth {
                let label = Calendar.current.component(.month, from: date) == 4
                    ? "Edgar Colmenero’s Personal Website (Completion Date)"
                    : "Edgar Colmenero’s Application (Completion Date)"
                arr.append((.green, label))
            }
            for date in inProgressThisMonth {
                let label = Calendar.current.component(.month, from: date) == 6
                    ? "Edgar’s Taco Shop (In Progress…)"
                    : "Edgar’s AI DayTrader (In Progress…)"
                arr.append((.yellow, label))
            }
            return arr
        }()

        // determine rows
        let totalCells = startWeek + daysInMonth.count
        let numRows = Int(ceil(Double(totalCells) / 7.0))

        // 2️⃣ Return body
        return VStack(spacing: 0) {
            // — Nav bar —
            HStack {
                Button(action: onBack) {
                    Text(String(year))
                        .font(.headline)
                        .foregroundColor(navy)
                }
                Spacer()
                Text(monthName)
                    .font(.title2).bold()
                    .foregroundColor(navy)
                Spacer()
                Button("Today") { onDayTap(Date()) }
                    .foregroundColor(navy)
            }
            .padding()
            .background(Color.white)
            .shadow(color: Color.white.opacity(0.7), radius: 4)

            // — Weekday headers —
            let weekdays = DateFormatter().shortWeekdaySymbols ?? []
            HStack(spacing: 0) {
                ForEach(weekdays, id: \.self) { wd in
                    Text(wd.prefix(1))
                        .font(.caption2)
                        .foregroundColor(navy.opacity(0.7))
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.vertical, 4)
            .background(Color(white: 0.97))

            // — Grid with uniform rows & tappable days —
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(0..<numRows, id: \.self) { row in
                        // top divider
                        Divider()
                            .frame(height: 1)
                            .background(Color(white: 0.85))

                        HStack(spacing: 0) {
                            ForEach(0..<7, id: \.self) { col in
                                let idx = row * 7 + col
                                Group {
                                    if idx < startWeek || idx >= startWeek + daysInMonth.count {
                                        Color.clear
                                    } else {
                                        let dayNum = idx - startWeek + 1
                                        let date = cal.date(
                                            from: DateComponents(year: year, month: month, day: dayNum)
                                        )!

                                        ZStack {
                                            // cell background
                                            lightGray
                                                .cornerRadius(4)

                                            // highlights
                                            if inProgressThisMonth.contains(where: { Calendar.current.isDate($0, inSameDayAs: date) }) {
                                                Circle().fill(Color.yellow.opacity(0.3))
                                                    .frame(width: 32, height: 32)
                                            }
                                            if publishedThisMonth.contains(where: { Calendar.current.isDate($0, inSameDayAs: date) }) {
                                                Circle().fill(Color.green.opacity(0.3))
                                                    .frame(width: 32, height: 32)
                                            }
                                            if Calendar.current.isDate(date, inSameDayAs: today) {
                                                Circle().fill(navy.opacity(0.3))
                                                    .frame(width: 32, height: 32)
                                            }

                                            Text("\(dayNum)")
                                                .foregroundColor(navy.opacity(0.7))
                                        }
                                        .contentShape(Rectangle())
                                        .onTapGesture {
                                            onDayTap(date)
                                        }
                                    }
                                }
                                .frame(maxWidth: .infinity, minHeight: 32, maxHeight: 32)

                                // vertical divider
                                if col < 6 {
                                    Divider()
                                        .frame(width: 1, height: 32)
                                        .background(Color(white: 0.85))
                                }
                            }
                        }

                        // bottom divider (except last row)
                        if row < numRows - 1 {
                            Divider()
                                .frame(height: 1)
                                .background(Color(white: 0.85))
                        }
                    }
                }
                .padding(.horizontal, 12)
                .padding(.top, 8)
            }

            // — divider before events —
            Divider()
                .frame(height: 1)
                .background(Color(white: 0.85))
                .padding(.horizontal, 12)

            // — “Events” card —
            VStack(spacing: 0) {
                ForEach(Array(events.enumerated()), id: \.offset) { idx, pair in
                    HStack {
                        Image(systemName: "calendar")
                            .foregroundColor(pair.0)
                        Text(pair.1)
                            .foregroundColor(navy)
                        Spacer()
                    }
                    .padding(.vertical, 8)

                    if idx < events.count - 1 {
                        Divider()
                            .frame(height: 1)
                            .background(Color(white: 0.85))
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 12)
            .background(lightGray)
            .cornerRadius(6)
            .padding(.horizontal, 12)

        } // VStack
        .background(lightGray)
    }
}





// ─ MARK: DayTimelineView ─────────────────────────────
struct DayTimelineView: View {
    let day: Date
    let onBack: () -> Void
    private let navy = Color(red: 0/255, green: 31/255, blue: 63/255)
    private let lightGray = Color(red: 0.95, green: 0.95, blue: 0.95)
    private static let fullDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .full
        return df
    }()
    
    // URLs for the published events
    private let personalWebsiteURL = URL(string:
        "https://edgarcolmenero.github.io/Edgar-Colmenero-Personal-Website/index.html"
    )!

    var body: some View {
        // prepare which events fall on this exact day
        let isToday = Calendar.current.isDate(day, inSameDayAs: Date())
        let publishedToday = publishedDates.filter {
            Calendar.current.isDate($0, inSameDayAs: day)
        }
        let inProgressToday = inProgressDates.filter {
            Calendar.current.isDate($0, inSameDayAs: day)
        }
        
        // build a simple list of (color, title, optional URL)
        let allDayEvents: [(Color, String, URL?)] = {
            var arr: [(Color, String, URL?)] = []
            if isToday {
                arr.append((navy, "Today's Date", nil))
            }
            for date in publishedToday {
                let label = Calendar.current.component(.month, from: date) == 4
                    ? "Edgar Colmenero’s Personal Website"
                    : "Edgar Colmenero’s Application"
                arr.append((.green, label, personalWebsiteURL))
            }
            for date in inProgressToday {
                let m = Calendar.current.component(.month, from: date)
                let label = (m == 6)
                    ? "Edgar’s Taco Shop"
                    : "Edgar’s AI DayTrader"
                arr.append((.yellow, label, nil))
            }
            return arr
        }()
        
        return VStack(spacing: 0) {
            // ── top nav bar ─────────────────────────────
            HStack {
                Button(action: onBack) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(navy)
                }
                Spacer()
                Text(Self.fullDateFormatter.string(from: day))
                    .font(.headline).bold()
                    .foregroundColor(navy)
                Spacer()
                Button("Today") {
                    // now navigates back to the month view, then you can re-select “Today”
                    onBack()
                }
                .foregroundColor(navy)
            }
            .padding()
            .background(Color.white)
            .shadow(color: Color.white.opacity(0.7), radius: 4)
            
            // ── thin grey line above all-day card ────────
            if !allDayEvents.isEmpty {
                Divider()
                    .background(Color(white: 0.90))
                    .padding(.horizontal, 12)
            }
            
            // ── all-day section (background lightGray) ───
            if !allDayEvents.isEmpty {
                VStack(spacing: 0) {
                    ForEach(Array(allDayEvents.enumerated()), id: \.offset) { idx, event in
                        HStack {
                            Image(systemName: "calendar")
                                .foregroundColor(event.0)
                            if let url = event.2 {
                                Link(event.1, destination: url)
                                    .foregroundColor(navy)
                            } else {
                                Text(event.1)
                                    .foregroundColor(navy)
                            }
                            Spacer()
                        }
                        .padding(.vertical, 8)
                        
                        // grey line below each event
                        if idx < allDayEvents.count - 1 {
                            Divider()
                                .background(Color(white: 0.90))
                                .padding(.horizontal, 12)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .background(lightGray)
                .cornerRadius(6)
                .padding(.horizontal, 12)
                .padding(.bottom, 8)
            }
            
            // ── thin grey line below all-day card ────────
            if !allDayEvents.isEmpty {
                Divider()
                    .background(Color(white: 0.90))
                    .padding(.horizontal, 12)
            }
            
            // ── hourly timeline ────────────────────────────
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(0..<24, id: \.self) { hour in
                        let h12 = (hour % 12 == 0) ? 12 : (hour % 12)
                        let suffix = (hour < 12) ? "AM" : "PM"
                        HStack {
                            Text("\(h12) \(suffix)")
                                .font(.caption2)
                                .foregroundColor(navy.opacity(0.7))
                                .frame(width: 40)
                            Rectangle()
                                .fill(Color.white)
                                .frame(height: 1)
                                .shadow(color: Color.white.opacity(0.7), radius: 1)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
        }
        .background(Color(white: 0.95))
    }
}


// ─ MARK: Preview ─────────────────────────────────────
struct CalendarContainer_Previews: PreviewProvider {
    static var previews: some View {
        CalendarContainer(
            mode: .constant(.year),
            selectedDate: .constant(Date())
        )
    }
}
