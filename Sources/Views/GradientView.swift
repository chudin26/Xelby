//
//  GradientView.swift
//  Xelby
//
//  Created by Yuriy Chudin on 04/09/2019.
//  Copyright © 2019 chood. All rights reserved.
//

import UIKit

@IBDesignable
open class GradientView: UIView {
	
	@IBInspectable public var startColor: UIColor! = UIColor(white: 0.0, alpha: 1.0) { didSet { setup() }}
	@IBInspectable public var endColor: UIColor! = UIColor(white: 1.0, alpha: 1.0) { didSet { setup() }}
	
	@IBInspectable public var startPoint: CGPoint = CGPoint(x: 0, y: 0) { didSet { setup() }}
	@IBInspectable public var endPoint: CGPoint = CGPoint(x: 1, y: 1) { didSet { setup() }}
	
	override public class var layerClass: AnyClass {
		return CAGradientLayer.self
	}
	
	private var gradientLayer: CAGradientLayer {
		return self.layer as! CAGradientLayer
	}
	
	
	public override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}
	
	required public init?(coder: NSCoder) {
		super.init(coder: coder)
		setup()
	}

	override public func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
		setup()
	}
	
	override public func awakeFromNib() {
		super.awakeFromNib()
		setup()
	}
		
	private func setup() {
		gradientLayer.startPoint = startPoint
		gradientLayer.endPoint = endPoint
		gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
	}
	
}
