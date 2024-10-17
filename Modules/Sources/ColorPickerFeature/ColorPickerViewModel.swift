import UIKit
import Core

struct ColorPickerViewModel: Hashable {
  let activeTab: Tab
  let selectedColor: UIColor
  let supportsAlpha: Bool
  let alpha: CGFloat
  let savedColors: [UIColor]
  let onColorSelect: CommandWith<UIColor>
  let onSupportAlphaUpdate: CommandWith<Bool>
  let onCloseTap: Command
  let onDropperTap: Command
  let onTabChange: CommandWith<ColorPickerViewModel.Tab>
  let onAlphaChange: CommandWith<CGFloat>

  enum Tab: String, CaseIterable, Hashable {
    case grid = "Grid"
    case spectrum = "Spectrum"

    var index: Int {
      return Tab.allCases.firstIndex {
        $0 == self
      } ?? 0
    }
  }

  static var initial: ColorPickerViewModel {
    /// Black color with  sRGB color space (not grayscale)
    let selectedColor = UIColor(
      red: 0,
      green: 0,
      blue: 0,
      alpha: 1
    ).convert(to: CGColorSpace.sRGB) ?? UIColor.black
    
    return ColorPickerViewModel(
      activeTab: .spectrum,
      selectedColor: selectedColor,
      supportsAlpha: true,
      alpha: 1,
      savedColors: [],
      onColorSelect: .nop,
      onSupportAlphaUpdate: .nop,
      onCloseTap: .nop,
      onDropperTap: .nop,
      onTabChange: .nop,
      onAlphaChange: .nop
    )
  }
}
