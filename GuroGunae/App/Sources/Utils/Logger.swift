//
//  Logger.swift
//  GuroGunae
//
//  Created by 김정완 on 2/25/25.
//


//
//  Logger.swift
//  GuroGunae
//
//  Created by 김정완 on 2/25/25.
//

import Foundation
import OSLog

public final class Logger {
    public static let shared = Logger()
    fileprivate static let dateFormatter = DateFormatter()
    private static let subsystem = Bundle.main.bundleIdentifier ?? ""
    private static let osLog = OSLog(subsystem: subsystem, category: "Application")
    
    // 현재 로그 레벨 (이 레벨 이상의 로그만 출력)
    public static var minimumLogLevel: Level = .debug
    
    public enum Level: Int {
        case debug = 0    // 디버깅 목적의 상세한 정보
        case info = 1     // 일반적인 정보성 메시지
        case warning = 2  // 오류나 경고 메시지
        case error = 3    // 심각한 오류나 시스템 장애
        
        fileprivate var prefix: String {
            switch self {
            case .debug:
                return "[💬 DEBUG]"
            case .info:
                return "[ℹ️ INFO]"
            case .warning:
                return "[⚠️ WARNING]"
            case .error:
                return "[‼️ ERROR]"
            }
        }
        
        fileprivate var osLogType: OSLogType {
            switch self {
            case .debug:
                return .debug
            case .info:
                return .info
            case .warning:
                return .error
            case .error:
                return .fault
            }
        }
    }
    
    private init() {
        Self.dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    }
    
    private class func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last ?? ""
    }
    
    private class func log(level: Level, message: Any, filename: String = #file, line: Int = #line, funcName: String = #function, thread: Bool = false) {
        // 현재 설정된 최소 로그 레벨보다 낮은 레벨의 로그는 출력하지 않음
        guard level.rawValue >= minimumLogLevel.rawValue else { return }
        
        let time = Self.dateFormatter.string(from: Date())
        let threadInfo = thread ? "[\(Thread.isMainThread ? "Main" : "Background")] " : ""
        let file = sourceFileName(filePath: filename)
        let logMessage = """
            ----------------------------------------
            \(time) \(level.prefix) \(threadInfo)
            [\(file)]:\(line) \(funcName)
            👉 \(message)
            ----------------------------------------
            """
        
        // Log to Console.app
        os_log(
            .init(stringLiteral: "%{public}@"),
            log: Self.osLog,
            type: level.osLogType,
            logMessage
        )
        
        // 콘솔에도 출력 (디버깅 용도)
        #if DEBUG
        print(logMessage)
        #endif
    }
}

// MARK: - Public Methods
public extension Logger {
    static func d(_ message: Any, filename: String = #file, line: Int = #line, funcName: String = #function, thread: Bool = true) {
        log(level: .debug, message: message, filename: filename, line: line, funcName: funcName, thread: thread)
    }
    
    static func i(_ message: Any, filename: String = #file, line: Int = #line, funcName: String = #function, thread: Bool = false) {
        log(level: .info, message: message, filename: filename, line: line, funcName: funcName, thread: thread)
    }
    
    static func w(_ message: Any, filename: String = #file, line: Int = #line, funcName: String = #function, thread: Bool = true) {
        log(level: .warning, message: message, filename: filename, line: line, funcName: funcName, thread: thread)
    }
    
    static func e(_ message: Any, filename: String = #file, line: Int = #line, funcName: String = #function, thread: Bool = true) {
        log(level: .error, message: message, filename: filename, line: line, funcName: funcName, thread: thread)
    }
    
    // 로그 레벨 설정 메서드
    static func setLogLevel(_ level: Level) {
        minimumLogLevel = level
    }
}

// MARK: - Date Extension
fileprivate extension Date {
    func toString() -> String {
        return Logger.dateFormatter.string(from: self)
    }
}
