//
//  CGExtensions.swift
//  Xelby
//
//  Created by Yuriy Chudin on 24/06/2018.
//  Copyright © 2018 chood. All rights reserved.
//

import Foundation

public extension CGVector {
	
	init(_ dx: CGFloat, _ dy: CGFloat) {
		self.init(dx: dx, dy: dy)
	}
	
	init(angle: CGFloat, length: CGFloat = 1) {
		self.init(dx: cos(angle) * length, dy: sin(angle) * length)
	}
	
	var length: CGFloat {
		return sqrt(dx * dx + dy * dy)
	}
	
	func normalized() -> CGVector? {
		return length == 0 ? nil : self / length
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

public extension CGRect {
	
	var center: CGPoint {
		return CGPoint(midX, midY)
	}
	
}

public extension CGSize {
	
	init(_ width: CGFloat, _ height: CGFloat) {
		self.init(width: width, height: height)
	}
	
	static func * (size: CGSize, coef: CGFloat) -> CGSize {
		return CGSize(size.width * coef, size.height * coef)
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

public extension CGAffineTransform {
	
	init(scale: CGFloat) {
		self.init(scaleX: scale, y: scale)
	}
	
	static func * (t1: CGAffineTransform, t2: CGAffineTransform) -> CGAffineTransform {
		return t1.concatenating(t2)
	}
	
}
