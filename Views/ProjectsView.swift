// ProjectsView.swift

import SwiftUI

struct ProjectsView: View {
    // MARK: — State for CalendarContainer
    @State private var mode: CalendarMode
    @State private var selectedDate = Date()

    // MARK: — Colors
    private let navy      = Color(red:   0/255, green: 31/255, blue: 63/255)
    private let lightGray = Color(red: 0.95, green: 0.95, blue: 0.95)

    init() {
        // Start in the current month view
        let now = Date()
        let comps = Calendar.current.dateComponents([.year, .month], from: now)
        let firstOfMonth = Calendar.current.date(from: comps)!
        _mode = State(initialValue: .month(firstOfMonth))
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {

                // ── EXTRA TOP SHIM ───────────────────────────────
                lightGray
                    .frame(height: 40)
                    .frame(maxWidth: .infinity)

                // ── TOP SHIM ────────────────────────────────────
                lightGray
                    .frame(height: 100)
                    .frame(maxWidth: .infinity)
                    .overlay(
                        VStack(spacing: 4) {
                            Spacer()
                            Text("If you wish to see my Personal Website")
                            Text("Navigate to 2025>April>April 24th>Select \"Edgar Colmenero's Personal Website\"")
                        }
                        .font(.caption)
                        .foregroundColor(Color.gray)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 8)
                    )

                // ── CALENDAR CONTAINER ──────────────────────────
                CalendarContainer(mode: $mode, selectedDate: $selectedDate)
                    .frame(maxWidth: .infinity)

                // ── BOTTOM SHIM with footer text ───────────────
                lightGray
                    .frame(height: 100)
                    .frame(maxWidth: .infinity)
                    .overlay(
                        Text("© 2024 Data Scientist Edgar Colmenero \"Never Stay Satisfied\"")
                            .font(.caption)
                            .foregroundColor(navy)
                    )
            }
        }
        .background(lightGray)
        .ignoresSafeArea()
    }
}

struct ProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsView()
    }
}
