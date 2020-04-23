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

public extension CAGradientLayer {
	
	convenience init(startPoint: CGPoint, endPoint: CGPoint, colors: [UIColor], locations: [Float]? = nil) {
		self.init()
		
		self.startPoint = startPoint
		self.endPoint = endPoint
		self.colors = colors.map { $0.cgColor }
		
		if let locations = locations {
			self.locations = locations.map { NSNumber(value: $0) }
		}
	}
	
}
