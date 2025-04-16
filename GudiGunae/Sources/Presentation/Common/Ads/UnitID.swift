import Foundation

public enum UnitId {
    case 메인화면_하단_배너
    case 모아보기_상단_배너
    case 메뉴_상세보기_하단_배너
    case 설정화면_하단_배너
    
    var rawValue: String {
    #if DEBUG
            return "ca-app-pub-3940256099942544/2435281174"
    #endif
        switch self {
        case .메인화면_하단_배너:
            return "ca-app-pub-2148938110853335/1419846690"
        case .모아보기_상단_배너:
            return "ca-app-pub-2148938110853335/8774396999"
        case .메뉴_상세보기_하단_배너:
            return "ca-app-pub-2148938110853335/7949596029"
        case .설정화면_하단_배너:
            return "ca-app-pub-2148938110853335/7956139342"
        }
    }
}
