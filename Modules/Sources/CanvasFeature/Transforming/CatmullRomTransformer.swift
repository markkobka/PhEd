import Foundation
import CoreGraphics

final class CatmullRomTransformer: Transforming {
  
  // MARK: - Transforming
  func transform(_ drawing: Drawing) -> Drawing {
    return drawing.with(strokes: drawing.strokes.map { stroke in
      guard stroke.points.count > 1 else {
        return stroke
      }
      
      let delta: CGFloat = 1 / CGFloat(stroke.points.count)
      let nomralFunc = normalizeCurve(stroke.points, max: stroke.points.count , delta: delta)
      
      var points = [Point]()
      for i in stride(from: 0, to: 1, by: delta) {
        let point = nomralFunc(i)
        points.append(point)
      }
      
      return stroke.with(points: points)
    })
  }
  
  private func catmullRomSpline(points: [Point], t: CGFloat) -> Point {
    guard points.count >= 4 else {
      return points[0]
    }
    
    let i = floor(t)
    let index = Int(i)
    
    if(points.count <= index + 3) {
      return points[points.count - 2]
    }
    
    let p0 = points[index]
    let p1 = points[index + 1]
    let p2 = points[index + 2]
    let p3 = points[index + 3]
  
    let remainderT = t - i

    let q0 = (-1 * pow(remainderT, 3)) + (2 * pow(remainderT, 2)) + (-1 * remainderT)
    let q1 = (3 * pow(remainderT, 3)) + (-5 * pow(remainderT, 2)) + 2
    let q2 = (-3 * pow(remainderT, 3)) + (4 * pow(remainderT, 2)) + remainderT
    let q3 = pow(remainderT, 3) - pow(remainderT, 2)

    return p0.with(location: .init(
      x: 0.5 * ((p0.location.x * q0) + (p1.location.x * q1) + (p2.location.x * q2) + (p3.location.x * q3)),
      y: 0.5 * ((p0.location.y * q0) + (p1.location.y * q1) + (p2.location.y * q2) + (p3.location.y * q3))
    ))
  }
  
  private func approximate(curve: [Point], min: CGFloat, max: CGFloat, delta: CGFloat) -> [Point] {
    var points = [Point]()
    for t in stride(from: min, to: max, by: delta) {
      points.append(catmullRomSpline(points: curve, t: t))
    }
    return points
  }
  
  private func measureSegments(_ segments: [Point]) -> [CGFloat]{
    var lengths: [CGFloat] = [0]
    var lastPoint = segments[0]
    for i in 1..<segments.count {
      let currentPoint = segments[i]
      let dx = currentPoint.location.x - lastPoint.location.x
      let dy = currentPoint.location.y - lastPoint.location.y
      lengths.append(sqrt(pow(dx, 2) + pow(dy, 2)))
      lastPoint = currentPoint
    }
    return lengths
  }
  
  private func normalizeCurve(_ curve: [Point], max: Int, delta: CGFloat) -> ((CGFloat) -> Point) {
    var segmentLengths: [CGFloat] = [0]
    for i in stride(from: 1, to: CGFloat(max), by: 1) {
      let approximatePoints = approximate(curve: curve, min: i - 1, max: CGFloat(i), delta: delta)
      let approximationSegmentLengths = measureSegments(approximatePoints)
      let length = approximationSegmentLengths.reduce(0, +)
      segmentLengths.append(length)
    }
    
    let maxLength = segmentLengths.reduce(0, +)
    return { t in
      if(t < 0){
        return self.catmullRomSpline(points: curve, t: 0)
      } else if (t > 1){
        return self.catmullRomSpline(points: curve, t: 1)
      }
      
      let currentLength = t * maxLength
      var totalSegmentLength: CGFloat = 0
      var segmentIndex = 0
      while currentLength > totalSegmentLength + segmentLengths[segmentIndex + 1] {
        segmentIndex += 1
        totalSegmentLength += segmentLengths[segmentIndex]
      }


      let segmentLength = segmentLengths[segmentIndex + 1]
      let remainderLength = currentLength - totalSegmentLength
      let fractionalRemainder = segmentLength > 0 ? remainderLength / segmentLength : 0
      
      return self.catmullRomSpline(points: curve, t: CGFloat(segmentIndex) + fractionalRemainder)
    }
  }
}
