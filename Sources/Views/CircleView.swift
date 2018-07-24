//
//  CircleView.swift
//  Xelby
//
//  Created by Yuriy Chudin on 17.07.18.
//  Copyright © 2018 Yuriy Chudin. All rights reserved.
//

import UIKit

@IBDesignable
class CircleView: UIView {
	
	@IBInspectable var borderWidth: CGFloat = 1 {
		didSet {
			update()
		}
	}
	
	@IBInspectable var borderColor: UIColor = .black {
		didSet {
			update()
		}
	}
	
	@IBInspectable var fillColor: UIColor = .clear {
		didSet {
			update()
		}
	}
	
	override public class var layerClass: AnyClass {
		get {
			return CAShapeLayer.self
		}
	}
	
	private var shapeLayer: CAShapeLayer {
		return layer as! CAShapeLayer
	}
	
	override func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
		update()
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		update()
	}
	
	private func update() {
		let path = UIBezierPath(ovalIn: bounds)
		shapeLayer.path = path.cgPath
		shapeLayer.strokeColor = borderColor.cgColor
		shapeLayer.fillColor = fillColor.cgColor
		shapeLayer.lineWidth = borderWidth
	}
	
}
