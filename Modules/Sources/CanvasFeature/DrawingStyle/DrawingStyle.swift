//
//  File.swift
//  
//
//  Created by Maxim Timokhin on 22.10.2022.
//

import UIKit
import CoreGraphics

public enum InkType {
  case draw
  case blur
  case erase
}

public enum TipType {
  case `default`
  case arrow
}

public struct DrawingStyle {
  let color: CGColor
  let strokeSize: CGFloat
  let ink: InkType
  let tipType: TipType
  let transforming: Transforming
  
  public init(color: UIColor, strokeSize: CGFloat, ink: InkType, tipType: TipType, transforming: Transforming) {
    self.color = color.cgColor
    self.strokeSize = strokeSize
    self.ink = ink
    self.tipType = tipType
    self.transforming = transforming
  }
}

extension DrawingStyle {
  
  public static func brush(strokeSize: CGFloat, color: UIColor, tipType: TipType = .default) -> Self {
    .init(
      color: color,
      strokeSize: strokeSize,
      ink: .draw,
      tipType: tipType,
      transforming: TransformChain([
        TipTransformer(tip: .init(tipType)),
        OutlineTransformer(
          dynamicWidth: true
        ),
        LerpTransformer(iterations: 3),
      ])
    )
  }
  
  public static func marker(strokeSize: CGFloat, color: UIColor, tipType: TipType = .default) -> Self {
    .init(
      color: color.withAlphaComponent(0.5),
      strokeSize: strokeSize,
      ink: .draw,
      tipType: tipType,
      transforming: TransformChain([
        TipTransformer(tip: .init(tipType)),
        OutlineTransformer(
          dynamicWidth: false
        ),
        LerpTransformer(iterations: 1)
      ])
    )
  }
  
  public static func neon(strokeSize: CGFloat, color: UIColor, tipType: TipType = .default) -> Self {
    .init(
      color: color,
      strokeSize: strokeSize,
      ink: .draw,
      tipType: tipType,
      transforming: TransformChain([
        TipTransformer(tip: .init(tipType)),
        LerpTransformer(iterations: 1),
        OutlineTransformer(
          dynamicWidth: true
        ),
      ])
    )
  }
  
  public static func pencil(strokeSize: CGFloat, color: UIColor, tipType: TipType = .default) -> Self {
    .init(
      color: color,
      strokeSize: strokeSize,
      ink: .draw,
      tipType: tipType,
      transforming: TransformChain([
        TipTransformer(tip: .init(tipType)),
        LerpTransformer(iterations: 1),
        OutlineTransformer(
          dynamicWidth: false
        ),
      ])
    )
  }
  
  public static func blur(strokeSize: CGFloat) -> Self {
    .init(
      color: .white,
      strokeSize: strokeSize,
      ink: .blur,
      tipType: .default,
      transforming: TransformChain([
        LerpTransformer(iterations: 1),
        OutlineTransformer(
          dynamicWidth: false
        ),
      ])
    )
  }
  
  public static func erase(strokeSize: CGFloat) -> Self {
    .init(
      color: .white,
      strokeSize: strokeSize,
      ink: .erase,
      tipType: .default,
      transforming: TransformChain([
        LerpTransformer(iterations: 1),
        OutlineTransformer(
          dynamicWidth: false
        ),
      ])
    )
  }
}
