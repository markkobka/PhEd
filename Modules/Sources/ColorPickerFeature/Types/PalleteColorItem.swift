import Foundation
import CoreGraphics

import class UIKit.UIColor

struct PalleteColorItem: Hashable {
  let colorSpace: ColorSpace
  let red: CGFloat
  let green: CGFloat
  let blue: CGFloat
  let alpha: CGFloat
  
  var uiColor: UIColor {
    let fallbackColor = UIColor.black
    let colorSpaceName = colorSpace.name
    
    guard let colorSpace = CGColorSpace(name: colorSpaceName)
    else { return fallbackColor }
    
    let component: [CGFloat] = [
      red,
      green,
      blue,
      alpha
    ]
    
    guard let cgColor = CGColor(
      colorSpace: colorSpace,
      components: component
    ) else { return fallbackColor }
    
    return UIColor(cgColor: cgColor)
  }
}

// MARK: - Apple pallete values

func palleteColors(
  for colorSpace: ColorSpace
) -> [PalleteColorItem] {
  return [
    /// 0
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 1,
      green: 1,
      blue: 1,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.921659,
      green: 0.921659,
      blue: 0.921659,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.839216,
      green: 0.839216,
      blue: 0.839216,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.760784,
      green: 0.760784,
      blue: 0.760784,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.678431,
      green: 0.678431,
      blue: 0.678431,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.6,
      green: 0.6,
      blue: 0.6,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.521569,
      green: 0.521569,
      blue: 0.521569,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.439216,
      green: 0.439216,
      blue: 0.439216,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.360784,
      green: 0.360784,
      blue: 0.360784,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.278431,
      green: 0.278431,
      blue: 0.278431,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.2,
      green: 0.2,
      blue: 0.2,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0,
      green: 0,
      blue: 0,
      alpha: 1
    ),
    /// 1
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0,
      green: 0.215686,
      blue: 0.290196,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.00392157,
      green: 0.113725,
      blue: 0.341176,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.0666667,
      green: 0.0196078,
      blue: 0.231373,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.180392,
      green: 0.0235294,
      blue: 0.239216,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.235294,
      green: 0.027451,
      blue: 0.105882,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.360784,
      green: 0.027451,
      blue: 0.00392157,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.352941,
      green: 0.109804,
      blue: 0,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.345098,
      green: 0.2,
      blue: 0,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.337255,
      green: 0.239216,
      blue: 0,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.4,
      green: 0.380392,
      blue: 0,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.309804,
      green: 0.333333,
      blue: 0.0156863,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.14902,
      green: 0.243137,
      blue: 0.058823,
      alpha: 1
    ),
    /// 2
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0,
      green: 0.301961,
      blue: 0.396078,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.00392157,
      green: 0.184314,
      blue: 0.482353,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.101961,
      green: 0.0392157,
      blue: 0.321569,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.270588,
      green: 0.0509804,
      blue: 0.34902,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.333333,
      green: 0.0627451,
      blue: 0.160784,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.513725,
      green: 0.0666667,
      blue: 0,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.482353,
      green: 0.160784,
      blue: 0,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.478431,
      green: 0.290196,
      blue: 0,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.470588,
      green: 0.345098,
      blue: 0,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.552941,
      green: 0.52549,
      blue: 0.00784314,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.435294,
      green: 0.462745,
      blue: 0.0392157,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.219608,
      green: 0.341176,
      blue: 0.101961,
      alpha: 1
    ),
    /// 3
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.00392157,
      green: 0.431373,
      blue: 0.560784,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0,
      green: 0.258824,
      blue: 0.662745,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.172549,
      green: 0.0352941,
      blue: 0.466667,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.380392,
      green: 0.0941176,
      blue: 0.486275,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.47451,
      green: 0.101961,
      blue: 0.239216,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.709804,
      green: 0.101961,
      blue: 0,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.678431,
      green: 0.243137,
      blue: 0,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.662745,
      green: 0.407843,
      blue: 0,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.65098,
      green: 0.482353,
      blue: 0.00392157,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.768627,
      green: 0.737255,
      blue: 0,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.607843,
      green: 0.647059,
      blue: 0.054902,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.305882,
      green: 0.478431,
      blue: 0.152941,
      alpha: 1
    ),
    /// 4
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0,
      green: 0.54902,
      blue: 0.705882,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0,
      green: 0.337255,
      blue: 0.839216,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.215686,
      green: 0.101961,
      blue: 0.580392,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.478431,
      green: 0.129412,
      blue: 0.619608,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.6,
      green: 0.141176,
      blue: 0.309804,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.886275,
      green: 0.141176,
      blue: 0,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.854902,
      green: 0.317647,
      blue: 0,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.827451,
      green: 0.513725,
      blue: 0.00392157,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.819608,
      green: 0.615686,
      blue: 0.00392157,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.960784,
      green: 0.92549,
      blue: 0,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.764706,
      green: 0.819608,
      blue: 0.0901961,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.4,
      green: 0.615686,
      blue: 0.203922,
      alpha: 1
    ),
    /// 5
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0,
      green: 0.631373,
      blue: 0.847059,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0,
      green: 0.380392,
      blue: 0.996078,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.301961,
      green: 0.133333,
      blue: 0.698039,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.596078,
      green: 0.164706,
      blue: 0.737255,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.72549,
      green: 0.176471,
      blue: 0.364706,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 1,
      green: 0.25098,
      blue: 0.0823529,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 1,
      green: 0.415686,
      blue: 0,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 1,
      green: 0.670588,
      blue: 0.00392157,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.992157,
      green: 0.780392,
      blue: 0,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.996078,
      green: 0.984314,
      blue: 0.254902,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.85098,
      green: 0.92549,
      blue: 0.215686,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.462745,
      green: 0.733333,
      blue: 0.25098,
      alpha: 1
    ),
    /// 6
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.00392157,
      green: 0.780392,
      blue: 0.988235,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.227451,
      green: 0.529412,
      blue: 0.996078,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.368627,
      green: 0.188235,
      blue: 0.921569,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.745098,
      green: 0.219608,
      blue: 0.952941,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.901961,
      green: 0.231373,
      blue: 0.478431,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 1,
      green: 0.384314,
      blue: 0.313725,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 1,
      green: 0.52549,
      blue: 0.282353,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.996078,
      green: 0.705882,
      blue: 0.247059,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.996078,
      green: 0.796078,
      blue: 0.243137,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 1,
      green: 0.968627,
      blue: 0.419608,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.894118,
      green: 0.937255,
      blue: 0.396078,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.588235,
      green: 0.827451,
      blue: 0.372549,
      alpha: 1
    ),
    /// 7
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.321569,
      green: 0.839216,
      blue: 0.988235,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.454902,
      green: 0.654902,
      blue: 1,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.52549,
      green: 0.309804,
      blue: 0.996078,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.827451,
      green: 0.341176,
      blue: 0.996078,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.933333,
      green: 0.443137,
      blue: 0.619608,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 1,
      green: 0.54902,
      blue: 0.509804,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 1,
      green: 0.647059,
      blue: 0.490196,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 1,
      green: 0.780392,
      blue: 0.466667,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 1,
      green: 0.85098,
      blue: 0.466667,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 1,
      green: 0.976471,
      blue: 0.580392,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.917647,
      green: 0.94902,
      blue: 0.560784,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.694118,
      green: 0.866667,
      blue: 0.545098,
      alpha: 1
    ),
    /// 8
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.576471,
      green: 0.890196,
      blue: 0.992157,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.654902,
      green: 0.776471,
      blue: 1,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.694118,
      green: 0.54902,
      blue: 0.996078,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.886275,
      green: 0.572549,
      blue: 0.996078,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.956863,
      green: 0.643137,
      blue: 0.752941,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 1,
      green: 0.709804,
      blue: 0.686275,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 1,
      green: 0.772549,
      blue: 0.670588,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 1,
      green: 0.85098,
      blue: 0.658824,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.996078,
      green: 0.894118,
      blue: 0.658824,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 1,
      green: 0.984314,
      blue: 0.72549,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.94902,
      green: 0.968627,
      blue: 0.717647,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.803922,
      green: 0.909804,
      blue: 0.709804,
      alpha: 1
    ),
    /// 9
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.796078,
      green: 0.941176,
      blue: 1,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.827451,
      green: 0.886275,
      blue: 1,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.85098,
      green: 0.788235,
      blue: 0.996078,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.937255,
      green: 0.792157,
      blue: 1,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.976471,
      green: 0.827451,
      blue: 0.878431,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 1,
      green: 0.858824,
      blue: 0.847059,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 1,
      green: 0.886275,
      blue: 0.839216,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 1,
      green: 0.92549,
      blue: 0.831373,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 1,
      green: 0.94902,
      blue: 0.835294,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.996078,
      green: 0.988235,
      blue: 0.866667,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.968627,
      green: 0.980392,
      blue: 0.858824,
      alpha: 1
    ),
    PalleteColorItem(
      colorSpace: colorSpace,
      red: 0.87451,
      green: 0.933333,
      blue: 0.831373,
      alpha: 1
    )
  ]
}
