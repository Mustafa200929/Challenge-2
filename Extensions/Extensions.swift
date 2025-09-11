//
//  Extensions.swift
//  Challenge 2
//
//  Created by Mustafa Topiwala on 7/9/25.
//
import SwiftUI
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255,
                            (int >> 8) * 17,
                            (int >> 4 & 0xF) * 17,
                            (int & 0xF) * 17)
        case 6: // RRGGBB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // AARRGGBB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct Colours{
    static let bone = Color(hex: "#DDD8C4")
    static let celadon = Color(hex: "#A3C9A8")
    static let cambridgeBlue1 = Color(hex: "#84B59F")
    static let cambridgeBlue2 = Color(hex: "#69A297")
    static let airForceBlue = Color(hex: "#50808E")
    static let text = Color(hex: "#1C1C1C")
}

let Messages = [
    1: "Tragic. Were you even awake when you did this? I’ve seen toddlers with crayons bring more rebellion to the table.",
    2: "Where has your rebellion gone? Somewhere between safe choices and lost potential, you decided to play it painfully boring.",
    3: "Ah, mediocrity. Not terrible, not impressive-just floating in that lukewarm zone where nobody claps and nobody boos. Forgettable.",
    4: "Okay, okay… you’re nearly there. The spark is showing, but it’s still trapped under hesitation. Don’t tease us-commit.",
    5: "Finally, some taste. You’ve managed to pull it together with style. But don’t get too smug-consistency is harder than a lucky strike."
]

let Pairings = [
    ["denim_top","denim_bottom"],
    ["denim_top","patterned_bottom"],
    ["patterned_top","denim_bottom"],
    ["patterned_top","patterned_bottom"]
]


