//
//  Logger.swift
//  Xelby
//
//  Created by Yuriy Chudin on 22.07.2020.
//  Copyright © 2020 chood. All rights reserved.
//

import Foundation

public class Logger {

    public enum Level: Int {
        case verbose = 0
        case debug = 1
        case info = 2
        case warning = 3
        case error = 4
    }

	public static let shared = Logger()
	
	private var implementations: [LoggerProtocol] = []

	public static func addImplementation(_ impl: LoggerProtocol) {
		shared.implementations.append(impl)
	}
	
	public static func print(level: Logger.Level, _ message: Any, file: String = #file, function: String = #function, line: Int = #line) {
		shared.implementations.forEach { $0.print(level: level, message, file: file, function: function, line: line) }
	}
	
	public static func verbose(_ message: Any, file: String = #file, function: String = #function, line: Int = #line) {
		shared.implementations.forEach { $0.print(level: .verbose, message, file: file, function: function, line: line) }
	}

	public static func debug(_ message: Any, file: String = #file, function: String = #function, line: Int = #line) {
		shared.implementations.forEach { $0.print(level: .debug, message, file: file, function: function, line: line) }
	}

	public static func info(_ message: Any, file: String = #file, function: String = #function, line: Int = #line) {
		shared.implementations.forEach { $0.print(level: .info, message, file: file, function: function, line: line) }
	}

	public static func warning(_ message: Any, file: String = #file, function: String = #function, line: Int = #line) {
		shared.implementations.forEach { $0.print(level: .warning, message, file: file, function: function, line: line) }
	}

	public static func error(_ message: Any, file: String = #file, function: String = #function, line: Int = #line) {
		shared.implementations.forEach { $0.print(level: .error, message, file: file, function: function, line: line) }
	}

}


public protocol LoggerProtocol {
	func print(level: Logger.Level, _ message: Any, file: String, function: String, line: Int)
}
