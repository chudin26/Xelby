//
//  NumberParser.swift
//  Xelby
//
//  Created by Yuriy Chudin on 30.09.2020.
//  Copyright © 2020 chood. All rights reserved.
//

import CoreGraphics

class NumberParser {
	
	struct CannotParseError: Error {
		let string: String
		
		var localizedDescription: String { "Cannot parse '\(string)'" }
	}
	
	let separator: Character
	
	init(separator: Character = ",") {
		self.separator = separator
	}

	func parse(from string: String) throws -> [Float] {
		return try string.split(separator: separator)
			.map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
			.map {
				if let value = Float($0) {
					return value
				} else {
					throw CannotParseError(string: $0)
				}
			}
	}

}
