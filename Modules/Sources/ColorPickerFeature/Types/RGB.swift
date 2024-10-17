import Foundation
import CoreGraphics

struct RGB: Hashable {
  let red: CGFloat
  let green: CGFloat
  let blue: CGFloat
  
  var hsl: HSL {
    return convertToHSL()
  }
  
  private func convertToHSL() -> HSL {
    let max: CGFloat = max(max(red, green), blue)
    let min: CGFloat = min(min(red, green), blue)
    
    let defaultValue = (max + min) / 2
    
    var hue: CGFloat = defaultValue
    var saturation: CGFloat = defaultValue
    
    let lightness: CGFloat = defaultValue
    
    if max == min {
      hue = 0
      saturation = 0
      return HSL(hue: hue, saturation: saturation, lightness: lightness)
    }
    
    let d: CGFloat = max - min
    
    saturation = lightness > 0.5
      ? d / (2 - max - min)
      : d / (max + min)
    
    if max == red {
      hue = (green - blue) / d + (green < blue ? 6 : 0)
    } else if max == green {
      hue = (blue - red) / d + 2
    } else if max == blue {
      hue = (red - green) / d + 4
    }
    
    hue /= 6
    
    return HSL(hue: hue, saturation: saturation, lightness: lightness)
  }
}
