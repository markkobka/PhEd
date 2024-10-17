//
//  File.swift
//  
//
//  Created by Maxim Timokhin on 15.10.2022.
//

import UIKit

enum TextStyleButtonViewModel {
  case `default`
  case filled
  case semi
  case stroke
  
  var image: UIImage? {
    switch self {
    case .default:
      return UIImage(named: "TextDefault", in: .module, compatibleWith: nil)
    case .filled:
      return UIImage(named: "TextFilled", in: .module, compatibleWith: nil)
    case .semi:
      return UIImage(named: "TextSemi", in: .module, compatibleWith: nil)
    case .stroke:
      return UIImage(named: "TextStroke", in: .module, compatibleWith: nil)
    }
  }
}

enum TextAlignmentButtonViewModel {
  case left
  case right
  case center
  
  var iconSize: CGSize {
    .init(width: 20, height: 20)
  }
}

struct TextBarViewModel {
  let style: TextStyleButtonViewModel
  let alignment: TextAlignmentButtonViewModel
}

// MARK: - ToolbarState.Font + ViewModels
extension TextStyleButtonViewModel {
  init(_ font: ToolbarState.Font) {
    switch font.style {
    case .default:
      self = .default
    case .filled:
      self = .filled
    case .semi:
      self = .semi
    case .stroke:
      self = .stroke
    }
  }
}

extension TextAlignmentButtonViewModel {
  init(_ font: ToolbarState.Font) {
    switch font.alignment {
    case .left:
      self = .left
    case .right:
      self = .right
    case .center:
      self = .center
    default:
      self = .left
    }
  }
}
