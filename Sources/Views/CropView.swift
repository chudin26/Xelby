//
//  CropView.swift
//  Xelby
//
//  Created by Yuriy Chudin on 23/07/2018.
//  Copyright © 2018 chood. All rights reserved.
//

import UIKit

@IBDesignable
open class CropView: BorderView {

	// The length of corner's tick
	@IBInspectable var cornerRadius: CGFloat = 10 {
		didSet {
			recalculateShape()
		}
	}
	
	@IBInspectable var cornerWidth: CGFloat = 2 {
		didSet {
			recalculateShape()
		}
	}
	
	private var cornersLayer: CAShapeLayer!
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}
	
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setup()
	}
	
	override open func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
		
		setup()
		recalculateShape()
	}
	
	private func setup() {
		cornersLayer = CAShapeLayer()
		layer.addSublayer(cornersLayer)
	}

	override open func layoutSubviews() {
		super.layoutSubviews()
		
		recalculateShape()
	}
	
	private func recalculateShape() {
		let path = UIBezierPath()
		for i in 0 ..< 4 {
			var transform = CGAffineTransform(rotationAngle: CGFloat.pi * CGFloat(i) / 2.0)
			switch i {
			case 1: transform.tx = bounds.width
			case 2: transform.tx = bounds.width; transform.ty = bounds.height
			case 3: transform.ty = bounds.height
			default: break
			}
			
			let cornerPath = makeCorner()
			cornerPath.apply(transform)
			path.append(cornerPath)
		}
		
		cornersLayer.path = path.cgPath
		cornersLayer.strokeColor = layer.borderColor
		cornersLayer.fillColor = nil
		cornersLayer.lineWidth = cornerWidth
	}
	
	private func makeCorner() -> UIBezierPath {
		let cornerPath = UIBezierPath()
		cornerPath.move(to: CGPoint(cornerWidth / 2, cornerRadius))
		cornerPath.addLine(to: CGPoint(cornerWidth / 2, cornerWidth / 2))
		cornerPath.addLine(to: CGPoint(cornerRadius, cornerWidth / 2))
		return cornerPath
	}
	
}
