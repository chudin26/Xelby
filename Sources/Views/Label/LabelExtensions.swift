//
//  LabelExtensions.swift
//  Xelby
//
//  Created by Yuriy Chudin on 31.01.2020.
//  Copyright © 2020 chood. All rights reserved.
//

import UIKit

public extension UILabel {

	func makeUnderlined() {
		guard let text = text else { return }
		
		let attributedString = NSMutableAttributedString(string: text)
		attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, text.count))
		
		attributedText = attributedString
	}

}
