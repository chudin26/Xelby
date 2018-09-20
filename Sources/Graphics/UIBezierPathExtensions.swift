//
//  UIBezierPathExtensions.swift
//  Xelby
//
//  Created by Yuriy Chudin on 20/09/2018.
//  Copyright © 2018 chood. All rights reserved.
//

import UIKit

extension UIBezierPath {

	// Points measured in range from [0..1] where 1 is width or height depending on x or y
	public convenience init(closedRoundedPathWithPoints points: [Point], radius: CGFloat, size: CGSize) {
		self.init()

		let actualPoints = points.map { CGPoint($0.0 * size.width, $0.1 * size.height) }
		for (i, point) in actualPoints.enumerated() {
			let prevPoint = actualPoints[(i + points.count - 1) % points.count]
			let nextPoint = actualPoints[(i + 1) % points.count]
			let prevVector = CGVector(point: prevPoint - point).normalized()
			let nextVector = CGVector(point: nextPoint - point).normalized()
			
			if i == 0 {
				move(to: point + prevVector * radius)
			}

			addCurve(to: point + prevVector * radius, controlPoint1: point + prevVector * (radius + 1), controlPoint2: point)
			addCurve(to: point + nextVector * radius, controlPoint1: point, controlPoint2: point + nextVector * (radius + 1))
		}
	}

}
