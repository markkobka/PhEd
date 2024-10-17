import UIKit
import CoreGraphics

final class PatternView: UIView {
  // MARK: - Private properties

  let drawPattern: CGPatternDrawPatternCallback = { _, context in
    context.addRect(
      CGRect(
        x: 0,
        y: 0,
        width: 12.5,
        height: 12.5
      )
    )
    context.addRect(
      CGRect(
        x: 12.5,
        y: 12.5,
        width: 12.5,
        height: 12.5
      )
    )
    context.setFillColor(
      UIColor
        .white
        .withAlphaComponent(0.5)
        .cgColor
    )
    context.fillPath()
  }

  // MARK: - init/deinit

  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Override methods

  override func draw(_ rect: CGRect) {
    guard let context = UIGraphicsGetCurrentContext()
    else { return }

    UIColor.clear.setFill()
    context.fill(rect)

    var callbacks = CGPatternCallbacks(
      version: 0,
      drawPattern: drawPattern,
      releaseInfo: nil
    )

    guard let pattern = CGPattern(
      info: nil,
      bounds: CGRect(x: 0, y: 0, width: 25, height: 25),
      matrix: .identity,
      xStep: 25,
      yStep: 25,
      tiling: .constantSpacing,
      isColored: true,
      callbacks: &callbacks)
    else { return }

    guard let patternSpace = CGColorSpace(patternBaseSpace: nil)
    else { return }

    context.setFillColorSpace(patternSpace)

    var alpha: CGFloat = 0.2
    context.setFillPattern(pattern, colorComponents: &alpha)
    context.fill(rect)
  }

  // MARK: - Private methods

  private func setup() {
    isOpaque = false
    backgroundColor = UIColor.clear
  }
}
