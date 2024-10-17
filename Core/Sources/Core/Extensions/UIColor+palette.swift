//
//  File.swift
//  
//
//  Created by Maxim Timokhin on 11.10.2022.
//

import UIKit

public extension UIColor {
  
  static func fromPalette(_ name: PalleteColor) -> UIColor? {
    .init(named: name.rawValue, in: .module, compatibleWith: nil)
  }
  
  enum PalleteColor: String {
    case background
    case grey1
    case grey2
    case text
    case handleColor
    case trackColor
  }
  
}
