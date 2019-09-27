//
//  AnimationCurves.swift
//  Xelby
//
//  Created by Yuriy Chudin on 27/09/2019.
//  Copyright © 2019 chood. All rights reserved.
//

import QuartzCore

public class AnimationCurves {
	
	public static let superSpringEaseOut = CAMediaTimingFunction(controlPoints: 0.3, 1.85, 0.5, 0.9)
	public static let superSpringEaseIn = CAMediaTimingFunction(controlPoints: 0.5, 0.1, 0.7, -0.85)

	public static let springEaseOut = CAMediaTimingFunction(controlPoints: 0.3, 1.45, 0.4, 0.9)
	public static let springEaseIn = CAMediaTimingFunction(controlPoints: 0.6, 0.1, 0.7, -0.45)

	public static let easeOut = CAMediaTimingFunction(controlPoints: 0.3, 1.1, 0.4, 0.9)
	public static let superEaseOut = CAMediaTimingFunction(controlPoints: 0.0, 1.0, 0.0, 1.0)
	
}

@available (*, deprecated)
typealias AnimationCurve = AnimationCurves
