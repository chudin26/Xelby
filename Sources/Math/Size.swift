//
//  Size.swift
//  Xelby
//
//  Created by Yuriy Chudin on 23.01.2020.
//  Copyright © 2020 chood. All rights reserved.
//

import CoreGraphics

public extension CGSize {
	
	init(_ width: CGFloat, _ height: CGFloat) {
		self.init(width: width, height: height)
	}
	
	static func * (size: CGSize, coef: CGFloat) -> CGSize {
		return CGSize(size.width * coef, size.height * coef)
	}

	static func / (size: CGSize, coef: CGFloat) -> CGSize {
		return CGSize(size.width / coef, size.height / coef)
	}

	func fit(toRect rect: CGRect) -> CGRect {
		if width / height < rect.width / rect.height {
			let coef = rect.height / height
			return CGRect(x: (rect.width - width * coef) / 2, y: 0, width: width * coef, height: rect.height)
		} else {
			let coef = rect.width / width
			return CGRect(x: 0, y: (rect.height - height * coef) / 2, width: rect.width, height: height * coef)
		}
	}

}
