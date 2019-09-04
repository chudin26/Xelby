//
//  UIViewExtensions.swift
//  Xelby
//
//  Created by Yuriy Chudin on 04/09/2019.
//  Copyright © 2019 chood. All rights reserved.
//

import UIKit

public extension UIView {
	
	func nearestViewController() -> UIViewController? {
		var obj: AnyObject! = self
		while (!(obj is UIViewController)) && obj != nil {
			obj = obj.next
		}
		
		return obj as? UIViewController
	}
	
	func findViewsByType <T> () -> [T] {
		var array: [T] = []
		
		for v in subviews {
			if v is T {
				array.append(v as! T)
			} else {
				array.append(contentsOf: v.findViewsByType())
			}
		}
		
		return array
	}
	
	func findInParents <T: UIView> () -> T! {
		var v: UIView! = self
		while !(v is T) && v != nil {
			v = v.superview
		}
		
		return v as? T
	}
	
	func removeAllSubviews() {
		let views = subviews
		for v in views {
			v.removeFromSuperview()
		}
	}
	
	func allSubviews() -> [UIView] {
		var array: [UIView] = []
		
		for v in subviews {
			array += [v]
			array += v.allSubviews()
		}
		
		return array
	}
	
	@discardableResult
	func embed(in superview: UIView) -> UIView {
		self.frame = superview.bounds
		self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		superview.addSubview(self)
		
		return self
	}
	
	func takeSnapshot() -> UIImage? {
		UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
		
		layer.render(in: UIGraphicsGetCurrentContext()!)
		
		let image = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		return image
	}
	
}
