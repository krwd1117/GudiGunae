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
                    "NSLocationWhenInUseUsageDescription": "앱 사용 중 주변 정보를 제공하기 위해 위치 접근이 필요합니다.",
                    "NSLocationAlwaysUsageDescription": "정확한 서비스 제공을 위해 앱이 닫혀 있을 때도 위치 정보를 사용합니다."
                ]
            ),
            sources: ["GudiGunae/App/Sources/**"],
            resources: ["GudiGunae/App/Resources/**"],
            dependencies: [
                .external(name: "NMapsMap"),
                .target(name: "Data"),
                .target(name: "Presentation"),
                .target(name: "Domain"),
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
                .external(name: "Kingfisher"),
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
