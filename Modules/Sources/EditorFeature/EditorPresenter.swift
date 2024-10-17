//
//  File.swift
//  
//
//  Created by Maxim Timokhin on 16.10.2022.
//

import Foundation
import ToolbarFeature
import CanvasFeature
import TextEditFeature
import UIKit

public protocol Editor: AnyObject {
  func setImage(_ image: UIImage?)
}

public protocol EditorDelegate: AnyObject {
  func editorDidCancel(_ editor: Editor)
  func editor(_ editor: Editor, didFinishWith image: CGImage?)
}

final class EditorPresenter: NSObject, Editor {
  weak var view: EditorViewInput?
  
  weak var delegate: EditorDelegate?
  
  // MARK: - Editor
  func setImage(_ image: UIImage?) {
    view?.setImage(image)
  }

}


// MARK: - EditorViewOutput
extension EditorPresenter: EditorViewOutput {
  
  func onViewDidLoad() {
    
  }
  
}

extension EditorPresenter: ToolbarDelegate {
    
  func toolBarHasChanges(_ toolbar: Toolbar) {
    let toolbarTool = toolbar.selectedTool
    let color = toolbarTool.color ?? .white
    let strokeSize = toolbarTool.strokeSize
    
    let tipType: TipType = toolbarTool.variant == .arrow ? .arrow : .default
    
    view?.setTextAlignment(toolbar.font.alignment)
    view?.setTextColor(toolbar.color ?? .white)
    view?.setFontStyle(toolbar.font.style.textStyle)
    view?.setTextEditVisible(toolbar.mode == .texting)
    
    switch toolbarTool.tool {
    case .brush:
      view?.setTool(.brush(
        strokeSize: strokeSize,
        color: color,
        tipType: tipType
      ))
    case .pencil:
      view?.setTool(.pencil(
        strokeSize: strokeSize,
        color: color,
        tipType: tipType
      ))
    case .marker:
      view?.setTool(.marker(
        strokeSize: strokeSize,
        color: color,
        tipType: tipType
      ))
    case .neon:
      view?.setTool(.neon(
        strokeSize: strokeSize,
        color: color,
        tipType: tipType
      ))
    case .lasso:
      break
    case .eraser:
      switch toolbarTool.variant {
      case .eraser:
        view?.setTool(.erase(strokeSize: strokeSize))
      case .blur:
        view?.setTool(.blur(strokeSize: strokeSize))
      default:
        break
      }
    }
  }
  
  func toolbarDidTapCancelButton(_ toolbar: Toolbar) {
    delegate?.editorDidCancel(self)
  }
  
  func toolbarDidTapDownloadButton(_ toolbar: ToolbarFeature.Toolbar) {
      guard let image = view?.getImage()
      else { return }
      delegate?.editor(self, didFinishWith: image)
  }
}

extension ToolbarState.Font.Style {
  var textStyle: TextEditView.FontStyle {
    switch self {
    case .default:
      return .default
    case .filled:
      return .filled
    case .semi:
      return .semi
    case .stroke:
      return .stroke
    }
  }
}
