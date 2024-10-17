import UIKit

// MARK: - ColorPickerSpectrumDrawer

protocol ColorPickerSpectrumDrawer: AnyObject {
  func createSpectrumImage(
    for rect: CGRect,
    completion: ((UIImage) -> Void)?
  )
  
  func getColor(
    for point: CGPoint,
    in rect: CGRect,
    colorSpace: ColorSpace
  ) -> UIColor
  
  func getPoint(
    for color: UIColor,
    in rect: CGRect
  ) -> CGPoint?
}

// MARK: - ColorPickerSpectrumCoreGraphicsDrawer

final class ColorPickerSpectrumCoreGraphicsDrawer: ColorPickerSpectrumDrawer {
  // MARK: - Properties
  
  private let queue: DispatchQueue
  
  // MARK: - init/deinit
  
  init() {
    self.queue = DispatchQueue(
      label: Constants.queueName,
      qos: .userInteractive
    )
  }
  
  // MARK: - ColorPickerSpectrumRenderer
  
  func createSpectrumImage(
    for rect: CGRect,
    completion: ((UIImage) -> Void)?
  ) {
    queue.async { [weak self] in
      guard let self = self
      else { return }
      
      let failureCompletion: () -> Void = {
        DispatchQueue.main.async {
          completion?(UIImage())
        }
      }
      
      let successCompletion: (UIImage) -> Void = { image in
        DispatchQueue.main.async {
          completion?(image)
        }
      }
      
      guard let colorSpace = CGColorSpace(name: CGColorSpace.extendedSRGB),
            let bitmapData = CFDataCreateMutable(nil, 0)
      else {
        failureCompletion()
        return
      }
      
      let width = Int(rect.width)
      let height = Int(rect.height)
      
      let length = width * height * 4
      CFDataSetLength(bitmapData, length)
      
      guard let bitmapDataPointer = CFDataGetMutableBytePtr(bitmapData)
      else {
        failureCompletion()
        return
      }
      
      self.generateSpectrumBitmap(
        pointer: bitmapDataPointer,
        width: width,
        height: height
      )
      
      if let cgImage = self.createCGImage(
        from: bitmapData,
        colorSpace: colorSpace,
        width: width,
        height: height
      ) {
        successCompletion(UIImage(cgImage: cgImage))
        return
      }
      
      failureCompletion()
    }
  }
  
  func getColor(
    for point: CGPoint,
    in rect: CGRect,
    colorSpace: ColorSpace
  ) -> UIColor {
    let hue = point.y / rect.height
    let lightness = 1 - point.x / rect.width
    let hsl = HSL(hue: hue, saturation: 1, lightness: lightness)
    let rgb = hsl.rgb
    
    guard let colorSpace = CGColorSpace(name: colorSpace.name),
          let cgColor = CGColor(
            colorSpace: colorSpace,
            components: [rgb.red, rgb.green, rgb.blue, 1]
          )
    else { return UIColor.black }
    
    return UIColor(cgColor: cgColor)
  }
  
  func getPoint(
    for color: UIColor,
    in rect: CGRect
  ) -> CGPoint? {
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    
    guard color.getRed(&red, green: &green, blue: &blue, alpha: nil)
    else { return nil }
    
    let rgb = RGB(red: red, green: green, blue: blue)
    let hsl = rgb.hsl
    
    let x = -(hsl.lightness - 1) * rect.width
    let y = hsl.hue * rect.height
    
    return CGPoint(x: x, y: y)
  }
  
  // MARK: - Private methods
  
  private func generateSpectrumBitmap(
    pointer: UnsafeMutablePointer<UInt8>,
    width: Int,
    height: Int
  ) {
    for y in (0 ..< height) {
      let hue: CGFloat = CGFloat(y)/CGFloat(height)
      var i: Int = y * width * 4

      for x in (0 ..< width) {
        let lightness: CGFloat = 1 - CGFloat(x)/CGFloat(width)

        let hsl = HSL(hue: hue, saturation: 1, lightness: lightness)
        let rgb = hsl.rgb

        pointer[i] = UInt8(rgb.red * 0xff)
        pointer[i+1] = UInt8(rgb.green * 0xff)
        pointer[i+2] = UInt8(rgb.blue * 0xff)
        pointer[i+3] = 0xff /// alpha

        i += 4
      }
    }
  }
  
  private func createCGImage(
    from data: CFData,
    colorSpace: CGColorSpace,
    width: Int,
    height: Int
  ) -> CGImage? {
    guard let dataProvider = CGDataProvider(data: data)
    else { return nil }
    
    let bitmapInfo = CGBitmapInfo(
      rawValue: CGImageAlphaInfo.last.rawValue
    )
    
    return CGImage(
      width: width,
      height: height,
      bitsPerComponent: 8,
      bitsPerPixel: 32,
      bytesPerRow: width * 4,
      space: colorSpace,
      bitmapInfo: bitmapInfo,
      provider: dataProvider,
      decode: nil,
      shouldInterpolate: false,
      intent: .defaultIntent
    )
  }
}

// MARK: - Constants

extension ColorPickerSpectrumCoreGraphicsDrawer {
  enum Constants {
    static var queueName: String {
      return """
      ColorPickerFeature.ColorPickerSpectrumCoreGraphicsDrawer.serial_queue
      """
    }
  }
}
