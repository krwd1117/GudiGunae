import ProjectDescription

let project = Project(
    name: "GuroGunae",
    targets: [
        .target(
            name: "GuroGunae",
            destinations: [.iPhone],
            product: .app,
            bundleId: "com.krwd.GuroGunae.app",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                    "NSLocationWhenInUseUsageDescription": "권한 요청",
                    "NSLocationAlwaysUsageDescription": "권한 요청"
                ]
            ),
            sources: ["GuroGunae/App/Sources/**"],
            resources: ["GuroGunae/App/Resources/**"],
            dependencies: [
                .external(name: "Supabase"),
                .external(name: "NMapsMap")
            ]
        ),
        .target(
            name: "GuroGunaeTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.krwd.GuroGunae.Tests",
            infoPlist: .default,
            sources: ["GuroGunae/Tests/**"],
            resources: [],
            dependencies: [.target(name: "GuroGunae")]
        ),
    ]
)
