import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            // 1️⃣ Home tab (now first)
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            // 2️⃣ Goals tab
            GoalsView()
                .tabItem {
                    Image(systemName: "target")
                    Text("Goals")
                }
            
            // 3️⃣ Experience tab
            ExperienceView()
                .tabItem {
                    Image(systemName: "briefcase")
                    Text("Experience")
                }
            
            // 4️⃣ Projects tab
            ProjectsView()
                .tabItem {
                    Image(systemName: "square.and.pencil")
                    Text("Projects")
                }
            
            // 5️⃣ Contact tab
            ContactView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Contact")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
