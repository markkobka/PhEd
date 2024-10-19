import UIKit

public struct ToolbarState {
  public var tools: [Tool]
  public var mode: Mode
  public var selectedIndex: Int
  
  public var font: Font
  
  public var shapes: [Shape]
  
  public init(
    tools: [Tool],
    font: Font,
    shapes: [Shape],
    mode: Mode,
    selectedIndex: Int = 0
  ) {
    self.tools = tools
    self.font = font
    self.shapes = shapes
    self.mode = mode
    self.selectedIndex = selectedIndex
  }
  

}


// MARK: - Initial state
public extension ToolbarState {
  static var `default`: Self {
    .init(
      tools: [
        .init(
          tool: .brush,
          variant: .round,
          variants: [.round, .arrow],
          color: .white,
          strokeSize: 10
        ),
        .init(
          tool: .marker,
          variant: .round,
          color: .blue,
          strokeSize: 10
        ),
        .init(
          tool: .neon,
          variant: .round,
          variants: [.round, .arrow],
          color: .red,
          strokeSize: 10
        ),
        .init(
          tool: .pencil,
          variant: .round,
          color: .green,
          strokeSize: 10
        ),
        .init(tool: .lasso),
        .init(
          tool: .eraser,
          variant: .eraser,
          variants: [.eraser, .object, .blur],
          strokeSize: 72,
          maxStrokeSize: 72
        ),
      ],
      font: .init(style: .default, alignment: .left),
      shapes: [.rectangle, .ellipse, .bubble, .star, .arrow],
      mode: .drawing
    )
  }
}

// MARK: - Utils
public extension ToolbarState {
  
  var selectedTool: Tool {
    tools[selectedIndex]
  }
  
  var color: UIColor? {
    tools[selectedIndex].color
  }
  
}


// MARK: - Nested types

public extension ToolbarState {
  
  enum Mode {
    case drawing
    case adjusting
    case texting
  }
 
  struct Font {
    
    public let style: Style
    public let alignment: NSTextAlignment
        
    public enum Style {
      case `default`
      case filled
      case semi
      case stroke
    }
    
    func with(style: Style? = nil, alignment: NSTextAlignment? = nil) -> Self {
      .init(
        style: style ?? self.style,
        alignment: alignment ?? self.alignment
      )
    }
  }
  
  
  enum Shape {
    case rectangle
    case ellipse
    case bubble
    case star
    case arrow
  }

  struct Tool {
    
    public let tool: Tool
    public let variant: Variant
    public let variants: [Variant]
    public let color: UIColor?
    public let strokeSize: CGFloat
    public let minStrokeSize: CGFloat
    public let maxStrokeSize: CGFloat

    public init(tool: Tool, variant: Variant = .round, variants: [Variant] = [], color: UIColor? = nil, strokeSize: CGFloat = 24, minStrokeSize: CGFloat = 4, maxStrokeSize: CGFloat = 48) {
      self.tool = tool
      self.variant = variant
      self.variants = variants
      self.color = color
      self.strokeSize = strokeSize
      self.minStrokeSize = minStrokeSize
      self.maxStrokeSize = maxStrokeSize
    }
    
    public enum Tool {
      case brush
      case pencil
      case marker
      case neon
      case lasso
      case eraser
    }
    
    public enum Variant {
      case round
      case arrow
      case eraser
      case blur
      case object
    }
    
    func with(variant: Variant? = nil, color: UIColor? = nil, strokeSize: CGFloat? = nil) -> Self {
      .init(
        tool: tool,
        variant: variant ?? self.variant,
        variants: variants,
        color: color ?? self.color,
        strokeSize: strokeSize ?? self.strokeSize
      )
    }
  }
}


extension ToolbarState.Tool: Equatable {}
