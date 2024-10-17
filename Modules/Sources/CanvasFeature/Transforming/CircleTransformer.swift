import Foundation
import CoreGraphics

final class CircleTransformer: Transforming {
  
  func transform(_ drawing: Drawing) -> Drawing {
    return drawing.with(strokes: drawing.strokes.enumerated().map { strokeIndex, stroke in
      guard strokeIndex == 0, stroke.points.count > 2 else {
        return stroke
      }
      
      if isCircle(stroke.points, center: .init(x: stroke.frame.midX, y: stroke.frame.midY)) {
        return stroke.with(
          points: circle(in: stroke.frame),
          isClosed: true
        )
      }
      
      return stroke
    })
  }
  
  private func isCircle(_ points: [Point], center: CGPoint) -> Bool {
    var min: CGFloat = .greatestFiniteMagnitude
    var max: CGFloat = 0
    for point in points {
      let dist = center.distance(to: point.location)
      if dist < min {
        min = dist
      }
      if dist > max {
        max = dist
      }
    }

    return max - min < 200
  }
  
  private func circle(in rect: CGRect) -> [Point] {
    let center = CGPoint(x: rect.midX, y: rect.midY)
    let r = rect.width / 2
    
    var result = [Point]()
    for fi in stride(from: 0, to: 2 * CGFloat.pi, by: 0.1) {
      let x = center.x + r * cos(fi)
      let y = center.y + r * sin(fi)
      result.append(.init(location: .init(x: x, y: y), time: 0, force: 0))
    }
    result.append(result[0])
    return result
  }
  
}
