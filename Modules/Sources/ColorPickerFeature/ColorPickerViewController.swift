import UIKit
import Core

protocol ColorPickerViewInput: AnyObject {
  func performDismiss()
  func configure(with viewModel: ColorPickerViewModel)
  func hideKeyboard()

  /// Delegate inputs
  func didSelectColor(_ color: UIColor)
  func didFinish()
}

protocol ColorPickerViewOuput: AnyObject {
  func onViewDidLoad()
}

public final class ColorPickerViewController: UIViewController {
  // MARK: - Subviews

  private lazy var blurEffect: UIBlurEffect = .init(
    style: .systemThickMaterial
  )

  private lazy var mainView: ColorPickerView = .init(
    effect: blurEffect
  )

  // MARK: - Public Properties

  public var selectedColor: UIColor {
    get { return viewModel.selectedColor }
    set { viewModel.onColorSelect.perform(with: newValue) }
  }

  public var supportsAlpha: Bool {
    get { return viewModel.supportsAlpha }
    set { viewModel.onSupportAlphaUpdate.perform(with: newValue) }
  }

  public weak var delegate: ColorPickerViewControllerDelegate?

  // MARK: - Private properties

  private let viewOutput: ColorPickerViewOuput
  private var viewModel: ColorPickerViewModel = .initial

  // MARK: - init/deinit

  public init() {
    let presenter = ColorPickerPresenter()
    self.viewOutput = presenter

    super.init(nibName: nil, bundle: nil)

    presenter.view = self
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Override properties

  public override var modalPresentationStyle: UIModalPresentationStyle {
    get { return .formSheet }
    set {}
  }

  // MARK: - VC lifecycle

  public override func loadView() {
    view = mainView
  }

  public override func viewDidLoad() {
    super.viewDidLoad()

    viewOutput.onViewDidLoad()
  }
}

// MARK: - ColorPickerViewInput

extension ColorPickerViewController: ColorPickerViewInput {
  func performDismiss() {
    dismiss(
      animated: true,
      completion: nil
    )
  }

  func configure(with viewModel: ColorPickerViewModel) {
    mainView.configure(with: viewModel)
  }

  func hideKeyboard() {
    mainView.opacityView.percentTextField.resignFirstResponder()
  }

  func didSelectColor(_ color: UIColor) {
    delegate?.colorPickerViewController(
      self,
      didSelect: color,
      continuously: false
    )
  }

  func didFinish() {
    delegate?.colorPickerViewControllerDidFinish(self)
  }
}
