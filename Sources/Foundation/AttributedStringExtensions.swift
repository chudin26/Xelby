//
//  AttributedStringExtensions.swift
//  Xelby
//
//  Created by Yuriy Chudin on 01.10.2020.
//  Copyright © 2020 chood. All rights reserved.
//

import Foundation

public extension String {
	
	func toUnderlined() -> NSAttributedString {
		let attributedString = NSMutableAttributedString(string: self)
		attributedString.addAttribute(.underlineStyle, value: 1, range: NSMakeRange(0, attributedString.length))
		
		return attributedString
	}
	
}
