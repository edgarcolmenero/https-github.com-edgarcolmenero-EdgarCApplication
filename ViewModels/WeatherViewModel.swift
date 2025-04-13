// WeatherViewModel.swift

import Foundation
import SwiftUI    // for Color in WeatherIcon

// 1️⃣ Define a wrapper matching exactly what Open-Meteo returns
private struct OpenMeteoResponse: Decodable {
    let current_weather: CurrentWeather

    struct CurrentWeather: Decodable {
        let time: String
        let temperature: Double
        let windspeed: Double
        let weathercode: Int
    }
}

// 2️⃣ Your simple view model type
struct WeatherResponse: Decodable {
    let temperature: Double
    let windspeed: Double
    let weathercode: Int
    let time: String
}

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var weather: WeatherResponse?

    func fetchWeather() async {
        let urlString =
          "https://api.open-meteo.com/v1/forecast?"
        + "latitude=32.7357&longitude=-97.1081&current_weather=true"

        guard let url = URL(string: urlString) else {
            print("🔥 Invalid URL:", urlString)
            return
        }
        print("🌤️  Fetching weather from Open-Meteo…")

        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            if let http = response as? HTTPURLResponse, http.statusCode != 200 {
                print("⚠️ HTTP", http.statusCode)
                return
            }

            // 3️⃣ Decode into the wrapper
            let openMeteo = try JSONDecoder().decode(OpenMeteoResponse.self, from: data)
            let cw = openMeteo.current_weather

            // 4️⃣ Map into your app’s simple type
            let simple = WeatherResponse(
                temperature: cw.temperature,
                windspeed:   cw.windspeed,
                weathercode: cw.weathercode,
                time:        cw.time
            )

            weather = simple
            print("🎉 Decoded weather:", simple)
        } catch {
            print("❌ Fetch error:", error.localizedDescription)
        }
    }
}

// MARK: – WeatherResponse Icon Definitions

/// A single SF-Symbol plus its tint color
struct WeatherIcon: Identifiable {
    let id = UUID()
    let name: String
    let color: Color
}

extension WeatherResponse {
    /// One or more icons (and colors) to show for this weathercode
    var icons: [WeatherIcon] {
        switch weathercode {
        case   0:
            return [ .init(name: "sun.max.fill",      color: .yellow) ]
        case   1:
            return [ .init(name: "sun.max",           color: .yellow) ]
        case   2:
            return [
                .init(name: "sun.max.fill",      color: .yellow),
                .init(name: "cloud.fill",        color: .gray)
            ]
        case  3, 45, 48:
            return [ .init(name: "cloud.fill",        color: .gray) ]
        case 51...67:
            return [
                .init(name: "cloud.fill",         color: .gray),
                .init(name: "cloud.drizzle.fill", color: .blue)
            ]
        case 71...86:
            return [
                .init(name: "cloud.fill",        color: .gray),
                .init(name: "snow",              color: .blue)
            ]
        case 95...99:
            return [
                .init(name: "cloud.bolt.fill",   color: .gray),
                .init(name: "cloud.rain.fill",   color: .blue)
            ]
        default:
            return [ .init(name: "questionmark",     color: .gray) ]
        }
    }
}
