import Core
import UIKit

final class ColorPickerOpacityView: UIView {
  // MARK: - Subviews

  private lazy var titleLabel: UILabel = .init(
    frame: .zero
  ).apply {
    $0.text = "OPACITY"
    $0.textColor = UIColor(hexP3: "EBEBF5")?.withAlphaComponent(0.6)
    $0.textAlignment = .left
    $0.numberOfLines = 1
    $0.font = .systemFont(ofSize: 13, weight: .semibold)
  }

  private lazy var sliderView: AlphaColorSlider = .init(
    frame: .zero
  ).apply {
    $0.layer.cornerRadius = 18
    $0.layer.masksToBounds = true
  }

  private lazy var textFieldContainerView: UIView = .init(
    frame: .zero
  ).apply {
    $0.layer.cornerRadius = 8
    $0.layer.masksToBounds = true
    $0.backgroundColor = UIColor.black.withAlphaComponent(0.5)
  }

  private(set) lazy var percentTextField: UITextField = .init(
    frame: .zero
  ).apply {
    $0.textAlignment = .center
    $0.keyboardType = .decimalPad
    $0.textColor = UIColor.white
    $0.font = .systemFont(ofSize: 17, weight: .semibold)
    $0.backgroundColor = UIColor.clear
    $0.inputAccessoryView = toolbar
    $0.delegate = self
  }

  private lazy var percentLabel: UILabel = .init(
    frame: .zero
  ).apply {
    $0.text = "%"
    $0.font = .systemFont(ofSize: 17, weight: .semibold)
    $0.textColor = UIColor.white
    $0.numberOfLines = 1
  }

  private lazy var separatorView: UIView = .init(
    frame: .zero
  ).apply {
    $0.isUserInteractionEnabled = false
    $0.backgroundColor = UIColor(hexP3: "48484A")
  }

  private lazy var toolbar: UIToolbar = .init(
    frame: .zero
  ).apply {
    $0.barStyle = .default
    $0.isOpaque = false
    $0.isUserInteractionEnabled = true

    let space = UIBarButtonItem(
      barButtonSystemItem: .flexibleSpace,
      target: nil,
      action: nil
    )
    let doneButton = UIBarButtonItem(
      title: "Done",
      style: .done,
      target: self,
      action: #selector(ColorPickerOpacityView.doneButtonDidTapped)
    )
    doneButton.tintColor = UIColor.systemBlue

    $0.setItems([space, doneButton], animated: false)
    $0.sizeToFit()
  }

  // MARK: - Properties

  var onAlphaValueChange: CommandWith<String> = .nop

  var onAlphaChange: CommandWith<CGFloat> = .nop {
    didSet { sliderView.onValueChange = onAlphaChange }
  }

  // MARK: - init/deinit

  override init(frame: CGRect) {
    super.init(frame: frame)

    setup()
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Public methods

  func setAlpha(_ value: CGFloat) {
    sliderView.currentValue = value

    let string = "\(Int(value * 100))"
    percentTextField.text = string
  }

  func setSelectedColor(_ value: UIColor) {
    sliderView.toColor = value
  }

  // MARK: - Override methods

  override func layoutSubviews() {
    super.layoutSubviews()

    titleLabel.frame = CGRect(
      x: 4,
      y: 0,
      width: bounds.width,
      height: Constants.titleHeight
    )

    textFieldContainerView.frame = CGRect(
      x: bounds.width - Constants.textFieldWidth,
      y: titleLabel.frame.maxY + Constants.padding,
      width: Constants.textFieldWidth,
      height: Constants.sliderHeight
    )

    percentTextField.frame = textFieldContainerView.frame.inset(
      by: UIEdgeInsets(
        top: 0,
        left: 10,
        bottom: 0,
        right: 22
      )
    )

    percentLabel.frame = CGRect(
      x: percentTextField.frame.maxX,
      y: percentTextField.frame.minY,
      width: 22,
      height: percentTextField.frame.height
    )

    sliderView.frame = CGRect(
      x: 0,
      y: titleLabel.frame.maxY + Constants.padding,
      width: bounds.width - Constants.textFieldWidth - 12,
      height: Constants.sliderHeight
    )

    separatorView.frame = CGRect(
      x: 0,
      y: sliderView.frame.maxY + Constants.separatorPadding,
      width: bounds.width,
      height: Constants.separatorHeight
    )
  }

  override func sizeThatFits(_ size: CGSize) -> CGSize {
    let totalHeight = (
      Constants.titleHeight +
      Constants.padding +
      Constants.sliderHeight +
      Constants.separatorPadding +
      Constants.separatorHeight
    )

    return CGSize(
      width: size.width,
      height: totalHeight
    )
  }

  // MARK: - Private methods

  private func setup() {
    isOpaque = false
    backgroundColor = UIColor.clear

    addSubview(titleLabel)
    addSubview(sliderView)
    addSubview(textFieldContainerView)
    addSubview(percentTextField)
    addSubview(percentLabel)
    addSubview(separatorView)
  }

  @objc private func doneButtonDidTapped() {
    percentTextField.resignFirstResponder()
  }
}

// MARK: - UITextFieldDelegate

extension ColorPickerOpacityView: UITextFieldDelegate {
  func textField(
    _ textField: UITextField,
    shouldChangeCharactersIn range: NSRange,
    replacementString string: String
  ) -> Bool {
    guard let text = percentTextField.text,
          let textRange = Range(range, in: text)
    else {
      onAlphaValueChange.perform(with: "")
      return false
    }

    let finalString = text.replacingCharacters(
      in: textRange,
      with: string
    )
    onAlphaValueChange.perform(with: finalString)

    return false
  }
}

// MARK: - Constants

extension ColorPickerOpacityView {
  enum Constants {
    static var titleHeight: CGFloat {
      return 18
    }

    static var textFieldWidth: CGFloat {
      return 77
    }

    static var padding: CGFloat {
      return 4
    }

    static var sliderHeight: CGFloat {
      return 36
    }

    static var separatorPadding: CGFloat {
      return 20
    }

    static var separatorHeight: CGFloat {
      return 1
    }
  }
}
