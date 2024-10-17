import UIKit
import Core

final class ColorPickerHeaderView: UIView {
  // MARK: - Subviews

  private lazy var eyeDropperButton: UIButton = .init(
    type: .system
  ).apply {
    let configuration: UIImage.SymbolConfiguration = .init(
      font: .systemFont(ofSize: 18, weight: .regular)
    )
    let image: UIImage? = .init(
      systemName: "eyedropper", /// iOS 13+
      withConfiguration: configuration
    )

    $0.tintColor = .white
    $0.setImage(image, for: .normal)
    $0.setTitleColor(.white, for: .normal)
    $0.isHidden = true
  }

  private lazy var titleLabel: UILabel = .init(
    frame: .zero
  ).apply {
    $0.text = "Colors"
    $0.font = .systemFont(ofSize: 17, weight: .semibold)
    $0.numberOfLines = 1
    $0.textAlignment = .center
  }

  private lazy var closeButton: UIButton = .init(
    frame: .zero
  ).apply {
    let image: UIImage? = .init(
      named: "close",
      in: .module,
      with: nil
    )

    $0.setImage(image, for: .normal)
  }

  // MARK: - Properties

  var onDropperTap: Command = .nop
  var onCloseTap: Command = .nop

  // MARK: - init/deinit

  override init(frame: CGRect) {
    super.init(frame: frame)

    setup()
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    let buttonSize: CGFloat = 44

    eyeDropperButton.frame = CGRect(
      x: .zero,
      y: (bounds.height - buttonSize) / 2,
      width: buttonSize,
      height: buttonSize
    )

    closeButton.frame = CGRect(
      x: bounds.width - buttonSize,
      y: (bounds.height - buttonSize) / 2,
      width: buttonSize,
      height: buttonSize
    )

    let titleSize = titleLabel.sizeThatFits(
      CGSize(
        width: .infinity,
        height: bounds.height
      )
    )

    titleLabel.frame = CGRect(
      x: (bounds.width - titleSize.width) / 2,
      y: (bounds.height - titleSize.height) / 2,
      width: titleSize.width,
      height: titleSize.height
    )
  }

  // MARK: - Private methods

  private func setup() {
    isOpaque = false
    backgroundColor = UIColor.clear

    addSubview(eyeDropperButton)
    addSubview(titleLabel)
    addSubview(closeButton)

    eyeDropperButton.addTarget(
      self,
      action: #selector(ColorPickerHeaderView.eyeDropperButtonDidTapped(sender:)),
      for: .touchUpInside
    )

    closeButton.addTarget(
      self,
      action: #selector(ColorPickerHeaderView.closeButtonDidTapped(sender:)),
      for: .touchUpInside
    )
  }

  @objc private func eyeDropperButtonDidTapped(sender: UIButton) {
    onDropperTap.perform()
  }

  @objc private func closeButtonDidTapped(sender: UIButton) {
    onCloseTap.perform()
  }
}
