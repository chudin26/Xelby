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
	
	private let queue = DispatchQueue(label: "com.xelby.AnyAspectImageView", qos: DispatchQoS.background)
	
	private var imageLayer: CALayer!
	private var blurEffectView: UIVisualEffectView!
	
	@IBInspectable public var image: UIImage? {
		didSet {
			setupImages()
		}
	}
	
	private var imageFileUrl: URL!
	public func setImage(fromFileUrl fileUrl: URL) {
		if fileUrl == imageFileUrl {
			return
		}
		imageFileUrl = fileUrl
		
		let	loadingView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
		loadingView.frame = bounds
		loadingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		loadingView.startAnimating()
		self.addSubview(loadingView)
		
		queue.async {			
			let imageData = UIImage(contentsOfFile: fileUrl.path)

			DispatchQueue.main.async {
				self.image = imageData
				loadingView.removeFromSuperview()
			}
		}
	}
	
	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		initialize()
	}
	
	public override init(frame: CGRect) {
		super.init(frame: frame)
		initialize()
	}
	
	private func initialize() {
		clipsToBounds = true
		
		let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
		blurEffectView = UIVisualEffectView(effect: blurEffect)
		blurEffectView.frame = bounds
		blurEffectView.translatesAutoresizingMaskIntoConstraints = false
		self.addSubview(blurEffectView)
		
		imageLayer = CALayer()
		imageLayer.contentsGravity = kCAGravityResizeAspect
		imageLayer.frame = layer.bounds
		layer.contentsGravity = kCAGravityResizeAspectFill
		layer.addSublayer(imageLayer)
	}
	
	public override func layoutSubviews() {
		super.layoutSubviews()

		imageLayer.frame = bounds
		blurEffectView.frame = bounds
	}
	
	private func setupImages() {
		guard let image = image else { return }
		
		self.imageLayer.contents = image.cgImage
		self.layer.contents = image.cgImage
	}
	
}
