import SwiftUI

struct GoalsView: View {
    // One true navy & light gray
    private let navy      = Color(red:   0/255, green: 31/255, blue: 63/255)
    private let lightGray = Color(red: 0.95, green: 0.95, blue: 0.95)

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                
                // ── TOP SHIM (light gray) ──
                lightGray
                    .frame(height: 40)
                    .frame(maxWidth: .infinity)
                
                // ── Section 1 (light gray) ──
                HStack(alignment: .top, spacing: 16) {
                    Image("MobileWebPhoto")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.white, lineWidth: 2)
                        )
                        .shadow(color: navy.opacity(0.7), radius: 8)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("My Mobile/Web Development Goals")
                            .font(.title2).fontWeight(.bold)
                            .foregroundColor(navy)
                        
                        Text("""
I want to become a specialist in HTML, CSS, JavaScript, Python, iOS Development, and Swift. I want to grow not only in the Software Development space but also cross my abilities with Data Science and possibly specialize in AI. I believe I am capable of using all of my skills to one day create something impactful for people worldwide in positive ways.
""")
                        .foregroundColor(navy)
                        .multilineTextAlignment(.leading)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(lightGray)
                
                // ── Section 2 (navy) ──
                HStack(alignment: .top, spacing: 16) {
                    Image("FitnessPhoto")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(navy, lineWidth: 2)
                        )
                        .shadow(color: Color.white.opacity(0.7), radius: 8)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("My Fitness and Life Goals")
                            .font(.title2).fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text("""
I have always had a passion for fitness and improving my physical health. Over the years, I've worked hard to build strength, endurance, and maintain a healthy lifestyle. My fitness goals include improving my overall strength, hitting personal records in various lifts, and continuing to build muscle and endurance. Staying healthy is a key part of my daily routine, and I look forward to continually pushing myself to achieve more in my fitness journey.
""")
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(navy)
                
                // ── Section 3 (light gray) ──
                HStack(alignment: .top, spacing: 16) {
                    Image("FinancialPhoto")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.white, lineWidth: 2)
                        )
                        .shadow(color: navy.opacity(0.7), radius: 8)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("My Financial Goals")
                            .font(.title2).fontWeight(.bold)
                            .foregroundColor(navy)
                        
                        Text("""
As I grow in my career, I aim to achieve financial independence, focusing on both saving and investing smartly. I aspire to create a secure financial future for myself and my family, and I am always looking for ways to optimize my financial knowledge. In addition to this, I want to help others by offering financial advice once I gain expertise in the field.
""")
                        .foregroundColor(navy)
                        .multilineTextAlignment(.leading)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(lightGray)
                
                // ── Section 4 (navy) ──
                HStack(alignment: .top, spacing: 16) {
                    Image("ExamplePhoto")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(navy, lineWidth: 2)
                        )
                        .shadow(color: Color.white.opacity(0.7), radius: 8)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Setting an Example for the Future")
                            .font(.title2).fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text("""
Setting an example means behaving in a way that others should copy, encouraging them to act similarly. It's a powerful form of leadership and influence, as actions often speak louder than words.
""")
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(navy)
                
                // ── BOTTOM SHIM (light gray) ──
                lightGray
                    .frame(height: 80)
                    .frame(maxWidth: .infinity)
                    .overlay(
                        Text("© 2024 Data Scientist Edgar Colmenero - \"Never Stay Satisfied\"")
                            .font(.caption)
                            .foregroundColor(navy)
                    )
            }
        }
        .background(lightGray)
        .ignoresSafeArea()
    }
}

struct GoalsView_Previews: PreviewProvider {
    static var previews: some View {
        GoalsView()
    }
}
