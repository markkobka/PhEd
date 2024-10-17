import Foundation
import CoreGraphics

final class LineTransformer: Transforming {
  
  func transform(_ drawing: Drawing) -> Drawing {
    return drawing.with(strokes: drawing.strokes.enumerated().map{ strokeIndex, stroke in
      guard strokeIndex == 0 else {
        return stroke
      }
      
      if !isSingleLine(stroke.points) {
        return stroke
      }

      return stroke.with(
        points: [stroke.points.first, stroke.points.last].compactMap({ $0 })
      )
    })
  }

  private func isSingleLine(_ points: [Point]) -> Bool {
    guard points.count > 2 else {
      return true
    }
    let p1 = points[0].location
    let p2 = points[points.count - 1].location

    for i in 1..<points.count - 1 {
      let p0 = points[i].location
      let dist = abs((p2.y - p1.y)*p0.x - (p2.x - p1.x)*p0.y + p2.x*p1.y - p2.y*p1.x) / sqrt(pow(p2.y - p1.y, 2) + pow(p2.x - p1.x, 2))
      if dist > 50 {
        return false
      }
    }
    
    return true
  }

}
