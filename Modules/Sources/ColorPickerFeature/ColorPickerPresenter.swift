import Foundation
import Core

import class UIKit.UIColor
import struct CoreGraphics.CGFloat

final class ColorPickerPresenter {
  // MARK: - State

  private var activeTab: ColorPickerViewModel.Tab = ColorPickerViewModel
    .initial
    .activeTab

  private var selectedColor: UIColor = ColorPickerViewModel
    .initial
    .selectedColor

  private var supportsAlpha: Bool = ColorPickerViewModel
    .initial
    .supportsAlpha

  private var alpha: CGFloat = ColorPickerViewModel
    .initial
    .alpha

  private var savedColors: [UIColor] = ColorPickerViewModel
    .initial
    .savedColors

  // MARK: - Properties

  weak var view: ColorPickerViewInput?

  // MARK: - init/deinit

  init() {}

  // MARK: - Private methods

  private func updateViewModel() {
    let viewModel = createViewModel()
    view?.configure(with: viewModel)
  }

  private func createViewModel() -> ColorPickerViewModel {
    let onColorSelect: CommandWith<UIColor> = .init { [weak self] color in
      guard let self = self
      else { return }

      self.selectedColor = color
      self.alpha = 1
      self.updateViewModel()
      self.view?.hideKeyboard()
      self.view?.didSelectColor(color)
    }

    let onSupportAlphaUpdate: CommandWith<Bool> = .init { [weak self] in
      guard let self = self
      else { return }

      self.supportsAlpha = $0
      self.updateViewModel()
      self.view?.hideKeyboard()
    }

    let onCloseTap: Command = .init { [weak self] in
      guard let self = self
      else { return }

      self.view?.hideKeyboard()
      self.view?.didFinish()
      self.view?.performDismiss()
    }

    let onDropperTap: Command = .init { [weak self] in
      guard let self = self
      else { return }

      self.view?.hideKeyboard()
      self.view?.performDismiss()
    }

    let onTabChange: CommandWith<ColorPickerViewModel.Tab> = .init { [weak self] in
      guard let self = self
      else { return }

      self.activeTab = $0
      self.updateViewModel()
      self.view?.hideKeyboard()
    }

    let onAlphaChange: CommandWith<CGFloat> = .init { [weak self] in
      guard let self = self
      else { return }

      self.alpha = $0

      self.selectedColor = self.alpha == 1
      ? self.selectedColor
      : self.selectedColor.withAlphaComponent(self.alpha)

      self.updateViewModel()
    }

    return ColorPickerViewModel(
      activeTab: activeTab,
      selectedColor: selectedColor,
      supportsAlpha: supportsAlpha,
      alpha: alpha,
      savedColors: savedColors,
      onColorSelect: onColorSelect,
      onSupportAlphaUpdate: onSupportAlphaUpdate,
      onCloseTap: onCloseTap,
      onDropperTap: onDropperTap,
      onTabChange: onTabChange,
      onAlphaChange: onAlphaChange
    )
  }
}

// MARK: - ColorPickerViewOuput

extension ColorPickerPresenter: ColorPickerViewOuput {
  func onViewDidLoad() {
    updateViewModel()
  }
}
