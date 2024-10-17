import UIKit
import Core
import ColorPickerFeature

final class ToolbarRouter {
  
  private weak var rootController: UIViewController?

  init(rootController: UIViewController?) {
    self.rootController = rootController
  }
 
  @available(iOS 14.0, *)
  func presentColorPicker(_ delegate: UIColorPickerViewControllerDelegate) {
      let controller = UIColorPickerViewController()
      controller.delegate = delegate
      rootController?.present(controller, animated: true)
  }

  func presentColorPicker(_ delegate: ColorPickerViewControllerDelegate) {
    let controller = ColorPickerViewController()
    controller.delegate = delegate
    rootController?.present(controller, animated: true)
  }

  func showNotImplementedAlert() {
    rootController?.presentAlert(
      message: "This feature not implemented yet",
      title: "Not implemented"
    )
  }
  
}
