import Foundation

public class APIKeyManager {
    
    public init() {}
    
    private func loadAPIKeys() -> [String: Any] {
        // Bundle에서 APIKeys.plist 파일의 URL을 찾음
        guard let bundle = Bundle(identifier: "com.krwd.GudiGunae.app"),
              let url = bundle.url(forResource: "APIKeys", withExtension: "plist"),
              let data = try? Data(contentsOf: url),
              let plist = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: Any] else {
            fatalError("APIKeys.plist 파일을 찾을 수 없거나 로드할 수 없습니다.")
        }
        return plist
    }

    public func getNaverMapClientID() -> String {
        let keys = loadAPIKeys()
        guard let clientID = keys["NaverMapClientID"] as? String, !clientID.isEmpty else {
            fatalError("APIKeys.plist에 NaverMapClientID가 설정되어 있지 않습니다.")
        }
        return clientID
    }
    
    public func getSupabaseURL() -> URL {
        let keys = loadAPIKeys()
        guard
            let urlString = keys["SupabaseURL"] as? String,
            !urlString.isEmpty,
            let url = URL(string: urlString)
        else {
            fatalError("APIKeys.plist에 NaverMapClientID가 설정되어 있지 않습니다.")
        }
        return url
    }
    
    public func getSupabaseKEY() -> String {
        let keys = loadAPIKeys()
        guard
            let key = keys["SupabaseKey"] as? String,
            !key.isEmpty
        else {
            fatalError("APIKeys.plist에 SupabaseKey가 설정되어 있지 않습니다.")
        }
        return key
    }
}
