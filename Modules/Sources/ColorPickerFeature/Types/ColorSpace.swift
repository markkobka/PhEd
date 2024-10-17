import Foundation
import CoreGraphics

enum ColorSpace: Hashable {
  case sRGB
  case displayP3
  
  var name: CFString {
    switch self {
    case .sRGB:
      return CGColorSpace.sRGB
    case .displayP3:
      return CGColorSpace.displayP3
    }
  }
}
