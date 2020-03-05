//
//  CAExtensions.swift
//  Xelby
//
//  Created by Yuriy Chudin on 20.02.2020.
//  Copyright © 2020 chood. All rights reserved.
//

import CoreGraphics

public extension CAShapeLayer {

	convenience init(path: UIBezierPath, fillRule: CAShapeLayerFillRule = .nonZero) {
		self.init()
		
		self.path = path.cgPath
		self.fillRule = fillRule
	}

}
