//
//  File.swift
//  
//
//  Created by Maxim Timokhin on 14.10.2022.
//

import UIKit

protocol VariantViewModel {
  var title: String { get }
  var icon: UIImage? { get }
}


// MARK: - ToolbarState.Tool.Variant + VariantViewModel
extension ToolbarState.Tool.Variant: VariantViewModel {
  var title: String {
    switch self {
    case .round:
      return "Round"
    case .arrow:
      return "Arrow"
    case .blur:
      return "Blur"
    case .object:
      return "Object"
    case .eraser:
      return "Eraser"
    }
  }
  
  var icon: UIImage? {
    switch self {
    case .round, .eraser:
      return UIImage(named: "roundTip", in: .module, with: nil)
    case .arrow:
      return UIImage(named: "arrowTip", in: .module, with: nil)
    case .blur:
      return UIImage(named: "blurTip", in: .module, with: nil)
    case .object:
      return UIImage(named: "xmarkTip", in: .module, with: nil)
    }
  }
  
}
