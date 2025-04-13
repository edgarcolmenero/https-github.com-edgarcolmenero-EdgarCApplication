import SwiftUI

// ─ MARK: — Elbow‐Style Connector Lines ─────────────────────────────
// ─ MARK: — Elbow‐Style Connector Lines ─────────────────────────────
// ─ MARK: — Elbow‐Style Connector Lines with Full-Width Tops & Bottoms ──
struct ContactConnector: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // shorthand
        let W = rect.width
        let H = rect.height

        // key Y positions
        let topY   = 0.15 * H
        let midY   = 0.45 * H
        let botY   = 0.75 * H
        let endY   = H

        // 1) full-width top line
        path.move(to: CGPoint(x: rect.minX, y: topY))
        path.addLine(to: CGPoint(x: rect.maxX, y: topY))

        // 2) Elbow connections
        let snapX     = 0.20 * W
        let instaX    = 0.50 * W
        let tikTokX   = 0.80 * W

        let linkedinX = 0.30 * W
        let emailX    = 0.70 * W
        
        let phoneX    = instaX

        // Instagram down to the two midboxes
        // Left elbow
        path.move(to: CGPoint(x: instaX, y: topY))
        path.addLine(to: CGPoint(x: instaX, y: midY))
        path.addLine(to: CGPoint(x: linkedinX, y: midY))
        // Right elbow
        path.move(to: CGPoint(x: instaX, y: topY))
        path.addLine(to: CGPoint(x: instaX, y: midY))
        path.addLine(to: CGPoint(x: emailX, y: midY))

        // Top row: connect out to Snapchat/TikTok
        path.move(to: CGPoint(x: instaX, y: topY))
        path.addLine(to: CGPoint(x: snapX, y: topY))
        path.move(to: CGPoint(x: instaX, y: topY))
        path.addLine(to: CGPoint(x: tikTokX, y: topY))

        // Mid row down to phone
        // Left side
        path.move(to: CGPoint(x: linkedinX, y: midY))
        path.addLine(to: CGPoint(x: linkedinX, y: botY))
        path.addLine(to: CGPoint(x: phoneX, y: botY))
        // Right side
        path.move(to: CGPoint(x: emailX, y: midY))
        path.addLine(to: CGPoint(x: emailX, y: botY))
        path.addLine(to: CGPoint(x: phoneX, y: botY))

        // 3) Phone down to bottom
        path.move(to: CGPoint(x: phoneX, y: botY))
        path.addLine(to: CGPoint(x: phoneX, y: endY))

        // 4) full-width bottom line
        path.move(to: CGPoint(x: rect.minX, y: endY))
        path.addLine(to: CGPoint(x: rect.maxX, y: endY))

        return path
    }
}


struct ContactView: View {
    // your colors
    private let navy      = Color(red:   0/255, green: 31/255, blue: 63/255)
    private let lightGray = Color(red: 0.95, green: 0.95, blue: 0.95)

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                
                // ── TOP SHIM (blank) ──
                lightGray
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                
                // ── CONNECTORS + ICON GRID ──
                GeometryReader { geo in
                    ZStack {
                        // 1) connector lines
                        ContactConnector()
                            .stroke(Color.white, lineWidth: 2)
                            .shadow(color: navy.opacity(0.7), radius: 8)
                        
                        // 2) Snapchat
                        VStack(spacing: 4) {
                            Link(destination: URL(string: "https://snapchat.com/t/NUipAhtg")!) {
                                Image("SnapchatIcon")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 75, height: 75)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.white, lineWidth: 2)
                                    )
                                    .shadow(color: navy.opacity(0.7), radius: 8)
                            }
                            Text("Snapchat")
                                .font(.caption)
                                .foregroundColor(navy)
                        }
                        .position(
                            x: geo.size.width * 0.20,
                            y: geo.size.height * 0.15
                        )
                        
                        // 3) TikTok
                        VStack(spacing: 4) {
                            Link(destination: URL(string: "https://www.tiktok.com/@edgarcolmeneroo?_t=ZT-8vzGDf8Me2Y&_r=1")!) {
                                Image("TikTokIcon")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 75, height: 75)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.white, lineWidth: 2)
                                    )
                                    .shadow(color: navy.opacity(0.7), radius: 8)
                            }
                            Text("TikTok")
                                .font(.caption)
                                .foregroundColor(navy)
                        }
                        .position(
                            x: geo.size.width * 0.80,
                            y: geo.size.height * 0.15
                        )
                        
                        // 4) Instagram (top-center)
                        VStack(spacing: 4) {
                            Link(destination: URL(string: "https://www.instagram.com/edgarcolmenero?igsh=NnQ4Z2Z6d2s2YjI5&utm_source=qr")!) {
                                Image("InstagramIcon")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 75, height: 75)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.white, lineWidth: 2)
                                    )
                                    .shadow(color: navy.opacity(0.7), radius: 8)
                            }
                            Text("Instagram")
                                .font(.caption)
                                .foregroundColor(navy)
                        }
                        .position(
                            x: geo.size.width * 0.50,
                            y: geo.size.height * 0.15
                        )
                        
                        // 5) LinkedIn (middle-left)
                        VStack(spacing: 4) {
                            Link(destination: URL(string: "https://www.linkedin.com/in/edgar-colmenero-385b6125b?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=ios_app")!) {
                                Image("LinkedInIcon")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 75, height: 75)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.white, lineWidth: 2)
                                    )
                                    .shadow(color: navy.opacity(0.7), radius: 8)
                            }
                            Text("LinkedIn")
                                .font(.caption)
                                .foregroundColor(navy)
                        }
                        .position(
                            x: geo.size.width * 0.30,
                            y: geo.size.height * 0.45
                        )
                        
                        // 6) Email (middle-right)
                        VStack(spacing: 4) {
                            Link(destination: URL(string: "mailto:edgarcolmenero15@gmail.com")!) {
                                Image("EmailIcon")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 75, height: 75)
                                    .background(Color.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.white, lineWidth: 2)
                                    )
                                    .shadow(color: navy.opacity(0.7), radius: 8)
                            }
                            Text("Email")
                                .font(.caption)
                                .foregroundColor(navy)
                        }
                        .position(
                            x: geo.size.width * 0.70,
                            y: geo.size.height * 0.45
                        )
                        
                        // 7) Phone (bottom-center)
                        VStack(spacing: 4) {
                            Link(destination: URL(string:
                                                    "tel:+15105191128")!) {
                                Image("PhoneIcon")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 75, height: 75)
                                    .foregroundColor(.white)
                                    .background(navy)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(Color.white, lineWidth: 2)
                                    )
                                    .shadow(color: navy.opacity(0.7), radius: 8)
                            }
                            Text("Phone")
                                .font(.caption)
                                .foregroundColor(navy)
                        }
                        .position(
                            x: geo.size.width * 0.50,
                            y: geo.size.height * 0.75
                        )
                    }
                }
                .frame(height: 600) // adjust as needed

                // ── SHIM: How to Connect with Me ──
                lightGray
                    .frame(height: 125)
                    .frame(maxWidth: .infinity)
                    .overlay(
                        VStack(spacing: 8) {
                            Text("How to Connect with Edgar Colmenero")
                                .font(.headline)
                                .foregroundColor(navy)

                            Text("Thank you for taking the time to get to know me!")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    )

                
                // ── BOTTOM SHIM with copyright ──
                lightGray
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .overlay(
                        Text("© 2024 Data Scientist Edgar Colmenero ― “Never Stay Satisfied”")
                            .font(.caption)
                            .foregroundColor(navy)
                    )
            }
        }
        .background(lightGray)
        .ignoresSafeArea()
    }
}

struct ContactView_Previews: PreviewProvider {
    static var previews: some View {
        ContactView()
    }
}
