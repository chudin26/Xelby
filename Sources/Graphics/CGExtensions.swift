//
//  CGExtensions.swift
//  Xelby
//
//  Created by Yuriy Chudin on 24/06/2018.
//  Copyright © 2018 chood. All rights reserved.
//

import Foundation

public typealias Point = (CGFloat, CGFloat)

public extension CGRect {
	
	init(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) {
		self.init(x: x, y: y, width: width, height: height)
	}
	
}

public extension CGSize {
	
	static func max(_ size1: CGSize, _ size2: CGSize) -> CGSize {
		return .init(width: Swift.max(size1.width, size2.width), height: Swift.max(size1.height, size2.height))
	}
	
}

public extension CGAffineTransform {
	
	init(scale: CGFloat) {
		self.init(scaleX: scale, y: scale)
	}
	
	static func * (t1: CGAffineTransform, t2: CGAffineTransform) -> CGAffineTransform {
		return t1.concatenating(t2)
	}
	
}
