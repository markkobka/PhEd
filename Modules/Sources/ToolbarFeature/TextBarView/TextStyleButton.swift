//
//  File.swift
//  
//
//  Created by Maxim Timokhin on 15.10.2022.
//

import UIKit


final class TextStyleButton: UIControl {
  
  private var viewModel: TextAlignmentButtonViewModel = .left
    
  // MARK: - Init
  init() {
    super.init(frame: .zero)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: - Setup view
  private func setup() {
    for _ in 0..<4 {
      let layer = CALayer()
      layer.backgroundColor = UIColor.white.cgColor
      layer.cornerRadius = 1
      layer.masksToBounds = true
      self.layer.addSublayer(layer)
    }
    
    addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapAction)))
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    let sublayers = layer.sublayers ?? []
    
    if sublayers.isEmpty {
      return
    }
    
    let lineWidth: CGFloat = 2
    let step: CGFloat = viewModel.iconSize.height / CGFloat(sublayers.count)
    let start: CGFloat = (bounds.height - viewModel.iconSize.height) / 2
    
    CATransaction.begin()
    CATransaction.setAnimationDuration(0.4)
    for (index, layer) in sublayers.enumerated() {
      layer.frame = .init(
        x: posX(forLayerAt: index),
        y: start + CGFloat(index) * step,
        width: width(forLayerAt: index),
        height: lineWidth
      )
    }
    CATransaction.commit()
  }
  
  private func width(forLayerAt index: Int) -> CGFloat {
    index.isMultiple(of: 2) ? viewModel.iconSize.width : viewModel.iconSize.width * 0.6
  }
  
  private func posX(forLayerAt index: Int) -> CGFloat {
    if index.isMultiple(of: 2) {
      return (bounds.width - viewModel.iconSize.width) / 2
    }
    
    let iconOffset = (bounds.width - viewModel.iconSize.width) / 2
    
    switch viewModel {
    case .left:
      return iconOffset
    case .right:
      return iconOffset + (viewModel.iconSize.width - width(forLayerAt: index))
    case .center:
      return (bounds.width - width(forLayerAt: index)) / 2
    }
  }
  
  // MARK: - configure
  func configure(with viewModel: TextAlignmentButtonViewModel) {
    self.viewModel = viewModel
    setNeedsLayout()
  }

  @objc private func tapAction() {
    sendActions(for: .touchUpInside)
  }  
}


