import UIKit

public final class TextEditView: UIView {
  
  public var textColor: UIColor = .white {
    didSet {
      resetAttributes()
    }
  }
  
  public var textAlignment: NSTextAlignment = .left {
    didSet {
      resetAttributes()
    }
  }
  
  public var fontStyle: FontStyle = .default {
    didSet {
      resetAttributes()
      updateOutline()
    }
  }
  
  public var fontSize: CGFloat = 48 {
    didSet {
      resetAttributes()
    }
  }
  
  private lazy var outlineLayer: CAShapeLayer = {
    let layer = CAShapeLayer()
    layer.fillColor = UIColor.black.cgColor
    return layer
  }()
  
  private lazy var textView: UITextView = {
    let textView = UITextView()
    textView.backgroundColor = .clear
    textView.autocorrectionType = .no
    textView.autocapitalizationType = .none
    textView.delegate = self
    textView.isScrollEnabled = false
    return textView
  }()
  
  private var textAttributes: [NSAttributedString.Key : Any] {
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = textAlignment
    var attributes: [NSAttributedString.Key : Any]  = [
      .font: UIFont.systemFont(ofSize: fontSize, weight: .semibold),
      .paragraphStyle: paragraphStyle,
      .foregroundColor: textColor,
    ]

    if fontStyle == .stroke {
      attributes[.strokeColor] = UIColor.black
      attributes[.strokeWidth] = -3
    }
        
    return attributes
  }
  
  // MARK: - Init
  public init () {
    super.init(frame: .zero)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
    
  
  // MARK: - Setup view
  private func setup() {
    
    layer.addSublayer(outlineLayer)
    
    textView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(textView)
    NSLayoutConstraint.activate([
      textView.leftAnchor.constraint(equalTo: leftAnchor, constant: 36),
      textView.rightAnchor.constraint(equalTo: rightAnchor, constant: -36),
      textView.centerYAnchor.constraint(equalTo: centerYAnchor),
      textView.heightAnchor.constraint(greaterThanOrEqualToConstant: 44),
    ])
    
    textView.textColor = textColor
    textView.font = .systemFont(ofSize: fontSize)

    addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapAction)))
        
  }
  
  private func resetAttributes() {
    textView.textStorage.setAttributes(textAttributes, range: NSRange(location: 0, length: textView.textStorage.length))
  }
  
  private func updateOutline() {
    switch fontStyle {
    case .default, .stroke:
      outlineLayer.isHidden = true
      outlineLayer.fillColor = UIColor.clear.cgColor
    case .filled:
      outlineLayer.isHidden = false
      outlineLayer.fillColor = UIColor.black.cgColor
    case .semi:
      outlineLayer.isHidden = false
      outlineLayer.fillColor = UIColor.white.withAlphaComponent(0.5).cgColor
    }
    
    var rects = Set<CGRect>()
    
    for i in 0..<textView.layoutManager.numberOfGlyphs {
      var rect = textView.layoutManager.lineFragmentUsedRect(forGlyphAt: i, effectiveRange: nil)
      let fix = (rect.height - fontSize) / 2
      rect.origin = .init(x: rect.origin.x, y: rect.origin.y + fix)
      rects.insert(self.convert(rect, from: textView))
    }
    
    let path = UIBezierPath()
    rects.forEach { rect in
      path.append(UIBezierPath(roundedRect: rect, byRoundingCorners: .allCorners, cornerRadii: .init(width: 12, height: 12)))
    }
    

    
    outlineLayer.frame = bounds
    outlineLayer.path = path.cgPath
  }
  
  public override func layoutSubviews() {
    super.layoutSubviews()
    updateOutline()
  }

  @objc private func tapAction() {
    if textView.isFirstResponder {
      endEditing(true)
    }
  }
  
  public override func becomeFirstResponder() -> Bool {
    textView.becomeFirstResponder()
  }
}

// MARK: - UITextViewDelegate
extension TextEditView: UITextViewDelegate {
  public func textViewDidChange(_ textView: UITextView) {
    textView.attributedText = NSAttributedString(string: textView.text, attributes: textAttributes)
    updateOutline()
  }
}


extension TextEditView {
  public struct Font {
    public let size: CGFloat
    public let name: FontName

    public init(size: CGFloat, name: FontName) {
      self.size = size
      self.name = name
    }
  }
  
  public enum FontStyle {
    case `default`
    case filled
    case semi
    case stroke
  }
  
  public enum FontName {
    case sf
  }
}


extension CGRect: Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(minX)
    hasher.combine(minY)
    hasher.combine(width)
    hasher.combine(height)
  }
  
}
