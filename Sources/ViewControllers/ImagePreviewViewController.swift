//
//  ImagePreviewViewController.swift
//  Xelby
//
//  Created by Yuriy Chudin on 11/07/2018.
//  Copyright © 2018 chood. All rights reserved.
//

import UIKit

public class ImagePreviewViewController: UIViewController {
	
	public var image: UIImage!
	public var imageViewStartFrame: CGRect
	
	public var onClose: (() -> ())!
	
	private var scrollView: UIScrollView!
	private var imageView: UIImageView!
	
	public init(image: UIImage, imageViewRect: CGRect) {
		self.imageViewStartFrame = imageViewRect
		self.image = image

		super.init(nibName: nil, bundle: nil)
		
		modalPresentationStyle = .custom
		modalTransitionStyle = .crossDissolve
		
		automaticallyAdjustsScrollViewInsets = false
	}
	
	required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override public func loadView() {
		let bounds = UIScreen.main.bounds
		
		let view = UIView(frame: bounds)
		view.backgroundColor = UIColor(white: 0, alpha: 0.9)
		
		scrollView = UIScrollView(frame: bounds)
		scrollView.backgroundColor = nil
		scrollView.showsVerticalScrollIndicator = false
		scrollView.showsHorizontalScrollIndicator = false
		scrollView.minimumZoomScale = 1
		scrollView.maximumZoomScale = 4
		scrollView.delegate = self
		scrollView.bouncesZoom = true
		view.addSubview(scrollView)
		
		let imageViewRect = image.size.fit(toRect: bounds)
		imageView = UIImageView(frame: CGRect(origin: .zero, size: imageViewRect.size))
		imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		imageView.isUserInteractionEnabled = true
		imageView.image = image
		imageView.contentMode = .scaleAspectFit
		scrollView.contentSize = imageViewRect.size
		scrollView.contentInset = UIEdgeInsets(top: imageViewRect.origin.y, left: imageViewRect.origin.x, bottom: 0, right: 0)
		scrollView.addSubview(imageView)

		let recognizer = UITapGestureRecognizer(target: self, action: #selector(close))
		imageView.addGestureRecognizer(recognizer)
		scrollView.addGestureRecognizer(recognizer)
		
		let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(onPan(recognizer:)))
		imageView.addGestureRecognizer(panRecognizer)

		self.view = view
	}
	
	public override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		let originalFrame = imageView.frame
		imageView.frame = view.convert(imageViewStartFrame, to: scrollView)
		UIView.animate(withDuration: 0.25) {
			self.imageView.frame = originalFrame
		}
	}
	
	public override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		
		scrollView.setZoomScale(1, animated: true)
		
		UIView.animate(withDuration: 0.25) {
			self.imageView.frame = self.view.convert(self.imageViewStartFrame, to: self.scrollView)
		}
	}
	
	@objc private func onPan(recognizer: UIPanGestureRecognizer) {
		let offset = recognizer.translation(in: view)

		if recognizer.state == .changed {
			let translationTransform = CGAffineTransform(translationX: offset.x, y: offset.y)
			imageView.transform = translationTransform
		} else if recognizer.state == .ended {
			if offset.y < -100 {
				close()
			} else {
				UIView.animate(withDuration: 0.2) {
					self.imageView.transform = .identity
				}
			}
		} else if recognizer.state == .cancelled {
			UIView.animate(withDuration: 0.2) {
				self.imageView.transform = .identity
			}
		}
	}
	
	@objc private func close() {
		onClose()
	}
	
}

extension ImagePreviewViewController: UIScrollViewDelegate {
	
	public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
		return imageView
	}
	
	public func scrollViewDidZoom(_ scrollView: UIScrollView) {
		let offsetX = max((scrollView.bounds.width - scrollView.contentSize.width) * 0.5, 0)
		let offsetY = max((scrollView.bounds.height - scrollView.contentSize.height) * 0.5, 0)
		scrollView.contentInset = UIEdgeInsetsMake(offsetY, offsetX, 0, 0)
	}
	
}
