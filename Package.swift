// swift-tools-version: 5.9
// This is a Skip (https://skip.tools) package,
// containing a Swift Package Manager project
// that will use the Skip build plugin to transpile the
// Swift Package, Sources, and Tests into an
// Android Gradle Project with Kotlin sources and JUnit tests.
import PackageDescription

let package = Package(
    name: "skip-week-calendar",
    defaultLocalization: "en",
    platforms: [.iOS(.v16), .macOS(.v13)],
    products: [
        .library(
            name: "SkipWeekCalendar", type: .dynamic,
            targets: ["SkipWeekCalendar"])
    ],
    dependencies: [
        .package(url: "https://source.skip.tools/skip.git", from: "1.1.3"),
        .package(url: "https://source.skip.tools/skip-ui.git", from: "1.11.2"),
        .package(
            url: "https://source.skip.tools/skip-foundation.git", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "SkipWeekCalendar",
            dependencies: [
                .product(name: "SkipFoundation", package: "skip-foundation"),
                .product(name: "SkipUI", package: "skip-ui"),
            ],
            plugins: [.plugin(name: "skipstone", package: "skip")]
        ),
        .testTarget(
            name: "SkipWeekCalendarTests",
            dependencies: [
                "SkipWeekCalendar", .product(name: "SkipTest", package: "skip"),
            ],
            plugins: [.plugin(name: "skipstone", package: "skip")]
        ),
    ]
)
