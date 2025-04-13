import SwiftUI
import MapKit

// ─ MARK: — Curvy Connector Shape ──────────────────────
struct CurvyConnector: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let midY = rect.midY
        let meetInset: CGFloat = 85
        let meetXLeft  = rect.midX - meetInset
        let meetXRight = rect.midX + meetInset
        let handleOffset: CGFloat = 40

        // Left top → left meet
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addCurve(
            to: CGPoint(x: meetXLeft, y: midY - 30),
            control1: CGPoint(x: rect.minX + rect.width * 0.2, y: rect.minY),
            control2: CGPoint(x: meetXLeft - handleOffset, y: midY - 80)
        )

        // Left bottom → left meet
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addCurve(
            to: CGPoint(x: meetXLeft, y: midY + 30),
            control1: CGPoint(x: rect.minX + rect.width * 0.2, y: rect.maxY),
            control2: CGPoint(x: meetXLeft - handleOffset, y: midY + 80)
        )

        // Right top → right meet
        path.move(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addCurve(
            to: CGPoint(x: meetXRight, y: midY - 30),
            control1: CGPoint(x: rect.maxX - rect.width * 0.2, y: rect.minY),
            control2: CGPoint(x: meetXRight + handleOffset, y: midY - 80)
        )

        // Right bottom → right meet
        path.move(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addCurve(
            to: CGPoint(x: meetXRight, y: midY + 30),
            control1: CGPoint(x: rect.maxX - rect.width * 0.2, y: rect.maxY),
            control2: CGPoint(x: meetXRight + handleOffset, y: midY + 80)
        )

        return path
    }
}

struct HomeView: View {
    @StateObject private var vm = WeatherViewModel()
    @State private var currentTime = Date()

    // Center on UTA Campus
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 32.7314, longitude: -97.1131),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )

    /// 12-hour clock formatter
    private static let timeFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "h:mm a"
        return df
    }()

    /// Single annotation for UTA Campus
    private let utaAnnotation = [
        IdentifiablePlace(
            id: "uta",
            coordinate: CLLocationCoordinate2D(latitude: 32.7314, longitude: -97.1131)
        )
    ]

    /// One true “navy” color everywhere
    private let navy = Color(red: 0/255, green: 31/255, blue: 63/255)
    private let lightGray = Color(red: 0.95, green: 0.95, blue: 0.95)

    var body: some View {
        ScrollView {
            VStack(spacing: 40) {

                // ── SHIM ABOVE MAIN SECTION (light gray) ──
                lightGray
                    .frame(height: 25)

                // ── TOP SECTION (light gray full-width) ──
                ZStack {
                    lightGray

                    CurvyConnector()
                        .stroke(.white, lineWidth: 2)
                        .shadow(color: navy.opacity(0.7), radius: 8)

                    // 1) Weather box (left third)
                    GeometryReader { geo in
                        if let w = vm.weather {
                            HStack(spacing: 8) {
                                Image(systemName: w.symbolName)
                                Text("\(w.fahrenheit)°F")
                            }
                            .font(.subheadline)
                            .foregroundColor(navy)
                            .frame(width: 85, height: 85)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(.white, lineWidth: 2)
                            )
                            .shadow(color: navy.opacity(0.7), radius: 10)
                            .position(
                                x: geo.size.width * 0.125,  // ← unified position
                                y: geo.size.height / 2 + 10
                            )
                        } else {
                            ProgressView()
                                .position(
                                    x: geo.size.width * 0.125,  // ← same as above
                                    y: geo.size.height / 2 + 10
                                )
                        }
                    }
                    .frame(height: 170)
                    
                    // 2) Center: time, profile image, quoted tagline
                    VStack(spacing: 8) {
                        Text(Self.timeFormatter.string(from: currentTime))
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(navy)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 4)
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(.white, lineWidth: 2)
                                    .shadow(color: navy.opacity(0.7), radius: 6)
                            )

                        Image("ProfileImage")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(.white, lineWidth: 3))
                            .shadow(color: navy.opacity(0.7), radius: 10)

                        Text("“Never Stay Satisfied!”")
                            .font(.headline)
                            .foregroundColor(navy)
                        Text("(Edgar Colmenero, 2025, Chapter 1, LIFE)")
                            .font(.caption)
                            .italic()
                            .foregroundColor(.secondary)
                    }

                    // 3) Mini-map (right third)
                    GeometryReader { geo in
                        Map(
                            coordinateRegion: $region,
                            interactionModes: .all,
                            showsUserLocation: false,
                            userTrackingMode: .constant(.none),
                            annotationItems: utaAnnotation
                        ) { place in
                            MapAnnotation(coordinate: place.coordinate) {
                                Image("UTA_Mustang")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                            }
                        }
                        .frame(width: 85, height: 85)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.white, lineWidth: 2)
                        )
                        .shadow(color: navy.opacity(0.7), radius: 10)
                        .position(
                            x: geo.size.width * 0.875,
                            y: geo.size.height / 2 + 10
                        )
                        .onTapGesture(count: 2) {
                            if let url = URL(string: "maps://?q=Arlington,Texas") {
                                UIApplication.shared.open(url)
                            }
                        }
                    }
                    .frame(height: 170)

                }
                .frame(maxWidth: .infinity, minHeight: 160)

                // ── ABOUT ME SECTION (navy full-width) ──
                HStack(alignment: .top, spacing: 16) {
                    Image("AboutMePhoto")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(navy, lineWidth: 2)
                        )
                        .shadow(color: .white.opacity(0.7), radius: 10)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("About Me")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)

                        Text("""
                        Hello, my name is Edgar Colmenero. I am currently a student at Tarrant County College, \
                        and I plan to transfer to the University of Texas at Arlington in the Fall of 2025 \
                        to pursue a degree in Computer Science. I have a strong passion for mobile and web \
                        development and possess knowledge in HTML, CSS, iOS, Java, and Python. My aspiration \
                        is to become a distinguished Software Developer in the future.
                        """)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.white)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(navy)

                // ── SKILLS & INTERESTS SECTION (light gray full-width) ──
                HStack(alignment: .top, spacing: 16) {
                    Image("SkillsPhoto")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.white, lineWidth: 2)
                        )
                        .shadow(color: navy.opacity(0.7), radius: 10)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("My Skills & Interests")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(navy)

                        Text("""
                        My passion for sports and coding has instilled in me discipline, teamwork, and resilience—qualities that guide both my personal and professional growth. I enjoy creating websites and apps using JavaScript, Python, HTML, and CSS, whether for fun or to help small businesses grow. My role as a Bilingual Financial Services Representative at Wells Fargo and my experience at Walmart have strengthened my customer service skills and deepened my understanding of user needs. These experiences taught me how to prioritize satisfaction, collaboration, and usability. I’m committed to continuous learning and aim to make a positive impact through thoughtful, user-focused development.
                        """)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(navy)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(lightGray)

                // ── PORTFOLIO SECTION (navy full-width) ──
                VStack(spacing: 16) {
                    Text("What’s to come in my Portfolio?")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    HStack(alignment: .top, spacing: 16) {
                        // iOS App
                        VStack(spacing: 8) {
                            Image("SwiftIcon")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(navy, lineWidth: 2)
                                )
                                .shadow(color: .white.opacity(0.7), radius: 10)

                            Text("Edgar’s Personal iOS App")
                                .font(.headline)
                                .foregroundColor(.white)

                            Text("""
                            A SwiftUI application showcasing smooth, intuitive interfaces \
                            and powerful backend functions to highlight app robustness.
                            """)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                        }

                   
                        // Android App
                        VStack(spacing: 8) {
                            Image("JavaIcon")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(navy, lineWidth: 2)
                                )
                                .shadow(color: .white.opacity(0.7), radius: 10)

                            Text("Edgar’s AI Daytrader")
                                .font(.headline)
                                .foregroundColor(.white)

                            Text("""
                            An AI-driven project focusing on responsive, \
                            user-friendly actions and smooth consistent performance.
                            """)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                        }

                        // Web App
                        VStack(spacing: 8) {
                            Image("WebIcon")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(navy, lineWidth: 2)
                                )
                                .shadow(color: .white.opacity(0.7), radius: 10)

                            Text("Edgar’s Personal Website")
                                .font(.headline)
                                .foregroundColor(.white)

                            Text("""
                            A responsive website built with modern frameworks, \
                            showcasing full-stack development skills.
                            """)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                        }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(navy)

                // ── FOOTER SECTION (light gray full-width) ──
                lightGray
                    .frame(height: 25)
                    .frame(maxWidth: .infinity)
                    .overlay(
                        Text("© 2025 Data Scientist Edgar Colmenero \"Never Stay Satisfied\"")
                            .font(.caption)
                            .foregroundColor(navy)
                    )
            }
            .padding(.vertical)
        }
        .background(lightGray)
        .ignoresSafeArea()
        .task {                                         // ← fetch runs for sure
            await vm.fetchWeather()
        }
        .onReceive(
            Timer.publish(every: 1, on: .main, in: .common)
                .autoconnect()
        ) { now in
            currentTime = now
        }
    }
}

// ─ MARK: — Preview ────────────────────────────────────
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

// ─ MARK: — Helper Types & Extensions ──────────────────

struct IdentifiablePlace: Identifiable {
    let id: String
    let coordinate: CLLocationCoordinate2D
}

extension WeatherResponse {
    /// °C → °F
    var fahrenheit: Int { Int((temperature * 9/5) + 32) }

    /// SF Symbol for current weather, swapping in moon variants at night
    var symbolName: String {
        let hour = Calendar.current.component(.hour, from: Date())
        let isNight = hour < 6 || hour >= 18

        switch weathercode {
        case   0: return isNight ? "moon.stars.fill" : "sun.max.fill"
        case   1: return isNight ? "moon.stars"      : "sun.max"
        case   2: return isNight ? "cloud.moon.fill" : "cloud.sun.fill"
        case   3: return "cloud.fill"
        case 45, 48: return "cloud.fog.fill"
        case 51...67: return "cloud.drizzle.fill"
        case 71...86: return "snow"
        case 95...99: return "cloud.bolt.rain.fill"
        default:      return "questionmark"
        }
    }
}
