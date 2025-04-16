import SwiftUI
import GoogleMobileAds

public struct BannerAdContainerView: View {
    private let unitID: UnitId
    private let backgroundColor: Color

    public init(unitID: UnitId, backgroundColor: Color = .clear) {
        self.unitID = unitID
        self.backgroundColor = backgroundColor
    }

    public var body: some View {
        BannerAdRepresentableView(adUnitID: unitID.rawValue)
            .frame(height: 50)
            .background(backgroundColor)
    }
}

private struct BannerAdRepresentableView: UIViewRepresentable {
    let adUnitID: String

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    func makeUIView(context: Context) -> BannerView {
        let bannerView = BannerView(adSize: AdSizeBanner)
        bannerView.adUnitID = adUnitID
        bannerView.rootViewController = UIApplication.shared.rootViewController
        bannerView.delegate = context.coordinator
        bannerView.load(Request())
        return bannerView
    }

    func updateUIView(_ uiView: BannerView, context: Context) {}

    class Coordinator: NSObject, BannerViewDelegate {
        func bannerViewDidReceiveAd(_ bannerView: BannerView) {
            print("✅ 배너 광고 로드 완료")
        }

        func bannerView(_ bannerView: BannerView, didFailToReceiveAdWithError error: Error) {
            print("❌  : \(error.localizedDescription)")
        }
    }
}

private extension UIApplication {
    var rootViewController: UIViewController? {
        self.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?
            .windows
            .first { $0.isKeyWindow }?
            .rootViewController
    }
}
