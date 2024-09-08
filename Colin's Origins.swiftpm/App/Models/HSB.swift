import CoreGraphics

struct HSB {
    
    
    
    // MARK: - Properties
    
    let hue: CGFloat
    let saturation: CGFloat
    let brightness: CGFloat
    
    
    
    // MARK: - Private Properties
    
    private var red: CGFloat {
        let c = saturation * brightness
        let h = hue * 6
        let m = brightness - c
        let x = c * (1 - abs(h.truncatingRemainder(dividingBy: 2) - 1))
        switch h {
        case 0..<1: return c + m
        case 1..<2: return x + m
        case 2..<3: return 0 + m
        case 3..<4: return 0 + m
        case 4..<5: return x + m
        case 5..<6: return c + m
        default: return 0
        }
    }
    
    private var green: CGFloat {
        let c = saturation * brightness
        let h = hue * 6
        let m = brightness - c
        let x = c * (1 - abs(h.truncatingRemainder(dividingBy: 2) - 1))
        switch h {
        case 0..<1: return x + m
        case 1..<2: return c + m
        case 2..<3: return c + m
        case 3..<4: return x + m
        case 4..<5: return 0 + m
        case 5..<6: return 0 + m
        default: return 0
        }
    }
    
    private var blue: CGFloat {
        let c = saturation * brightness
        let h = hue * 6
        let m = brightness - c
        let x = c * (1 - abs(h.truncatingRemainder(dividingBy: 2) - 1))
        switch h {
        case 0..<1: return 0 + m
        case 1..<2: return 0 + m
        case 2..<3: return x + m
        case 3..<4: return c + m
        case 4..<5: return c + m
        case 5..<6: return x + m
        default: return 0
        }
    }
    
    
    
    // MARK: - Methods
    
    func adding(to color: HSB) -> HSB {
        let r = min(red + color.red, 1)
        let g = min(green + color.green, 1)
        let b = min(blue + color.blue, 1)
        return HSB(hue: hue(r, g, b), saturation: saturation(r, g, b), brightness: brightness(r, g, b))
    }
    
    
    
    // MARK: - Private Methods
    
    private func hue(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> CGFloat {
        let max = max(red, green, blue)
        let min = min(red, green, blue)
        let c = max - min
        var h: CGFloat = 0
        switch max {
        case min: h = 0
        case red: h = ((green - blue) / c).truncatingRemainder(dividingBy: 6)
        case green: h = (blue - red) / c + 2
        case blue: h = (red - green) / c + 4
        default: h = 0
        }
        return (h / 6 < 0) ? (h / 6 + 1) : (h / 6)
    }
    
    private func saturation(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> CGFloat {
        let max = max(red, green, blue)
        let min = min(red, green, blue)
        let c = max - min
        return max == 0 ? 0 : c / max
    }
    
    private func brightness(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> CGFloat {
        let max = max(red, green, blue)
        return max
    }
    
}
