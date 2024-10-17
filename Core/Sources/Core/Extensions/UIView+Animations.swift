//
//  File.swift
//  
//
//  Created by Maxim Timokhin on 14.10.2022.
//

import UIKit

public extension UIView {
  
  func fadeOut(_ duration: TimeInterval = 0.4) {
    UIView.animate(withDuration: duration, delay: 0, animations: {
      self.alpha = 0
    })
  }
  
  func fadeIn(_ duration: TimeInterval = 0.4) {
    UIView.animate(withDuration: duration, delay: 0, animations: {
      self.alpha = 1
    })
  }  
}
