//
//  ArrowView.swift
//  Xelby
//
//  Created by Yuriy Chudin on 12/07/2018.
//  Copyright © 2018 chood. All rights reserved.
//

import UIKit

@IBDesignable
public class ArrowView: UIView {
	
	@IBInspectable public var isHorizontal: Bool = true {
		didSet {
			update()
		}
	}
	
	@IBInspectable public var isFlipped: Bool = false {
		didSet {
			update()
		}
	}
	
	@IBInspectable public var color: UIColor = .black {
		didSet {
			shapeLayer.strokeColor = color.cgColor
		}
	}
	
	@IBInspectable public var lineWidth: CGFloat = 1 {
		didSet {
			update()
		}
	}
	
	private var shapeLayer: CAShapeLayer {
		get { return layer as! CAShapeLayer }
	}
	
	override public class var layerClass: AnyClass {
		get {
			return CAShapeLayer.self
		}
	}
	
	override public func layoutSubviews() {
		super.layoutSubviews()
		
		update()
	}
	
	private func update() {
		let path = UIBezierPath()
		path.move(to: CGPoint.zero)
		path.addLine(to: isHorizontal ? CGPoint(bounds.width, bounds.height / 2) : CGPoint(bounds.width / 2, bounds.height))
		path.addLine(to: isHorizontal ? CGPoint(0, bounds.height) : CGPoint(bounds.width, 0))
		path.lineWidth = lineWidth
		path.stroke()
		
		if isFlipped {
			path.apply(CGAffineTransform(scaleX: isHorizontal ? -1 : 1, y: isHorizontal ? 1 : -1))
			path.apply(CGAffineTransform(translationX: isHorizontal ? bounds.width : 0, y: isHorizontal ? 0 : bounds.height))
		}
		
		shapeLayer.path = path.cgPath
		shapeLayer.fillColor = nil
		shapeLayer.strokeColor = color.cgColor
	}

}
