//
//  File.swift
//  
//
//  Created by Maxim Timokhin on 10.10.2022.
//

import UIKit

protocol ToolBarItemViewModel {
  var color: UIColor? { get }
  var strokeSize: CGFloat { get }
  var minStrokeSize: CGFloat { get }
  var maxStrokeSize: CGFloat { get }
  var baseImage: UIImage? { get }
  var baseSize: CGSize { get }
  var tipImage: UIImage? { get }
  var accentOffset: CGFloat { get }
  var hSpacing: CGFloat { get }
}

// MARK: - ToolbarState.Tool + ToolBarItemViewModel
extension ToolbarState.Tool: ToolBarItemViewModel {
  var baseImage: UIImage? {
    switch tool {
    case .brush:
      return UIImage(named: "BasePen", in: .module, with: nil)
    case .pencil:
      return UIImage(named: "BasePencil", in: .module, with: nil)
    case .marker:
      return UIImage(named: "BaseBrush", in: .module, with: nil)
    case .neon:
      return UIImage(named: "BaseNeon", in: .module, with: nil)
    case .lasso:
      return UIImage(named: "BaseLasso", in: .module, with: nil)
    case .eraser:
      switch variant {
      case .blur:
        return UIImage(named: "BaseBlurEraser", in: .module, with: nil)
      case .object:
        return UIImage(named: "BaseObjectEraser", in: .module, with: nil)
      default:
        return UIImage(named: "BaseEraser", in: .module, with: nil)
      }
    }
  }
  
  var baseSize: CGSize {
    CGSize(width: 40, height: 176)
  }
  
  var tipImage: UIImage? {
    switch tool {
    case .brush:
      return UIImage(named: "TipPen", in: .module, with: nil)
    case .pencil:
      return UIImage(named: "TipPencil", in: .module, with: nil)
    case .marker:
      return UIImage(named: "TipBrush", in: .module, with: nil)
    case .neon:
      return UIImage(named: "TipNeon", in: .module, with: nil)
    case .lasso:
      return nil
    case .eraser:
      return nil
    }
  }
      
  var accentOffset: CGFloat {
    0.56
  }
  
  var hSpacing: CGFloat {
    0.3
  }
  
}
