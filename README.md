# swift-dead-code-plugin

A SwiftPM command plugin that runs [swift-dead-code](https://github.com/ivan-magda/swift-dead-code)
on your package. It uses the prebuilt binary from the matching swift-dead-code release, so it
builds nothing and adds no dependencies to your package graph. It brings Periphery 3.8.0 along,
so `scan` needs no separate install. macOS only.

Add it to your `Package.swift`:

```swift
dependencies: [
  .package(url: "https://github.com/ivan-magda/swift-dead-code-plugin", from: "0.1.0"),
],
```

Then run any subcommand. The tool runs `swift`, `git` and `periphery`, so the plugin needs the
sandbox off:

```bash
swift package --disable-sandbox dead-code check
swift package --disable-sandbox dead-code scan --output .build/dead-code/scan
```

Each version of this package runs the swift-dead-code release with the same version. The
[swift-dead-code README](https://github.com/ivan-magda/swift-dead-code#readme) covers the
subcommands and `.deadcode.yml`.
