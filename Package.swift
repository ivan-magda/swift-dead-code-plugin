// swift-tools-version: 6.0
import PackageDescription

// The swift-dead-code release this plugin runs; the release workflow of swift-dead-code
// updates both lines and tags this package with the same version.
let version = "0.1.3"
let checksum = "8e8da5d6f88f34d12829e6c924e2ea985ddb92c9affc6f06f6150025dd14eb16"

let package = Package(
  name: "swift-dead-code-plugin",
  products: [
    .plugin(name: "DeadCodeCommand", targets: ["DeadCodeCommand"])
  ],
  targets: [
    .plugin(
      name: "DeadCodeCommand",
      capability: .command(
        intent: .custom(
          verb: "dead-code",
          description: "Find dead code: check, scan, triage, baseline, prune-imports"
        )
      ),
      dependencies: ["SwiftDeadCodeBinary", "PeripheryBinary"]
    ),
    .binaryTarget(
      name: "SwiftDeadCodeBinary",
      url: "https://github.com/ivan-magda/swift-dead-code/releases/download/\(version)/swift-dead-code-\(version).artifactbundle.zip",
      checksum: checksum
    ),
    // Periphery 3.8.0, its last MIT release, which `scan` runs.
    .binaryTarget(
      name: "PeripheryBinary",
      url: "https://github.com/peripheryapp/periphery/releases/download/3.8.0/periphery-3.8.0.artifactbundle.zip",
      checksum: "a9c7bfb1483dde1f4b660bc64183161fde3b519b7392add51ec8fe8b846cf494"
    ),
  ]
)
