//
//  File.swift
//  
//
//  Created by Maxim Timokhin on 16.10.2022.
//

import UIKit

protocol ShapeViewModel {
  var title: String { get }
  var icon: UIImage? { get }
}

// MARK: - ToolbarState.Shape + ShapeViewModel
extension ToolbarState.Shape: ShapeViewModel {
  var title: String {
    switch self {
    case .rectangle:
      return "Rectangle"
    case .ellipse:
      return "Ellipse"
    case .bubble:
      return "Bubble"
    case .star:
      return "Star"
    case .arrow:
      return "Arrow"
    }
  }
  
  var icon: UIImage? {
    switch self {
    case .rectangle:
      return UIImage(named: "shapeRectangle", in: .module, with: nil)
    case .ellipse:
      return UIImage(named: "shapeEllipse", in: .module, with: nil)
    case .bubble:
      return UIImage(named: "shapeBubble", in: .module, with: nil)
    case .star:
      return UIImage(named: "shapeStar", in: .module, with: nil)
    case .arrow:
      return UIImage(named: "shapeArrow", in: .module, with: nil)
    }
  }
  
  
}
