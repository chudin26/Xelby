//
//  UIImageExtensions.swift
//  Xelby
//
//  Created by Yuriy Chudin on 24/06/2018.
//  Copyright © 2018 chood. All rights reserved.
//

import UIKit

public extension UIImage {
	
	static var ciContext: CIContext!
	static func useCoreImage() {
		ciContext = CIContext(options: nil)
	}
	
	func resized(to lowest: CGFloat) -> UIImage {
		return resized(to: CGSize(lowest, lowest))
	}

	func resized(to targetSize: CGSize) -> UIImage {
		let widthRatio  = targetSize.width  / size.width
		let heightRatio = targetSize.height / size.height
		
		let ratio = widthRatio > heightRatio ? heightRatio : widthRatio
		let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
		
		let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
		
		UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
		draw(in: rect)
		let newImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		return newImage!
	}
	
	func gaussianBlurred(radius: CGFloat) -> UIImage {
		let currentFilter = CIFilter(name: "CIGaussianBlur")
		let beginImage = CIImage(image: self)
		currentFilter!.setValue(beginImage, forKey: kCIInputImageKey)
		currentFilter!.setValue(radius, forKey: kCIInputRadiusKey)
		
		let cropFilter = CIFilter(name: "CICrop")
		cropFilter!.setValue(currentFilter!.outputImage, forKey: kCIInputImageKey)
		cropFilter!.setValue(CIVector(cgRect: beginImage!.extent), forKey: "inputRectangle")
		
		let output = cropFilter!.outputImage
		
		let cgimg = UIImage.ciContext.createCGImage(output!, from: output!.extent)
		let processedImage = UIImage(cgImage: cgimg!)
		return processedImage
	}
	
	func fixedOrientation() -> UIImage {
		if (self.imageOrientation == .up) {
			return self
		}
		
		UIGraphicsBeginImageContextWithOptions(size, false, scale)
		let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
		draw(in: rect)
		
		let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		
		return normalizedImage
	}
	
	func cropped(byRect rect: CGRect, extendSizeIfNeeded: Bool = false, backgroundColor: UIColor? = nil) -> UIImage {
		let imageRect = CGRect(origin: .zero, size: size)
		let rect = extendSizeIfNeeded ? rect : rect.intersection(imageRect)
		UIGraphicsBeginImageContextWithOptions(rect.size, true, 1.0)
		
		let context = UIGraphicsGetCurrentContext()!
		context.setFillColor(UIColor.white.cgColor)
		context.fill(CGRect(origin: .zero, size: rect.size))
		draw(at: CGPoint(-rect.origin.x, -rect.origin.y))
		
		let newImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return newImage!
	}
	
}

public extension UIImageView {
	
	func loadImageAsync(fromFileUrl fileUrl: URL) {
		let	loadingView = UIActivityIndicatorView(style: .gray)
		loadingView.frame = bounds
		loadingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		loadingView.startAnimating()
		self.addSubview(loadingView)
		
		DispatchQueue.global().async {
			let imageData = UIImage(contentsOfFile: fileUrl.path)
			
			DispatchQueue.main.async {
				self.image = imageData
				loadingView.removeFromSuperview()
			}
		}
	}
	
}
