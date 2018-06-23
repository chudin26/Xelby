//
//  UIImageExtensions.swift
//  Xelby
//
//  Created by Yuriy Chudin on 24/06/2018.
//  Copyright © 2018 chood. All rights reserved.
//

import UIKit

public extension UIImage {
	
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
	
}
