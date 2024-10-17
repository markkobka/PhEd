//
//  File.swift
//  
//
//  Created by Maxim Timokhin on 23.10.2022.
//

import Foundation
import CoreGraphics

final class BezierTransformer: Transforming {
  func transform(_ drawing: Drawing) -> Drawing {
    return drawing.with(strokes: drawing.strokes.map { stroke in
      guard stroke.points.count > 1 else {
        return stroke
      }
      
      var points = [Point]()
      let delta: CGFloat = 1 / CGFloat(stroke.points.count)
      
      var time = stroke.points.first?.time ?? 0
      for t in stride(from: 0, to: 1, by: delta) {
        var x: CGFloat = 0
        var y: CGFloat = 0
        for i in 0..<stroke.points.count {
          let b = basis(i: i, n: stroke.points.count - 1, t: t)
          x += stroke.points[i].location.x * (b.isNaN ? 1 : b)
          y += stroke.points[i].location.y * (b.isNaN ? 1 : b)
        }
        time += 10
        if !x.isNaN, !y.isNaN {
          points.append(.init(
            location: .init(x: x, y: y),
            time: time,
            force: 0
          ))
        }
      }
      return stroke.with(points: points)
    })
  }
  
  private func basis(i: Int, n: Int, t: CGFloat) -> CGFloat {
    return (factorial(n) / (factorial(i) * factorial(n - i))) * pow(t, Double(i)) * pow(1 - t, Double(n - i))
  }
  
  private func factorial(_ n: Int) -> CGFloat {
    (n <= 1) ? 1 : CGFloat(n) * factorial(n - 1)
  }
  
}
