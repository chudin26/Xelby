//
//  UIColorExtensions.swift
//  Xelby
//
//  Created by Yuriy Chudin on 24/06/2018.
//  Copyright © 2018 chood. All rights reserved.
//

import UIKit

public extension UIColor {

	convenience init(red: Int, green: Int, blue: Int, alpha: Int = 255) {
		assert(red >= 0 && red <= 255, "Invalid red component")
		assert(green >= 0 && green <= 255, "Invalid green component")
		assert(blue >= 0 && blue <= 255, "Invalid blue component")
		assert(alpha >= 0 && alpha <= 255, "Invalid alpha component")
		
		self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(alpha) / 255.0)
	}

	convenience init(hex: UInt32) {
		var hex = hex
		var alpha: UInt32 = 255
		if hex >> 24 != 0 {
			alpha = hex & 0xFF
			hex = hex >> 8
		}
		
		let red: UInt32 = (hex >> 16) & 0xFF
		let green: UInt32 = (hex >> 8) & 0xFF
		let blue: UInt32 = hex & 0xFF
		
		self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: CGFloat(alpha) / 255)
	}

	func blend(with color: UIColor, coefficient: CGFloat, preserveAlpha: Bool = false) -> UIColor {
		var components = arrayOfComponents()
		let otherComponents = color.arrayOfComponents()
		
		for i in 0 ..< 4 {
			let newValue = components[i] + (otherComponents[i] - components[i]) * coefficient
			components[i] = max(min(newValue, 1.0), 0.0)
		}
		
		if preserveAlpha {
			components[3] = a
		}
		
		return UIColor(red: components[0], green: components[1], blue: components[2], alpha: components[3])
	}
	
	func components() -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
		var red: CGFloat = 0
		var green: CGFloat = 0
		var blue: CGFloat = 0
		var alpha: CGFloat = 0
		getRed(&red, green: &green, blue: &blue, alpha: &alpha)
		
		return (red: red, green: green, blue: blue, alpha: alpha)
	}
	
	func arrayOfComponents() -> [CGFloat] {
		let c = components()
		return [c.red, c.green, c.blue, c.alpha]
	}
	
	var r: CGFloat { return components().red }
	var g: CGFloat { return components().green }
	var b: CGFloat { return components().blue }
	var a: CGFloat { return components().alpha }
	
	var hex: UInt32 {
		return UInt32(a * 255) << 24 | UInt32(r * 255) << 16 | UInt32(g * 255) << 8 | UInt32(b * 255)
	}

}
