//
//  CircleView.swift
//  Xelby
//
//  Created by Yuriy Chudin on 17.07.18.
//  Copyright © 2018 Yuriy Chudin. All rights reserved.
//

import UIKit

@IBDesignable
public class CircleView: UIView {
	
	@IBInspectable public var strokeColor: UIColor? = .white { didSet { setNeedsDisplay() } }
	@IBInspectable public var fillColor: UIColor? { didSet { setNeedsDisplay() } }
	
	@IBInspectable public var lineWidth: CGFloat = 1 { didSet { setNeedsDisplay() } }
	@IBInspectable public var lineDash: CGFloat = 0 { didSet { setNeedsDisplay() } }
	
	override public func draw(_ rect: CGRect) {
		let ovalRect = rect.insetBy(dx: lineWidth / 2, dy: lineWidth / 2)
		let path = UIBezierPath(ovalIn: ovalRect)
		
		if lineDash > 0 {
			path.setLineDash([lineDash, lineDash], count: 2, phase: 0)
		}
		
		path.lineWidth = lineWidth
		
		if let strokeColor = strokeColor {
			strokeColor.setStroke()
			path.stroke()
		}
		
		if let fillColor = fillColor {
			fillColor.setFill()
			path.fill()
		}
	}
	
}
