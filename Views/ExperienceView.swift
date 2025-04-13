import SwiftUI

struct ExperienceView: View {
    // Reuse your “one true navy” and light-gray
    private let navy      = Color(red:   0/255, green: 31/255, blue: 63/255)
    private let lightGray = Color(red: 0.95, green: 0.95, blue: 0.95)

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {

                // ── TOP SHIM (blank) ── doubled height (50 pt)
                lightGray
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)

                // ── Byron Nelson Highschool (light gray) ──
                HStack(alignment: .center, spacing: 16) {      // <-- center alignment
                    Image("ByronPhoto")
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
                        Text("Byron Nelson Highschool – Highschool Diploma")
                            .font(.headline)
                            .foregroundColor(navy)

                        Text("""
                        At Byron Nelson High School, I was a multi-sport athlete and a member of the Spanish National Honor Society. Balancing academics, athletics, and leadership taught me discipline, time management, and resilience. Managing these responsibilities shaped my work ethic and helped lay the foundation for who I am today—driven, focused, and committed to growth.
                        """)
                        .foregroundColor(navy)
                        .multilineTextAlignment(.leading)
                    }
                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(lightGray)

                // ── Tarrant County College (navy) ──
                HStack(alignment: .center, spacing: 16) {
                    Image("TCCPhoto")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(navy, lineWidth: 2)
                        )
                        .shadow(color: .white.opacity(0.7), radius: 8)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Tarrant County College – Computer Science Transfer")
                            .font(.headline)
                            .foregroundColor(.white)

                        Text("I’m in my final semester at Tarrant County College’s Trinity River Campus, where supportive professors, free tutoring, and affordable classes have shaped my academic success. The safe, welcoming environment and helpful student services have made my experience both enriching and empowering.")
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                    }
                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(navy)

                // ── UTA (light gray) ──
                HStack(alignment: .center, spacing: 16) {
                    Image("UTAPhoto")
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
                        Text("University of Texas at Arlington – Computer Science Major")
                            .font(.headline)
                            .foregroundColor(navy)

                        Text("I look forward to starting at the University of Texas at Arlington in fall 2025. UTA’s strong academics, diverse community, and excellent resources make it an exciting next step. I’m motivated to grow, learn, and make the most of the opportunities this respected university offers.")
                            .foregroundColor(navy)
                            .multilineTextAlignment(.leading)
                    }
                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(lightGray)

                // ── Wells Fargo (navy) ──
                HStack(alignment: .center, spacing: 16) {
                    Image("WellsFargoPhoto")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(navy, lineWidth: 2)
                        )
                        .shadow(color: .white.opacity(0.7), radius: 8)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Wells Fargo – Bilingual Financial Services Representative")
                            .font(.headline)
                            .foregroundColor(.white)

                        Text("At Wells Fargo, I worked as a Bilingual Financial Services Representative, assisting customers with financial transactions and supporting Spanish-speaking clients. This role sharpened my customer service skills, attention to detail, and ability to work under pressure while building trust with a diverse clientele.")
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                    }
                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(navy)

                // ── Walmart (light gray) ──
                HStack(alignment: .center, spacing: 16) {
                    Image("WalmartPhoto")
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
                        Text("Walmart – Electronics/Seasonal Team Lead")
                            .font(.headline)
                            .foregroundColor(navy)

                        Text("At Walmart, I worked as a Team Lead, where I developed strong leadership and organizational skills in a fast-paced setting. I managed team dynamics, ensured smooth operations, and maintained high standards of customer service. This experience strengthened my communication, teamwork, and problem-solving abilities, shaping me into a more adaptable and effective leader.")
                            .foregroundColor(navy)
                            .multilineTextAlignment(.leading)
                    }
                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(lightGray)

                // ── CVS Pharmacy (navy) ──
                HStack(alignment: .center, spacing: 16) {
                    Image("CVSPhoto")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(navy, lineWidth: 2)
                        )
                        .shadow(color: .white.opacity(0.7), radius: 8)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("CVS Pharmacy – Shift Lead")
                            .font(.headline)
                            .foregroundColor(.white)

                        Text("At CVS Pharmacy, I worked as a Shift Lead, overseeing daily operations and supporting team performance in a fast-paced environment. The role improved my leadership, communication, and problem-solving skills, helping me become a confident and dependable leader focused on teamwork and efficiency.")
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                    }
                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(navy)

                // ── BOTTOM SHIM with copyright ── 2.25× height (56.25 pt)
                lightGray
                    .frame(height: 80)
                    .frame(maxWidth: .infinity)
                    .overlay(
                        Text("© 2024 Data Scientist Edgar Colmenero – “Never Stay Satisfied”")
                            .font(.caption)
                            .foregroundColor(navy)
                    )
            }
        }
        .background(lightGray)
        .ignoresSafeArea()
    }
}

struct ExperienceView_Previews: PreviewProvider {
    static var previews: some View {
        ExperienceView()
    }
}
