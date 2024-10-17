import UIKit
import CoreGraphics
import Core

final class ColorPickerSpectrumView: UIView {
  // MARK: - Subviews
  
  private lazy var spectrumView: UIImageView = .init(
    frame: .zero
  ).apply {
    $0.layer.cornerRadius = 8
    $0.layer.masksToBounds = true
    $0.backgroundColor = UIColor.black
    $0.contentMode = .scaleAspectFill
    $0.isUserInteractionEnabled = true
  }
  
  private lazy var pickerView: UIView = .init(
    frame: .zero
  ).apply {
    $0.layer.cornerRadius = Constants.pickerSize.width / 2
    $0.layer.shadowRadius = 2
    $0.layer.shadowOpacity = 0.3
    $0.layer.shadowOffset = CGSize.zero
    $0.layer.shadowColor = UIColor.black.cgColor
    $0.layer.shadowPath = UIBezierPath(
      roundedRect: CGRect(
        x: 0,
        y: 0,
        width: Constants.pickerSize.width,
        height: Constants.pickerSize.height
      ),
      cornerRadius: $0.layer.cornerRadius
    ).cgPath
    $0.backgroundColor = UIColor.black
    $0.isHidden = true
    $0.isUserInteractionEnabled = false
  }
  
  // MARK: - Properties
  
  var selectedColor: UIColor {
    didSet {
      if oldValue != selectedColor {
        selectedColorUpdated()
      }
    }
  }
  var onColorSelect: CommandWith<UIColor> = .nop
  
  private let drawer: ColorPickerSpectrumDrawer
  
  private var lastPickerLocation: CGPoint = .zero
  private var needToHidePicker = true
  
  // MARK: - init/deinit
  
  init(
    selectedColor: UIColor,
    frame: CGRect
  ) {
    self.selectedColor = selectedColor
    self.drawer = ColorPickerSpectrumCoreGraphicsDrawer()
    super.init(frame: frame)
    
    setup()
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - View lifecycle
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    updateSpectrumImageIfNeeded()
    spectrumView.frame = bounds
    
    let location = getLocation(for: selectedColor)
    updatePickerFrame(with: location, afterLayoutSubviews: true)
    updatePickerBackground(with: selectedColor)
  }
  
  // MARK: - Private methods
  
  private func setup() {
    clipsToBounds = false
    backgroundColor = UIColor.clear
    
    addSubview(spectrumView)
    insertSubview(pickerView, aboveSubview: spectrumView)
    
    let tapGesture = UITapGestureRecognizer(
      target: self,
      action: #selector(ColorPickerSpectrumView.handleTapGesture(sender:))
    )
    let panGesture = UIPanGestureRecognizer(
      target: self,
      action: #selector(ColorPickerSpectrumView.handlePanGesture(sender:))
    )
    spectrumView.addGestureRecognizer(tapGesture)
    spectrumView.addGestureRecognizer(panGesture)
  }
  
  private func updateSpectrumImageIfNeeded() {
    if spectrumView.frame != bounds {
      drawer.createSpectrumImage(for: bounds) { [weak self] image in
        guard let self = self
        else { return }
        
        self.spectrumView.image = image
      }
    }
  }
  
  private func updatePickerFrame(
    with location: CGPoint,
    afterLayoutSubviews: Bool = false
  ) {
    lastPickerLocation = location
    
    let size = Constants.pickerSize
    let offset = size.width / 2
    let origin = lastPickerLocation
      .applying(
        CGAffineTransform(
          translationX: -offset,
          y: -offset
        )
      )
    
    pickerView.frame = CGRect(origin: origin, size: size)
  }
  
  private func updatePickerBackground(with color: UIColor) {
    pickerView.backgroundColor = color
  }
  
  private func selectedColorUpdated() {
    if needToHidePicker {
      pickerView.isHidden = true
    }
    
    needToHidePicker = true
  }
  
  private func getLocation(for color: UIColor) -> CGPoint {
    let location = drawer.getPoint(for: color, in: bounds)
    return location ?? lastPickerLocation
  }
  
  private func getColor(for location: CGPoint) -> UIColor {
    let color = drawer.getColor(
      for: location,
      in: bounds,
      colorSpace: .sRGB
    )
    return color
  }
 
  @objc private func handleTapGesture(sender: UITapGestureRecognizer) {
    guard let _ = sender.view, sender.state == .ended
    else { return }
    
    let location = sender.location(in: spectrumView)
    updatePickerFrame(with: location)
    
    let color = getColor(for: location)
    updatePickerBackground(with: color)
    
    pickerView.isHidden = false
    needToHidePicker = false
    
    onColorSelect.perform(with: color)
  }
  
  @objc private func handlePanGesture(sender: UIPanGestureRecognizer) {
    guard let _ = sender.view
    else { return }
    
    guard sender.state == .changed || sender.state == .began
    else { return }
    
    var location = sender.location(in: spectrumView)
    
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
    
    updatePickerFrame(with: location)
    
    let color = getColor(for: location)
    updatePickerBackground(with: color)
    
    pickerView.isHidden = false
    needToHidePicker = false
    
    onColorSelect.perform(with: color)
  }
}

// MARK: - Constants

extension ColorPickerSpectrumView {
  enum Constants {
    static var pickerSize: CGSize {
      return CGSize(width: 32, height: 32)
    }
  }
}
