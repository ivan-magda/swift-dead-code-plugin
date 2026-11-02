import Foundation
import PackagePlugin

/// `swift package --disable-sandbox dead-code <subcommand> ...` runs swift-dead-code on this
/// package, with Periphery 3.8.0 first on the PATH for `scan`.
///
/// The tool runs `swift`, `git` and `periphery` itself, so the plugin needs the sandbox off.
@main
struct DeadCodeCommand: CommandPlugin {
  func performCommand(context: PluginContext, arguments: [String]) async throws {
    let tool = try context.tool(named: "swift-dead-code")
    let periphery = try context.tool(named: "periphery")
    var environment = ProcessInfo.processInfo.environment
    environment["PATH"] = [periphery.url.deletingLastPathComponent().path, environment["PATH"]]
      .compactMap { $0 }
      .joined(separator: ":")
    let process = Process()
    process.executableURL = tool.url
    process.arguments = arguments + ["--project-root", context.package.directoryURL.path]
    process.currentDirectoryURL = context.package.directoryURL
    process.environment = environment
    try process.run()
    process.waitUntilExit()
    if process.terminationStatus != 0 {
      Diagnostics.error("swift-dead-code exited with status \(process.terminationStatus)")
    }
  }
}
