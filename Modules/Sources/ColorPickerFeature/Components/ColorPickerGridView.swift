import UIKit
import Core

final class ColorPickerGridView: UIView {
  // MARK: - Subviews
  
  private lazy var collectionView: UICollectionView = .init(
    frame: .zero,
    collectionViewLayout: collectionViewLayout
  ).apply {
    $0.isScrollEnabled = false
    $0.alwaysBounceVertical = false
    $0.alwaysBounceHorizontal = false
    $0.allowsMultipleSelection = false
    $0.showsVerticalScrollIndicator = false
    $0.showsHorizontalScrollIndicator = false
    $0.layer.cornerRadius = 8
    $0.layer.masksToBounds = true
  }
  
  // MARK: - Properties
  
  var selectedColor: UIColor {
    didSet { collectionView.reloadData() }
  }
  
  var onColorSelect: CommandWith<UIColor> = .nop
  
  private lazy var collectionViewLayout: UICollectionViewFlowLayout = .init()
  private lazy var palleteItems: [PalleteColorItem] = palleteColors(for: .sRGB)
  
  // MARK: - init/deinit
  
  init(
    selectedColor: UIColor,
    frame: CGRect
  ) {
    self.selectedColor = selectedColor
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
    
    if collectionView.frame != bounds {
      collectionView.collectionViewLayout.invalidateLayout()
    }
    
    collectionView.frame = bounds
  }
  
  // MARK: - Private methods
  
  private func setup() {
    addSubview(collectionView)
    
    collectionView.delegate = self
    collectionView.dataSource = self
    
    collectionView.register(
      ColorPickerGridCell.self,
      forCellWithReuseIdentifier: ColorPickerGridCell.identifier
    )
    
    let panGesture = UIPanGestureRecognizer(
      target: self,
      action: #selector(ColorPickerGridView.handlePanGesture(sender:))
    )
    let tapGesture = UITapGestureRecognizer(
      target: self,
      action: #selector(ColorPickerGridView.handleTapGesture(sender:))
    )
    let pressGesture = UILongPressGestureRecognizer(
      target: self,
      action: #selector(ColorPickerGridView.handleLongPressGesture(sender:))
    )
    collectionView.addGestureRecognizer(panGesture)
    collectionView.addGestureRecognizer(tapGesture)
    collectionView.addGestureRecognizer(pressGesture)
  }
  
  @objc private func handlePanGesture(sender: UIPanGestureRecognizer) {
    guard let _ = sender.view
    else { return }
    
    guard sender.state == .changed || sender.state == .began
    else { return }
    
    var location = sender.location(in: collectionView)
    
    if sender.state == .changed, bounds.contains(location) == false {
      let x: CGFloat
      let y: CGFloat
      
      if location.x < bounds.minX {
        x = bounds.minX + 1
      } else if location.x > bounds.maxX {
        x = bounds.maxX - 1
      } else {
        x = location.x
      }
      
      if location.y < bounds.minY {
        y = bounds.minY + 1
      } else if location.y > bounds.maxY {
        y = bounds.maxY - 1
      } else {
        y = location.y
      }
      
      location = CGPoint(x: x, y: y)
    }
    
    let indexPath = collectionView.indexPathForItem(at: location)
    
    if let indexPath = indexPath {
      let color = palleteItems[indexPath.row].uiColor
      onColorSelect.perform(with: color)
    }
  }
  
  @objc private func handleLongPressGesture(sender: UILongPressGestureRecognizer) {
    guard let _ = sender.view, sender.state == .began
    else { return }
    
    let location = sender.location(in: collectionView)
    let indexPath = collectionView.indexPathForItem(at: location)
    
    if let indexPath = indexPath {
      let color = palleteItems[indexPath.row].uiColor
      onColorSelect.perform(with: color)
    }
  }

  @objc private func handleTapGesture(sender: UITapGestureRecognizer) {
    guard let _ = sender.view, sender.state == .ended
    else { return }
    
    let location = sender.location(in: collectionView)
    let indexPath = collectionView.indexPathForItem(at: location)
    
    if let indexPath = indexPath {
      let color = palleteItems[indexPath.row].uiColor
      onColorSelect.perform(with: color)
    }
  }
}

// MARK: - UICollectionViewDataSource

extension ColorPickerGridView: UICollectionViewDataSource {
  func numberOfSections(
    in collectionView: UICollectionView
  ) -> Int {
    return 1
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return palleteItems.count
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: ColorPickerGridCell.identifier,
      for: indexPath
    )
    
    guard let gridCell = cell as? ColorPickerGridCell
    else { return cell }
    
    let color = palleteItems[indexPath.row].uiColor
    let isSelected = color == selectedColor
    
    gridCell.contentView.backgroundColor = color
    
    if isSelected {
      gridCell.contentView.layer.borderColor = UIColor(white: 0.12, alpha: 1).cgColor
      gridCell.contentView.layer.borderWidth = 3
      
      switch indexPath.row {
      case 0:
        gridCell.contentView.layer.cornerRadius = 8
        gridCell.contentView.layer.maskedCorners = .layerMinXMinYCorner
      case 11:
        gridCell.contentView.layer.cornerRadius = 8
        gridCell.contentView.layer.maskedCorners = .layerMaxXMinYCorner
      case (119 - 11):
        gridCell.contentView.layer.cornerRadius = 8
        gridCell.contentView.layer.maskedCorners = .layerMinXMaxYCorner
      case 119:
        gridCell.contentView.layer.cornerRadius = 8
        gridCell.contentView.layer.maskedCorners = .layerMaxXMaxYCorner
      default:
        break
      }
    }
    
    return gridCell
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ColorPickerGridView: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let collectionViewWidth = collectionView.bounds.width
    let itemSize = collectionViewWidth / 12
    
    return CGSize(
      width: itemSize,
      height: itemSize
    )
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumLineSpacingForSectionAt section: Int
  ) -> CGFloat {
    return CGFloat.zero
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumInteritemSpacingForSectionAt section: Int
  ) -> CGFloat {
    return CGFloat.zero
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    let color = palleteItems[indexPath.row].uiColor
    onColorSelect.perform(with: color)
  }
}

// MARK: - ColorPickerGridCell

final class ColorPickerGridCell: UICollectionViewCell {
  // MARK: - init/deinit
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Cell lifecycle
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    contentView.layer.borderWidth = 0
    contentView.layer.borderColor = nil
    contentView.layer.cornerRadius = 0
  }
}

// MARK: - Identifier

extension ColorPickerGridCell {
  static var identifier: String {
    return String(describing: Self.self)
  }
}
