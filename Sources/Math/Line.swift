//
//  Line.swift
//  Xelby
//
//  Created by Yuriy Chudin on 22.01.2020.
//  Copyright © 2020 chood. All rights reserved.
//

import Foundation

public struct Line {
	
	public let startPoint: CGPoint
	public let endPoint: CGPoint
	
	public var a: CGPoint { return startPoint }
	public var b: CGPoint { return endPoint }
	
	public init(_ p1: CGPoint, _ p2: CGPoint) {
		startPoint = p1
		endPoint = p2
	}
	
	public init(x1: CGFloat, y1: CGFloat, x2: CGFloat, y2: CGFloat) {
		startPoint = .init(x1, y1)
		endPoint = .init(x2, y2)
	}
	
	public func intersection(with other: Line) -> CGPoint? {
		return Line.intersection(of: self, and: other)
	}
	
	public static func intersection(of line1: Line, and line2: Line) -> CGPoint? {
		// calculate the differences between the start and end X/Y positions for each of our points
		let delta1x = line1.endPoint.x - line1.startPoint.x
		let delta1y = line1.endPoint.y - line1.startPoint.y
		let delta2x = line2.endPoint.x - line2.startPoint.x
		let delta2y = line2.endPoint.y - line2.startPoint.y

		// create a 2D matrix from our vectors and calculate the determinant
		let determinant = delta1x * delta2y - delta2x * delta1y

		if abs(determinant) < 0.0001 {
			// if the determinant is effectively zero then the lines are parallel/colinear
			return nil
		}

		// if the coefficients both lie between 0 and 1 then we have an intersection
		let ab = ((line1.startPoint.y - line2.startPoint.y) * delta2x - (line1.startPoint.x - line2.startPoint.x) * delta2y) / determinant

		if ab > 0 && ab < 1 {
			let cd = ((line1.startPoint.y - line2.startPoint.y) * delta1x - (line1.startPoint.x - line2.startPoint.x) * delta1y) / determinant

			if cd > 0 && cd < 1 {
				// lines cross – figure out exactly where and return it
				let intersectX = line1.startPoint.x + ab * delta1x
				let intersectY = line1.startPoint.y + ab * delta1y
				return .init(intersectX, intersectY)
			}
		}

		// lines don't cross
		return nil
	}
	
}
