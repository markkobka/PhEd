// swift-tools-version:5.5

import PackageDescription

let package = Package(
  name: "Modules",
  platforms: [
    .iOS(.v13)
  ],
  products: [
    .library(
      name: "App",
      type: .static,
      targets: ["App"]
    ),
    .library(
      name: "WelcomeFeature",
      type: .static,
      targets: ["WelcomeFeature"]
    ),
    .library(
      name: "PhotoPickerFeature",
      type: .static,
      targets: ["PhotoPickerFeature"]
    ),
    .library(
      name: "EditorFeature",
      type: .static,
      targets: ["EditorFeature"]
    ),
    .library(
      name: "CanvasFeature",
      type: .static,
      targets: ["CanvasFeature"]
    ),
    .library(
      name: "TextEditFeature",
      type: .static,
      targets: ["TextEditFeature"]
    ),
    .library(
      name: "ToolbarFeature",
      type: .static,
      targets: ["ToolbarFeature"]
    ),
    .library(
      name: "ColorPickerFeature",
      type: .static,
      targets: ["ColorPickerFeature"]
    )
  ],
  dependencies: [
    .package(path: "Core"),
    .package(path: "Dependencies"),
  ],
  targets: [
    .target(
      name: "App",
      dependencies: [
        "Core",
        "WelcomeFeature",
        "PhotoPickerFeature",
        "EditorFeature",
        "ColorPickerFeature",
        .product(
          name: "_Lottie",
          package: "Dependencies"
        )
      ],
      resources: [
        .process("Resources")
      ]
    ),
    .target(
      name: "WelcomeFeature",
      dependencies: [
        "Core",
        .product(
          name: "_Lottie",
          package: "Dependencies"
        )
      ],
      resources: [
        .process("Resources")
      ]
    ),
    .target(
      name: "PhotoPickerFeature",
      dependencies: [
        "Core",
      ]
    ),
    .target(
      name: "EditorFeature",
      dependencies: [
        "Core",
        "ToolbarFeature",
        "CanvasFeature",
        "TextEditFeature",
        .product(
          name: "_Lottie",
          package: "Dependencies"
        )
      ]
    ),
    .target(
      name: "ToolbarFeature",
      dependencies: [
        "Core",
        "ColorPickerFeature",
        .product(
          name: "_Lottie",
          package: "Dependencies"
        )
      ],
      resources: [
        .process("Resources")
      ]
    ),
    .target(
      name: "ColorPickerFeature",
      dependencies: [
        "Core"
      ],
      resources: [
        .process("Resources")
      ]
    ),
    .target(
      name: "CanvasFeature",
      dependencies: [
        "Core",
        .product(
          name: "_Alloy",
          package: "Dependencies"
        )
      ]
    ),
    .target(
      name: "TextEditFeature",
      dependencies: [
        "Core",
      ]
    ),
  ]
)
