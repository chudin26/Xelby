//
//  AnyAspectImageView.swift
//  Xelby
//
//  Created by Yuriy Chudin on 10/07/2018.
//  Copyright © 2018 chood. All rights reserved.
//

import UIKit

@IBDesignable
public class AnyAspectImageView: UIView {
	
	@IBInspectable public var image: UIImage? {
		didSet {
			setupImages()
		}
	}
	
	private var imageLayer = CALayer()
	
	public override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}
	
	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setup()
	}
	
	public override func layoutSubviews() {
		super.layoutSubviews()

		CALayer.performWithoutAnimation {
			imageLayer.frame = bounds
		}
	}
	
	private func setup() {
		clipsToBounds = true
		
		let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
		let blurEffectView = UIVisualEffectView(effect: blurEffect)
		blurEffectView.frame = bounds
		blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		addSubview(blurEffectView)
		
		imageLayer.contentsGravity = kCAGravityResizeAspect
		layer.contentsGravity = kCAGravityResizeAspectFill
		layer.addSublayer(imageLayer)
	}
	
	private func setupImages() {
		guard let image = image else { return }
		
		imageLayer.contents = image.cgImage
		layer.contents = image.cgImage
	}
	
}
