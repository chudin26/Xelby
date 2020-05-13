//
//  Point.swift
//  Xelby
//
//  Created by Yuriy Chudin on 23.01.2020.
//  Copyright © 2020 chood. All rights reserved.
//

import CoreGraphics

public extension CGPoint {

	init(point: Point) {
		self.init(x: point.0, y: point.1)
	}
	
	init(size: CGSize) {
		self.init(x: size.width, y: size.height)
	}
	
	init(_ x: CGFloat, _ y: CGFloat) {
		self.init(x: x, y: y)
	}
	
	init(vector: CGVector) {
		self.init(x: vector.dx, y: vector.dy)
	}
	
	static func + (point: CGPoint, vector: CGVector) -> CGPoint {
		return CGPoint(x: point.x + vector.dx, y: point.y + vector.dy)
	}
	
	static func - (point: CGPoint, vector: CGVector) -> CGPoint {
		return CGPoint(x: point.x - vector.dx, y: point.y - vector.dy)
	}

	static func + (p1: CGPoint, p2: CGPoint) -> CGPoint {
		return CGPoint(x: p1.x + p2.x, y: p1.y + p2.y)
	}

	static func - (p1: CGPoint, p2: CGPoint) -> CGPoint {
		return CGPoint(x: p1.x - p2.x, y: p1.y - p2.y)
	}

	static func += (point: inout CGPoint, vector: CGVector) {
		point.x += vector.dx
		point.y += vector.dy
	}
	
	static func -= (point: inout CGPoint, vector: CGVector) {
		point.x -= vector.dx
		point.y -= vector.dy
	}

	static func / (p: CGPoint, s: CGSize) -> CGPoint {
		return CGPoint(p.x / s.width, p.y / s.height)
	}
	
}
