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
	
	@IBInspectable public var startColor: UIColor? { didSet { setup() }}
	@IBInspectable public var endColor: UIColor? { didSet { setup() }}
		
	@IBInspectable public var startPoint: CGPoint = CGPoint(x: 0, y: 0) { didSet { setup() }}
	@IBInspectable public var endPoint: CGPoint = CGPoint(x: 1, y: 1) { didSet { setup() }}
	
	// Colors property is same as gradientLayer.colors
	// Example of using: "45B37A, 98AC43, 28AF4F"
	@IBInspectable public var colors: String? { didSet { setup() }}
	
	// Locations property is same as gradientLayer.locations
	// Example of using: "0.2, 0.34, 0.9"
	@IBInspectable public var locations: String? { didSet { setup() }}
	

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
		
		if let colorsString = colors, let locationsString = locations {
			gradientLayer.colors = try? ColorParser().parse(from: colorsString).map { $0.cgColor }
			gradientLayer.locations = try? NumberParser().parse(from: locationsString).map { NSNumber(value: $0) }
		} else if let startColor = startColor, let endColor = endColor {
			gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
		}
	}
	
}
