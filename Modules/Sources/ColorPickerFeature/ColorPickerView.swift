import UIKit
import Core

final class ColorPickerView: UIVisualEffectView {
  // MARK: - Subviews

  private lazy var scrollView: UIScrollView = .init(
    frame: .zero
  ).apply {
    $0.alwaysBounceVertical = false
    $0.alwaysBounceHorizontal = false
    $0.showsVerticalScrollIndicator = false
    $0.showsHorizontalScrollIndicator = false
  }

  private lazy var headerView: ColorPickerHeaderView = .init(
    frame: .zero
  )

  private lazy var segmentedControl: UISegmentedControl = .init(
    frame: .zero
  ).apply { control in
    ColorPickerViewModel.Tab
      .allCases
      .enumerated()
      .forEach {
        control.insertSegment(
          withTitle: $1.rawValue,
          at: $0,
          animated: false
        )
      }
  }

  private lazy var gridView: ColorPickerGridView = .init(
    selectedColor: viewModel.selectedColor,
    frame: .zero
  ).apply {
    $0.isHidden = viewModel.activeTab != .grid
  }
  
  private lazy var spectrumView: ColorPickerSpectrumView = .init(
    selectedColor: viewModel.selectedColor,
    frame: .zero
  ).apply {
    $0.isHidden = viewModel.activeTab != .spectrum
  }

  private(set) lazy var opacityView: ColorPickerOpacityView = .init(
    frame: .zero
  ).apply {
    $0.isHidden = viewModel.supportsAlpha == false
  }

  // MARK: - Properties

  private var viewModel: ColorPickerViewModel = .initial

  // MARK: - init/deinit

  override init(effect: UIVisualEffect?) {
    super.init(effect: effect)

    setup()
  }

  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - View lifecycle

  override func layoutSubviews() {
    super.layoutSubviews()

    let padding: CGFloat = 16

    scrollView.frame = contentView.bounds
    scrollView.contentInset = UIEdgeInsets(
      top: safeAreaInsets.top,
      left: safeAreaInsets.left + padding,
      bottom: safeAreaInsets.bottom,
      right: safeAreaInsets.right + padding
    )

    let width: CGFloat = scrollView.bounds
      .inset(by: scrollView.contentInset)
      .width

    headerView.frame = CGRect(
      x: 0,
      y: 0,
      width: width,
      height: 54
    )

    segmentedControl.frame = CGRect(
      x: 0,
      y: headerView.frame.maxY + 4,
      width: width,
      height: 32
    )

    gridView.frame = CGRect(
      x: 0,
      y: segmentedControl.frame.maxY + 20,
      width: width,
      height: width * 10 / 12
    )
    
    spectrumView.frame = gridView.frame

    let supportsAlpha = viewModel.supportsAlpha
    let opacityViewSize = opacityView.sizeThatFits(
      CGSize(
        width: width,
        height: .infinity
      )
    )

    opacityView.frame = supportsAlpha == false
    ? CGRect.zero
    : CGRect(
      x: 0,
      y: spectrumView.frame.maxY + 16,
      width: opacityViewSize.width,
      height: opacityViewSize.height
    )

    updateScrollViewContentSize()
  }

  // MARK: - Public methods

  func configure(with viewModel: ColorPickerViewModel) {
    self.viewModel = viewModel

    headerView.onCloseTap = viewModel.onCloseTap
    headerView.onDropperTap = viewModel.onDropperTap

    segmentedControl.selectedSegmentIndex = viewModel.activeTab.index

    gridView.selectedColor = viewModel.selectedColor
    gridView.onColorSelect = viewModel.onColorSelect
    
    spectrumView.selectedColor = viewModel.selectedColor
    spectrumView.onColorSelect = viewModel.onColorSelect

    opacityView.setAlpha(viewModel.alpha)
    opacityView.setSelectedColor(viewModel.selectedColor)
    opacityView.onAlphaChange = viewModel.onAlphaChange

    gridView.isHidden = viewModel.activeTab != .grid
    spectrumView.isHidden = viewModel.activeTab != .spectrum

    opacityView.isHidden = viewModel.supportsAlpha == false

    setNeedsLayout()
  }

  // MARK: - Private methods

  private func setup() {
    isOpaque = false

    contentView.addSubview(scrollView)

    scrollView.addSubview(headerView)
    scrollView.addSubview(segmentedControl)
    scrollView.addSubview(gridView)
    scrollView.addSubview(spectrumView)
    scrollView.addSubview(opacityView)

    segmentedControl.addTarget(
      self,
      action: #selector(ColorPickerView.segmentedControlDidChange(sender:)),
      for: .valueChanged
    )

    scrollView.addGestureRecognizer(UITapGestureRecognizer(
      target: self,
      action: #selector(ColorPickerView.viewDidTapped(sender:))
    ))
  }

  private func updateScrollViewContentSize() {
    let width: CGFloat = scrollView.bounds
      .inset(by: scrollView.contentInset)
      .width
    var height: CGFloat = scrollView.subviews.last?.frame.maxY ?? 0

    height -= scrollView.contentInset.top
    height -= scrollView.contentInset.bottom

    scrollView.contentSize = CGSize(
      width: width,
      height: height
    )
  }

  @objc private func segmentedControlDidChange(
    sender: UISegmentedControl
  ) {
    let activeSegmentIndex = sender.selectedSegmentIndex
    let title = sender.titleForSegment(at: activeSegmentIndex)

    guard let title = title
    else { return }

    let tab = ColorPickerViewModel.Tab.allCases.first {
      $0.rawValue == title
    }

    if let tab = tab {
      viewModel.onTabChange.perform(with: tab)
    }
  }

  @objc private func viewDidTapped(sender: UITapGestureRecognizer) {
    guard let _ = sender.view, sender.state == .ended
    else { return }

    opacityView.percentTextField.resignFirstResponder()
  }
}
