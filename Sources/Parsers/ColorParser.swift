//
//  ColorParser.swift
//  Xelby
//
//  Created by Yuriy Chudin on 30.09.2020.
//  Copyright © 2020 chood. All rights reserved.
//

import CoreGraphics

class ColorParser {
	
	struct CannotParseHexError: Error {
		let hexString: String
		
		var localizedDescription: String { "Cannot parse '\(hexString)'" }
	}
	
	let separator: Character
	
	init(separator: Character = ",") {
		self.separator = separator
	}

	func parse(from string: String) throws -> [UIColor] {
		return try string.split(separator: separator)
			.map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
			.map {
				if let value = UInt32($0, radix: 16) {
					return UIColor(hex: value)
				} else {
					throw CannotParseHexError(hexString: $0)
				}
			}
	}

}
