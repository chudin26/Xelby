//
//  CGExtensions.swift
//  Xelby
//
//  Created by Yuriy Chudin on 24/06/2018.
//  Copyright © 2018 chood. All rights reserved.
//

import Foundation

public typealias Point = (CGFloat, CGFloat)

public extension CGVector {
	
	init(_ dx: CGFloat, _ dy: CGFloat) {
		self.init(dx: dx, dy: dy)
	}
	
	init(angle: CGFloat, length: CGFloat = 1) {
		self.init(dx: cos(angle) * length, dy: sin(angle) * length)
	}
	
	init(point: CGPoint) {
		self.init(dx: point.x, dy: point.y)
	}
	
	init(size: CGSize) {
		self.init(dx: size.width, dy: size.height)
	}
		
}

public extension CGRect {
	
	init(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) {
		self.init(x: x, y: y, width: width, height: height)
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
