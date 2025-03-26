import ProjectDescription

let project = Project(
    name: "GudiGunae",
    organizationName: "GudiGunae",
    packages: [
        .remote(url: "https://github.com/supabase-community/supabase-swift.git", requirement: .upToNextMajor(from: "2.25.0")),
        .remote(url: "https://github.com/navermaps/SPM-NMapsMap.git", requirement: .upToNextMajor(from: "3.16.0")),
        .remote(url: "https://github.com/onevcat/Kingfisher.git", requirement: .upToNextMajor(from: "8.2.0")),
        .remote(url: "https://github.com/firebase/firebase-ios-sdk.git", requirement: .upToNextMajor(from: "11.9.0")),
        .remote(url: "https://github.com/google/promises.git", requirement: .upToNextMajor(from: "2.3.1"))
    ],
    settings: .settings(
        base: [
            "OTHER_LDFLAGS": "$(inherited) -ObjC",
        ]
    ),
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
                    "NSLocationAlwaysUsageDescription": "정확한 서비스 제공을 위해 앱이 닫혀 있을 때도 위치 정보를 사용합니다.",
                    "UIBackgroundModes": ["remote-notification"]
                ]
            ),
            sources: ["GudiGunae/Sources/App/**"],
            resources: ["GudiGunae/Resources/**"],
            entitlements: .file(path: .relativeToRoot("GudiGunae/Resources/GudiGunae-Develop.entitlements")),
            scripts: [
                .post(
                    script: """
                        #!/bin/bash
                        set -e

                        echo "🔍 Locating GoogleService-Info.plist..."
                        GOOGLE_SERVICE_PLIST="${PROJECT_DIR}/GudiGunae/Resources/GoogleService-Info.plist"
                        if [ ! -f "$GOOGLE_SERVICE_PLIST" ]; then
                            echo "❌ GoogleService-Info.plist not found at $GOOGLE_SERVICE_PLIST"
                            exit 1
                        fi

                        echo "🔄 Finding all dSYM files..."
                        DSYM_PATH="${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}"
                        if [ ! -d "$DSYM_PATH" ]; then
                            echo "⚠️ dSYM folder not found at $DSYM_PATH"
                            exit 0
                        fi

                        echo "🚀 Uploading dSYM file using Firebase Crashlytics script"
                        "${BUILD_DIR%/Build/*}/SourcePackages/checkouts/firebase-ios-sdk/Crashlytics/run" -gsp "${GOOGLE_SERVICE_PLIST}" -p ios "${DSYM_PATH}"

                        echo "✅ dSYM upload complete!"
                    """,
                    name: "Upload dSYM to Crashlytics",
                    basedOnDependencyAnalysis: false
                )
            ],
            dependencies: [
                .package(product: "NMapsMap"),
                .package(product: "FirebaseCore"),
                .package(product: "FirebaseAnalytics"),
                .package(product: "FirebaseCrashlytics"),
                .package(product: "FirebaseMessaging"), 
                .target(name: "Data"),
                .target(name: "Presentation"),
                .target(name: "Domain"),
                .target(name: "Core"),
                .target(name: "DI"),
            ],
            settings: .settings(
                configurations: [
                    .debug(name: "Debug", settings: [:], xcconfig: nil),
                    .release(name: "Release", settings: [
                        "CODE_SIGN_ENTITLEMENTS": "GudiGunae/Resources/GudiGunae-Production.entitlements"
                    ], xcconfig: nil)
                ]
            )
        ),
        .target(
            name: "Domain",
            destinations: [.iPhone],
            product: .framework,
            bundleId: "com.krwd.GudiGunae.domain",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["GudiGunae/Sources/Domain/**"],
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
            sources: ["GudiGunae/Sources/Data/**"],
            dependencies: [
                .package(product: "Supabase"),
                // .external(name: "Supabase"),
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
            sources: ["GudiGunae/Sources/Presentation/**"],
            dependencies: [
                .package(product: "Kingfisher"),
                .target(name: "Domain"),
                .target(name: "Core"),
                .target(name: "DI"),
            ]
        ),
        .target(
            name: "Core",
            destinations: [.iPhone],
            product: .framework,
            bundleId: "com.krwd.GudiGunae.core",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["GudiGunae/Sources/Core/**"],
            dependencies: []
        ),
        .target(
            name: "DI",
            destinations: [.iPhone],
            product: .framework,
            bundleId: "com.krwd.GudiGunae.di",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["GudiGunae/Sources/DI/**"],
            dependencies: [
                .target(name: "Data"),
                .target(name: "Domain")
            ]
        ),
        .target(
            name: "GudiGunaeTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "com.krwd.GudiGunae.tests",
            infoPlist: .default,
            sources: ["GudiGunae/Tests/**"],
            resources: [],
            dependencies: [.target(name: "GudiGunae")]
        ),
    ]
)
