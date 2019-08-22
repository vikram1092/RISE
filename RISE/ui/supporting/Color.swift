import Foundation
import UIKit

enum ColorGroup {
    case neutral
    case lightBlue
    case darkBlue
    case burple
    case orange
    case green
}

struct Color {
    // MARK: Common colors
    static func defaultFontColor() -> UIColor { return slate() }
    static func defaultBackground() -> UIColor { return Color.white() }
    static func defaultBorderColor() -> UIColor { return Color.colorFromHex(0xE6E6E6) }
    
    // MARK: Category specific colors
    static func shamrock() -> UIColor { return colorFromHex(0x47DDB2) }
    
    static func gold() -> UIColor { return colorFromHex(0xFFBD25) }
    static func rose() -> UIColor { return colorFromHex(0xC26B84) }
    static func lavender() -> UIColor { return colorFromHex(0xAE85D4) }
    static func red() -> UIColor { return colorFromHex(0xFC5D77) }
    
    static func blue() -> UIColor { return colorFromHex(0x0A9ED8) }
    static func green() -> UIColor { return colorFromHex(0x00B1A6) }
    static func lilac() -> UIColor { return colorFromHex(0x7F7CBA) }
    static func fuchsia() -> UIColor { return colorFromHex(0xB5487A) }
    
    // MARK: Interest colors
    static func dislikeRed() -> UIColor { return colorFromHex(0xFF5454) }
    
    // MARK: Neutral
    static func n0() -> UIColor { return colorFromHex(0xF1F3F8) }
    static func n1() -> UIColor { return colorForGroup(.neutral, level: 1) }
    static func n2() -> UIColor { return colorForGroup(.neutral, level: 2) }
    static func n3() -> UIColor { return colorForGroup(.neutral, level: 3) }
    static func n4() -> UIColor { return colorForGroup(.neutral, level: 4) }
    static func n5() -> UIColor { return colorForGroup(.neutral, level: 5) }
    static func n6() -> UIColor { return colorForGroup(.neutral, level: 6) }
    static func n7() -> UIColor { return colorForGroup(.neutral, level: 7) }
    static func n8() -> UIColor { return colorForGroup(.neutral, level: 8) }
    static func n9() -> UIColor { return colorForGroup(.neutral, level: 9) }
    static func n10() -> UIColor { return colorForGroup(.neutral, level: 10) }
    
    // MARK: Light Blue
    static func lb1() -> UIColor { return colorForGroup(.lightBlue, level: 1) }
    static func lb2() -> UIColor { return colorForGroup(.lightBlue, level: 2) }
    static func lb3() -> UIColor { return colorForGroup(.lightBlue, level: 3) }
    static func lb4() -> UIColor { return colorForGroup(.lightBlue, level: 4) }
    static func lb5() -> UIColor { return colorForGroup(.lightBlue, level: 5) }
    static func lb7() -> UIColor { return colorForGroup(.lightBlue, level: 7) }
    static func lb8() -> UIColor { return colorForGroup(.lightBlue, level: 8) }
    static func lb9() -> UIColor { return colorForGroup(.lightBlue, level: 9) }
    
    // MARK: Dark Blue
    static func db2() -> UIColor { return colorForGroup(.darkBlue, level: 2) }
    static func db4() -> UIColor { return colorForGroup(.darkBlue, level: 4) }
    static func db5() -> UIColor { return colorForGroup(.darkBlue, level: 5) }
    static func db6() -> UIColor { return colorForGroup(.darkBlue, level: 6) }
    static func db9() -> UIColor { return colorForGroup(.darkBlue, level: 9) }
    
    // MARK: Burple
    static func bu1() -> UIColor { return colorForGroup(.burple, level: 1) }
    static func bu2() -> UIColor { return colorForGroup(.burple, level: 2) }
    static func bu3() -> UIColor { return colorForGroup(.burple, level: 3) }
    static func bu4() -> UIColor { return colorForGroup(.burple, level: 4) }
    static func bu5() -> UIColor { return colorForGroup(.burple, level: 5) }
    
    // MARK: Orange
    static func o5() -> UIColor { return colorForGroup(.orange, level: 5) }
    static func o6() -> UIColor { return colorForGroup(.orange, level: 6) }
    static func o9() -> UIColor { return colorForGroup(.orange, level: 9) }
    
    // MARK: Green
    static func g4() -> UIColor { return colorForGroup(.green, level: 4) }
    static func g5() -> UIColor { return colorForGroup(.green, level: 5) }
    
    // MARK: Basic
    static func clear() -> UIColor { return UIColor.clear }
    static func white() -> UIColor { return UIColor.white }
    static func black(_ alpha: CGFloat = 1) -> UIColor {
        return UIColor.black.withAlphaComponent(alpha)
    }
    
    static func beige() -> UIColor { return colorFromHex(0xCAAB56) }
    static func offBlack() -> UIColor { return onyx() }
    static func onyx() -> UIColor { return colorFromHex(0x35464B) }
    static func darkGray() -> UIColor { return  colorFromHex(0x979797) }
    static func gray() -> UIColor { return colorFromHex(0x8EA4AD) }
    static func lightGray() -> UIColor { return colorFromHex(0xCBD1D4) }
    static func lighterGray() -> UIColor { return colorFromHex(0xF0F7F9) }
    static func darkGreen() -> UIColor { return colorFromHex(0x19485D) }
    static func offWhite() -> UIColor { return colorFromHex(0xEEF3F5)}
    static func turquoise() -> UIColor { return colorFromHex(0x00B1A6) }
    static func logoShadow() -> UIColor { return colorFromHex(0x0F3F59) }
    static func tabBarUnSelectedTint() -> UIColor { return colorFromHex(0xA9C5CE) }
    static func blueGray() -> UIColor { return colorFromHex(0x3D5055, alpha: 0.75) }
    static func burple() -> UIColor { return colorFromHex(0x8434D6) }
    static func slate() -> UIColor { return colorFromHex(0x333333) }
    
    static func facebookBlue() -> UIColor { return colorFromHex(0x3b5998) }
    
    static func colorForGroup(_ group: ColorGroup, level: Int) -> UIColor {
        let groupDictionary = palette[group]!
        let hex = groupDictionary[level]!
        return self.colorFromHex(hex)
    }
    
    static func colorFromHex(_ hex: Int, alpha: CGFloat = 1) -> UIColor {
        // convert the # color string to RGBA 0-1 values
        //   for example:
        //      0xFFFF00 would translate to:
        //          1.0f red
        //          1.0f green
        //          0.0f blue
        //
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(hex & 0x0000FF) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    static var palette: [ColorGroup : [Int : Int]] = [
        .lightBlue: [
            1: 0x002330,
            2: 0x004561,
            3: 0x006891,
            4: 0x008AC2,
            5: 0x00ADF2,
            7: 0x61CEF7,
            8: 0x97DFFB,
            9: 0xD3F2FE
        ],
        .darkBlue: [
            2: 0x00202D,
            4: 0x003F58,
            5: 0x00506F,
            6: 0x2F728B,
            9: 0xCBDCE2
        ],
        .burple: [
            1: 0xF2EAFA,
            2: 0xAF79E9,
            3: 0x8434D6,
            4: 0x6105C4,
            5: 0x5702AF
        ],
        .neutral: [
            1: 0x394245,
            2: 0x556367,
            3: 0x708389,
            4: 0x8EA4AD,
            5: 0xA9C5CE,
            6: 0xB9D1D9,
            7: 0xCBDCE3,
            8: 0xDCE8EC,
            9: 0xEEF3F5,
            10: 0xF5F9FA
        ],
        .orange: [
            5: 0xFF8600,
            6: 0xFF9E1E,
            9: 0xFFE8CB
        ],
        .green: [
            4: 0x009F65,
            5: 0x00C87B
        ]
    ]
}

extension UIColor {
    func isWhite() -> Bool {
        return self == Color.white()
    }
    
    func withAlpha(_ alpha: CGFloat) -> UIColor {
        return self.withAlphaComponent(alpha)
    }
}
