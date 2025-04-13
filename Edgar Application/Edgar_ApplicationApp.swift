import SwiftUI
import UIKit

@main
struct Edgar_ApplicationApp: App {
    init() {
        let navy      = UIColor(red:   0/255, green:  31/255, blue:  63/255, alpha: 1)
        let white     = UIColor.white
        let lightGray = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 1)

        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = lightGray

        let stacked = appearance.stackedLayoutAppearance
        stacked.normal.iconColor             = navy
        stacked.normal.titleTextAttributes   = [.foregroundColor: navy]
        stacked.selected.iconColor           = white
        stacked.selected.titleTextAttributes = [.foregroundColor: white]

        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()  // ← back to your TabView container
        }
    }
}
