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
	
	private lazy var imageLayer: CALayer = {
		clipsToBounds = true
		
		let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
		let blurEffectView = UIVisualEffectView(effect: blurEffect)
		blurEffectView.frame = bounds
		blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		addSubview(blurEffectView)
		
		let l = CALayer()
		l.contentsGravity = kCAGravityResizeAspect
		layer.contentsGravity = kCAGravityResizeAspectFill
		layer.addSublayer(l)
		
		return l
	}()
	
	public override func layoutSubviews() {
		super.layoutSubviews()

		CALayer.performWithoutAnimation {
			imageLayer.frame = bounds
		}
	}
	
	private func setupImages() {
		guard let image = image else { return }
		
		imageLayer.contents = image.cgImage
		layer.contents = image.cgImage
	}
	
}
