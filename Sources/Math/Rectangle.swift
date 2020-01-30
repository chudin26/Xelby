//
//  Rectangle.swift
//  Xelby
//
//  Created by Yuriy Chudin on 22.01.2020.
//  Copyright © 2020 chood. All rights reserved.
//

import CoreGraphics

public extension CGRect {
	
	enum Side: CaseIterable {
		case top
		case left
		case bottom
		case right
	}

	var center: CGPoint {
		return CGPoint(midX, midY)
	}
	
	var left: CGFloat { return minX }
	var bottom: CGFloat { return maxY }
	var right: CGFloat { return maxX }
	var top: CGFloat { return minY }
		
	var topLeft: CGPoint { return .init(left, top) }
	var topRight: CGPoint { return .init(right, top) }
	var bottomLeft: CGPoint { return .init(left, bottom) }
	var bottomRight: CGPoint { return .init(right, bottom) }

	func value(of side: Side) -> CGFloat {
		switch side {
		case .top: return top
		case .left: return left
		case .bottom: return bottom
		case .right: return right
		}
	}

	func line(by side: Side) -> Line {
		if side == .left || side == .right {
			return Line(.init(value(of: side), bottom), .init(value(of: side), top))
		} else {
			return Line(.init(left, value(of: side)), .init(right, value(of: side)))
		}
	}

	func intersections(with line: Line) -> [(Side, CGPoint)] {
		let sides = Side.allCases.map { self.line(by: $0) }
		return sides.enumerated().map { ($0, $1.intersection(with: line)) }
			.compactMap { $0.1 != nil ? (Side.allCases[$0.0], $0.1!) : nil }
	}

}
