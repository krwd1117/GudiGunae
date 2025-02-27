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
                    "CFBundleDisplayName": "구디구내",
                    "NSLocationWhenInUseUsageDescription": "권한 요청",
                    "NSLocationAlwaysUsageDescription": "권한 요청"
                ]
            ),
            sources: ["GudiGunae/App/Sources/**"],
            resources: ["GudiGunae/App/Resources/**"],
            dependencies: [
                .external(name: "NMapsMap"),
                .external(name: "Kingfisher"),
                .target(name: "Data"),
                .target(name: "Presentation"),
                .target(name: "Core"),
            ]
        ),
        .target(
            name: "Domain",
            destinations: [.iPhone],
            product: .framework,
            bundleId: "com.krwd.GudiGunae.domain",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["GudiGunae/Domain/Sources/**"],
            resources: ["GudiGunae/Domain/Resources/**"],
            dependencies: [
                .target(name: "Core"),
            ]
        ),
        .target(
            name: "Data",
            destinations: [.iPhone],
            product: .framework,
            bundleId: "com.krwd.GudiGunae.data",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["GudiGunae/Data/Sources/**"],
            resources: ["GudiGunae/Data/Resources/**"],
            dependencies: [
                .external(name: "Supabase"),
                .target(name: "Domain")
            ]
        ),
        .target(
            name: "Presentation",
            destinations: [.iPhone],
            product: .framework,
            bundleId: "com.krwd.GudiGunae.presentation",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["GudiGunae/Presentation/Sources/**"],
            resources: ["GudiGunae/Presentation/Resources/**"],
            dependencies: [
                .target(name: "Domain"),
                .target(name: "Core"),
            ]
        ),
        .target(
            name: "Core",
            destinations: [.iPhone],
            product: .framework,
            bundleId: "com.krwd.GudiGunae.core",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["GudiGunae/Core/Sources/**"],
            resources: ["GudiGunae/Core/Resources/**"],
            dependencies: []
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
