import UIKit

public protocol ColorPickerViewControllerDelegate: AnyObject {
  func colorPickerViewController(
    _ viewController: ColorPickerViewController,
    didSelect color: UIColor,
    continuously: Bool
  )

  func colorPickerViewControllerDidFinish(
    _ viewController: ColorPickerViewController
  )
}
