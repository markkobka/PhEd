import UIKit

extension UIColor {
  func convert(
    to colorSpaceName: CFString
  ) -> UIColor? {
    guard let toColorSpace = CGColorSpace(name: colorSpaceName)
    else { return nil }
    
    let targetCGColor = cgColor.converted(
      to: toColorSpace,
      intent: .defaultIntent,
      options: nil
    )
    
    if let cgColor = targetCGColor {
      return UIColor(cgColor: cgColor)
    }
    
    return nil
  }
}
