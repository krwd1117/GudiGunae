import ProjectDescription

let project = Project(
    name: "GudiGunae",
    targets: [
        .target(
            name: "GudiGunae",
            destinations: [.iPhone],
            product: .app,
            bundleId: "com.krwd.GudiGunae.app",
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
            sources: ["GudiGunae/App/Sources/**"],
            resources: ["GudiGunae/App/Resources/**"],
            dependencies: [
                .external(name: "Supabase"),
                .external(name: "NMapsMap"),
                .external(name: "Kingfisher")
            ]
        ),
        .target(
            name: "GudiGunaeTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.krwd.GudiGunae.Tests",
            infoPlist: .default,
            sources: ["GudiGunae/Tests/**"],
            resources: [],
            dependencies: [.target(name: "GudiGunae")]
        ),
    ]
)
