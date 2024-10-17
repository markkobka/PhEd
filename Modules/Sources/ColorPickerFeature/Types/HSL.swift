import Foundation
import CoreGraphics

struct HSL: Hashable {
  let hue: CGFloat
  let saturation: CGFloat
  let lightness: CGFloat
  
  var rgb: RGB {
    return convertToRGB()
  }
  
  private func convertToRGB() -> RGB {
    if saturation == 0 {
      return RGB(red: lightness, green: lightness, blue: lightness)
    }
    
    let q: CGFloat = lightness < 0.5
      ? lightness * (1 + saturation)
      : lightness + saturation - lightness * saturation
    let p: CGFloat = 2 * lightness - q
    
    let red: CGFloat = hue2rgb(
      p: p,
      q: q,
      t: hue + 1/3
    )
    let green: CGFloat = hue2rgb(
      p: p,
      q: q,
      t: hue
    )
    let blue: CGFloat = hue2rgb(
      p: p,
      q: q,
      t: hue - 1/3
    )
    return RGB(red: red, green: green, blue: blue)
  }
  
  private func hue2rgb(
    p: CGFloat,
    q: CGFloat,
    t: CGFloat
  ) -> CGFloat {
    var tempT = t
    
    if tempT < 0 {
      tempT += 1
    }
    
    if tempT > 1 {
      tempT -= 1
    }
    
    if tempT < 1/6 {
      return p + (q - p) * 6 * tempT
    }
    
    if tempT < 1/2 {
      return q
    }
    
    if tempT < 2/3 {
      return p + (q - p) * (2/3 - tempT) * 6
    }
    
    return p
  }
}
