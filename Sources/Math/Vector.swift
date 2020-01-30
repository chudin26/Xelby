//
//  Vector.swift
//  Xelby
//
//  Created by Yuriy Chudin on 22.01.2020.
//  Copyright © 2020 chood. All rights reserved.
//

import CoreGraphics

public extension CGVector {
	
	init(_ line: Line) {
		self.init(dx: line.b.x - line.a.x, dy: line.b.y - line.a.y)
	}


	var length: CGFloat {
		return sqrt(dx * dx + dy * dy)
	}

	var length2: CGFloat {
		return dx * dx + dy * dy
	}
	
	func normalized() -> CGVector {
		return self / length
	}
	
	static func dot(_ v1: CGVector, _ v2: CGVector) -> CGFloat {
		return v1.dx * v2.dx + v1.dy * v2.dy
	}
	
	static func * (v1: CGVector, v2: CGVector) -> CGFloat {
		return CGVector.dot(v1, v2)
	}

	static func * (vector: CGVector, value: CGFloat) -> CGVector {
		return CGVector(dx: vector.dx * value, dy: vector.dy * value)
	}

	static func / (vector: CGVector, value: CGFloat) -> CGVector {
		return CGVector(dx: vector.dx / value, dy: vector.dy / value)
	}
	
	static func + (v1: CGVector, v2: CGVector) -> CGVector {
		return CGVector(dx: v1.dx + v2.dx, dy: v1.dy + v2.dy)
	}
	
	static func - (v1: CGVector, v2: CGVector) -> CGVector {
		return CGVector(dx: v1.dx - v2.dx, dy: v1.dy - v2.dy)
	}

}
