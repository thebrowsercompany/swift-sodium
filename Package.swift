// swift-tools-version:5.9
import PackageDescription

let clibsodiumTarget: Target
#if os(OSX) || os(macOS) || os(tvOS) || os(watchOS) || os(iOS)
    clibsodiumTarget = .binaryTarget(
        name: "Clibsodium",
        path: "Clibsodium.xcframework")
#elseif os(Windows)
    clibsodiumTarget = .target(name: "Clibsodium",
                    path: "Clibsodium-win",
                      publicHeadersPath: "include",
                    //   cSettings: [
                    //     .headerSearchPath("include"),
                    //   ],
              
                      cxxSettings: [
                        .define("__swift__"),
                        .define("INTERNAL_EXPERIMENTAL"),
                        .define("SODIUM_STATIC"),
                        .define("_CRT_SECURE_NO_WARNINGS",
                                .when(platforms: [.windows])),
                      ],
                      swiftSettings: [
                        .interoperabilityMode(.Cxx),
                      ],
                      linkerSettings: [
                        .unsafeFlags([
                          "-Lx64/Release/v143/static", //spm/checkouts/swift-sodium/Clibsodium-win/
                        ]),
                        .linkedLibrary("libsodium"),
                      ]
                      )
#else
    clibsodiumTarget = .systemLibrary(
        name: "Clibsodium",
        path: "Clibsodium",
        pkgConfig: "libsodium",
        providers: [
            .apt(["libsodium-dev"]),
            .brew(["libsodium"]),
            // Waiting for bug to be fixed: https://bugs.swift.org/browse/SR-14038
            // .yum(["libsodium-devel"])
        ])
#endif

let package = Package(
    name: "Sodium",
    products: [
        .library(
            name: "Clibsodium",
            targets: ["Clibsodium"]),
        .library(
            name: "Sodium",
            targets: ["Sodium"]),
    ],
    targets: [
        clibsodiumTarget,
        .target(
            name: "Sodium",
            dependencies: ["Clibsodium"],
            path: "Sodium",
            exclude: ["libsodium", "Info.plist"],
                                  swiftSettings: [
                        .interoperabilityMode(.Cxx),
                      ]),
        .testTarget(
            name: "SodiumTests",
            dependencies: ["Sodium"],
            exclude: ["Info.plist"]),
    ]
)
