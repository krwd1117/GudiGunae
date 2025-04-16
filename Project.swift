import ProjectDescription

let project = Project(
    name: "GudiGunae",
    organizationName: "GudiGunae",
    packages: [
        .remote(url: "https://github.com/googleads/swift-package-manager-google-mobile-ads.git", requirement: .upToNextMajor(from: "12.2.0")),
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
                    "UIBackgroundModes": ["remote-notification"],
                    "GADApplicationIdentifier": "ca-app-pub-2148938110853335~6831955472",
                    "NSUserTrackingUsageDescription": "이 앱은 맞춤형 광고 제공 및 사용자 경험 향상을 위해 사용자의 데이터를 사용합니다.",
                    "SKAdNetworkItems": [
                        ["SKAdNetworkIdentifier": "cstr6suwn9.skadnetwork"],
                        ["SKAdNetworkIdentifier": "4fzdc2evr5.skadnetwork"],
                        ["SKAdNetworkIdentifier": "2fnua5tdw4.skadnetwork"],
                        ["SKAdNetworkIdentifier": "ydx93a7ass.skadnetwork"],
                        ["SKAdNetworkIdentifier": "p78axxw29g.skadnetwork"],
                        ["SKAdNetworkIdentifier": "v72qych5uu.skadnetwork"],
                        ["SKAdNetworkIdentifier": "ludvb6z3bs.skadnetwork"],
                        ["SKAdNetworkIdentifier": "cp8zw746q7.skadnetwork"],
                        ["SKAdNetworkIdentifier": "3sh42y64q3.skadnetwork"],
                        ["SKAdNetworkIdentifier": "c6k4g5qg8m.skadnetwork"],
                        ["SKAdNetworkIdentifier": "s39g8k73mm.skadnetwork"],
                        ["SKAdNetworkIdentifier": "3qy4746246.skadnetwork"],
                        ["SKAdNetworkIdentifier": "f38h382jlk.skadnetwork"],
                        ["SKAdNetworkIdentifier": "hs6bdukanm.skadnetwork"],
                        ["SKAdNetworkIdentifier": "mlmmfzh3r3.skadnetwork"],
                        ["SKAdNetworkIdentifier": "v4nxqhlyqp.skadnetwork"],
                        ["SKAdNetworkIdentifier": "wzmmz9fp6w.skadnetwork"],
                        ["SKAdNetworkIdentifier": "su67r6k2v3.skadnetwork"],
                        ["SKAdNetworkIdentifier": "yclnxrl5pm.skadnetwork"],
                        ["SKAdNetworkIdentifier": "t38b2kh725.skadnetwork"],
                        ["SKAdNetworkIdentifier": "7ug5zh24hu.skadnetwork"],
                        ["SKAdNetworkIdentifier": "gta9lk7p23.skadnetwork"],
                        ["SKAdNetworkIdentifier": "vutu7akeur.skadnetwork"],
                        ["SKAdNetworkIdentifier": "y5ghdn5j9k.skadnetwork"],
                        ["SKAdNetworkIdentifier": "v9wttpbfk9.skadnetwork"],
                        ["SKAdNetworkIdentifier": "n38lu8286q.skadnetwork"],
                        ["SKAdNetworkIdentifier": "47vhws6wlr.skadnetwork"],
                        ["SKAdNetworkIdentifier": "kbd757ywx3.skadnetwork"],
                        ["SKAdNetworkIdentifier": "9t245vhmpl.skadnetwork"],
                        ["SKAdNetworkIdentifier": "a2p9lx4jpn.skadnetwork"],
                        ["SKAdNetworkIdentifier": "22mmun2rn5.skadnetwork"],
                        ["SKAdNetworkIdentifier": "44jx6755aq.skadnetwork"],
                        ["SKAdNetworkIdentifier": "k674qkevps.skadnetwork"],
                        ["SKAdNetworkIdentifier": "4468km3ulz.skadnetwork"],
                        ["SKAdNetworkIdentifier": "2u9pt9hc89.skadnetwork"],
                        ["SKAdNetworkIdentifier": "8s468mfl3y.skadnetwork"],
                        ["SKAdNetworkIdentifier": "klf5c3l5u5.skadnetwork"],
                        ["SKAdNetworkIdentifier": "ppxm28t8ap.skadnetwork"],
                        ["SKAdNetworkIdentifier": "kbmxgpxpgc.skadnetwork"],
                        ["SKAdNetworkIdentifier": "uw77j35x4d.skadnetwork"],
                        ["SKAdNetworkIdentifier": "578prtvx9j.skadnetwork"],
                        ["SKAdNetworkIdentifier": "4dzt52r2t5.skadnetwork"],
                        ["SKAdNetworkIdentifier": "tl55sbb4fm.skadnetwork"],
                        ["SKAdNetworkIdentifier": "c3frkrj4fj.skadnetwork"],
                        ["SKAdNetworkIdentifier": "e5fvkxwrpn.skadnetwork"],
                        ["SKAdNetworkIdentifier": "8c4e2ghe7u.skadnetwork"],
                        ["SKAdNetworkIdentifier": "3rd42ekr43.skadnetwork"],
                        ["SKAdNetworkIdentifier": "97r2b46745.skadnetwork"],
                        ["SKAdNetworkIdentifier": "3qcr597p9d.skadnetwork"]
                    ]
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

                        # Debug 빌드인 경우 dSYM 업로드를 건너뛰기
                        if [ "$CONFIGURATION" = "Debug" ]; then
                            echo "⚠️ Skipping Crashlytics dSYM upload in Debug configuration."
                            exit 0
                        fi

                        echo "🔍 Locating GoogleService-Info.plist..."
                        GOOGLE_SERVICE_PLIST="${PROJECT_DIR}/DripNote/Resources/GoogleService-Info.plist"
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
                .package(product: "GoogleMobileAds"),
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
