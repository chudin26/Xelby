//
//  CGExtensions.swift
//  Xelby
//
//  Created by Yuriy Chudin on 24/06/2018.
//  Copyright © 2018 chood. All rights reserved.
//

import Foundation

extension CGVector {
	
	public init(_ dx: CGFloat, _ dy: CGFloat) {
		self.init(dx: dx, dy: dy)
	}
	
	public init(angle: CGFloat, length: CGFloat = 1) {
		self.init(dx: cos(angle) * length, dy: sin(angle) * length)
	}
	
	public var length: CGFloat {
		return sqrt(dx * dx + dy * dy)
	}
	
	public func normalized() -> CGVector? {
		return length == 0 ? nil : self / length
	}
	
	public static func * (vector: CGVector, value: CGFloat) -> CGVector {
		return CGVector(dx: vector.dx * value, dy: vector.dy * value)
	}
	
	public static func / (vector: CGVector, value: CGFloat) -> CGVector {
		return CGVector(dx: vector.dx / value, dy: vector.dy / value)
	}
	
	public static func + (v1: CGVector, v2: CGVector) -> CGVector {
		return CGVector(dx: v1.dx + v2.dx, dy: v1.dy + v2.dy)
	}
	
	public static func - (v1: CGVector, v2: CGVector) -> CGVector {
		return CGVector(dx: v1.dx - v2.dx, dy: v1.dy - v2.dy)
	}
	
}

public extension CGPoint {
	
	init(_ x: CGFloat, _ y: CGFloat) {
		self.init(x: x, y: y)
	}
	
	static func + (point: CGPoint, vector: CGVector) -> CGPoint {
		return CGPoint(x: point.x + vector.dx, y: point.y + vector.dy)
	}
	
	static func - (point: CGPoint, vector: CGVector) -> CGPoint {
		return CGPoint(x: point.x - vector.dx, y: point.y - vector.dy)
	}
	
	static func += (point: inout CGPoint, vector: CGVector) {
		point.x += vector.dx
		point.y += vector.dy
	}
	
	static func -= (point: inout CGPoint, vector: CGVector) {
		point.x -= vector.dx
		point.y -= vector.dy
	}
	
}

extension CGAffineTransform {
	
	public init(scale: CGFloat) {
		self.init(scaleX: scale, y: scale)
	}
	
	public static func * (t1: CGAffineTransform, t2: CGAffineTransform) -> CGAffineTransform {
		return t1.concatenating(t2)
	}
	
}
