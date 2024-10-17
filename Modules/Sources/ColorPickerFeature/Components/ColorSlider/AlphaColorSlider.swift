import Core
import UIKit

final class AlphaColorSlider: UIView {
  // MARK: - Subviews

  private lazy var patternView: PatternView = .init(
    frame: .zero
  )

  private lazy var gradientLayer: CAGradientLayer = .init()
    .apply {
      $0.colors = [fromColor.cgColor, toColor.cgColor]
      $0.startPoint = CGPoint(x: 0, y: 0.5)
      $0.endPoint = CGPoint(x: 1, y: 0.5)
    }

  private lazy var pickerView: UIView = .init(
    frame: .zero
  ).apply {
    $0.layer.cornerRadius = 15
    $0.layer.masksToBounds = true
    $0.layer.borderWidth = 3
    $0.layer.borderColor = UIColor.white.cgColor
    $0.backgroundColor = toColor
    $0.isUserInteractionEnabled = false
  }

  // MARK: - Properties

  private var fromColor: UIColor = UIColor.clear {
    didSet { updateGradient() }
  }

  var toColor: UIColor = UIColor.clear  {
    didSet { updateGradient() }
  }

  private var minValue: CGFloat = 0
  private var maxValue: CGFloat = 1

  var currentValue: CGFloat = 0 {
    didSet {
      pickerView.frame = rectForPicker(from: currentValue)
    }
  }

  var onValueChange: CommandWith<CGFloat> = .nop

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

    patternView.frame = bounds
    gradientLayer.frame = bounds

    pickerView.frame = rectForPicker(from: currentValue)
  }

  // MARK: - Private methods

  private func setup() {
    isOpaque = false
    backgroundColor = UIColor.clear

    addSubview(patternView)
    addSubview(pickerView)
    patternView.layer.addSublayer(gradientLayer)

    let tapGesture: UITapGestureRecognizer = .init(
      target: self,
      action: #selector(AlphaColorSlider.handleTapGesture(sender:))
    )
    let panGesture: UIPanGestureRecognizer = .init(
      target: self,
      action: #selector(AlphaColorSlider.handlePanGesture(sender:))
    )
    let pressGesture: UILongPressGestureRecognizer = .init(
      target: self,
      action: #selector(AlphaColorSlider.handlePressGesture(sender:))
    )

    addGestureRecognizer(tapGesture)
    addGestureRecognizer(panGesture)
    addGestureRecognizer(pressGesture)
  }

  private func updateGradient() {
    CATransaction.begin()
    CATransaction.setDisableActions(true)
    gradientLayer.colors = [
      fromColor.cgColor,
      toColor.withAlphaComponent(1).cgColor
    ]
    pickerView.backgroundColor = toColor.withAlphaComponent(1)
    CATransaction.commit()
  }

  private func rectForPicker(from location: CGPoint) -> CGRect {
    var location = location

    let size = CGSize(width: 30, height: 30)
    let offset = size.width / 2

    location.x = location.x - offset < 3
    ? 3 + offset
    : location.x

    location.x = location.x + offset > bounds.width - 3
    ? bounds.width - 3 - offset
    : location.x

    location.y = 3

    let origin = location.applying(
      CGAffineTransform(
        translationX: -offset,
        y: 0
      )
    )

    return CGRect(origin: origin, size: size)
  }

  private func rectForPicker(from value: CGFloat) -> CGRect {
    let x = value * bounds.width
    let location = CGPoint(x: x, y: 3)

    return rectForPicker(from: location)
  }

  private func value(from location: CGPoint) -> CGFloat {
    let width = bounds.width
    let x = location.x

    return x / width
  }

  @objc private func handleTapGesture(
    sender: UITapGestureRecognizer
  ) {
    guard let _ = sender.view, sender.state == .ended
    else { return }

    let location = sender.location(in: self)

    currentValue = value(from: location)
    pickerView.frame = rectForPicker(from: location)

    onValueChange.perform(with: currentValue)
  }

  @objc private func handlePanGesture(
    sender: UIPanGestureRecognizer
  ) {
    guard let _ = sender.view
    else { return }
    
    guard sender.state == .changed || sender.state == .began
    else { return }

    var location = sender.location(in: self)

    if sender.state == .changed, bounds.contains(location) == false {
      let x: CGFloat
      let y: CGFloat
      
      if location.x < bounds.minX {
        x = bounds.minX
      } else if location.x > bounds.maxX {
        x = bounds.maxX
      } else {
        x = location.x
      }
      
      if location.y < bounds.minY {
        y = bounds.minY
      } else if location.y > bounds.maxY {
        y = bounds.maxY
      } else {
        y = location.y
      }
      
      location = CGPoint(x: x, y: y)
    }

    currentValue = value(from: location)
    pickerView.frame = rectForPicker(from: location)

    onValueChange.perform(with: currentValue)
  }

  @objc private func handlePressGesture(
    sender: UILongPressGestureRecognizer
  ) {
    guard let _ = sender.view, sender.state == .began
    else { return }

    let location = sender.location(in: self)

    currentValue = value(from: location)
    pickerView.frame = rectForPicker(from: location)

    onValueChange.perform(with: currentValue)
  }
}
