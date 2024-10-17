//
//  File.swift
//  
//
//  Created by Maxim Timokhin on 15.10.2022.
//

import UIKit

protocol TextBarDelegate: AnyObject {
  func textBarDidTapStyleButton(_ textBar: TextBarView)
  func textBarDidTapAlignmentButton(_ textBar: TextBarView)
}

final class TextBarView: UIView {
  
  weak var delegate: TextBarDelegate?
  
  private lazy var styleButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.adjustsImageWhenHighlighted = false
    button.addTarget(self, action: #selector(styleButtonAction), for: .touchUpInside)
    return button
  }()
  
  private lazy var alignmentButton: TextStyleButton = {
    let button = TextStyleButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(alignmentButtonAction), for: .touchUpInside)
    return button
  }()
  
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
    addSubview(styleButton)
    NSLayoutConstraint.activate([
      styleButton.leftAnchor.constraint(equalTo: leftAnchor),
      styleButton.topAnchor.constraint(equalTo: topAnchor),
      styleButton.bottomAnchor.constraint(equalTo: bottomAnchor),
      styleButton.widthAnchor.constraint(equalTo: styleButton.heightAnchor, constant: 1)
    ])

    addSubview(alignmentButton)
    NSLayoutConstraint.activate([
      alignmentButton.leftAnchor.constraint(equalTo: styleButton.rightAnchor, constant: 14),
      alignmentButton.topAnchor.constraint(equalTo: topAnchor),
      alignmentButton.bottomAnchor.constraint(equalTo: bottomAnchor),
      alignmentButton.widthAnchor.constraint(equalTo: styleButton.heightAnchor, constant: 1)
    ])

  }
  
  // MARK: - Configure
  func configure(with viewModel: TextBarViewModel) {
    styleButton.setImage(viewModel.style.image, for: .normal)
    alignmentButton.configure(with: viewModel.alignment)
  }
  
  @objc private func styleButtonAction() {
    delegate?.textBarDidTapStyleButton(self)
  }
  
  @objc private func alignmentButtonAction() {
    delegate?.textBarDidTapAlignmentButton(self)
  }
  
}
