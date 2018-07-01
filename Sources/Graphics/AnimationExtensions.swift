//
//  AnimationExtensions.swift
//  Xelby
//
//  Created by Yuriy Chudin on 16/06/2018.
//  Copyright © 2018 chood. All rights reserved.
//

import UIKit

public extension CALayer {

	public class func animate(duration: CFTimeInterval, curve: CAMediaTimingFunction? = nil, animations: () -> ()) {
		CATransaction.begin()
		CATransaction.setAnimationDuration(duration)
		CATransaction.setAnimationTimingFunction(curve)

		animations()
		
		CATransaction.commit()
	}
	
}

public extension UIView {
	
	public class func animate(withDuration duration: TimeInterval, delay: TimeInterval = 0, curve: CAMediaTimingFunction, animations: @escaping () -> (), completion: ((Bool) -> Void)? = nil) {
		CATransaction.begin()
		CATransaction.setAnimationTimingFunction(curve)

		UIView.animate(withDuration: duration, delay: delay, options: [], animations: animations, completion: completion)
		
		CATransaction.commit()
	}
	
}

public final class AnimationCurve {
	public static let springEaseOut = CAMediaTimingFunction(controlPoints: 0.3, 1.45, 0.4, 0.9)
	public static let springEaseIn = CAMediaTimingFunction(controlPoints: 0.6, 0.1, 0.7, -0.45)
}

extension CALayer: CAAnimationDelegate {
	
	public func animate(property: String, from: Any? = nil, to: Any, duration: CFTimeInterval = 0, delay: CFTimeInterval = 0, curve: CAMediaTimingFunction? = nil) {
		let currentValue = (presentation() ?? self).value(forKey: property)
		if let from = from {
			setValue(from, forKey: property)
		}
		
		let animation = CABasicAnimation(keyPath: property)
		animation.timingFunction = curve
		animation.fromValue = from ?? currentValue
		animation.toValue = to
		animation.duration = duration
		animation.beginTime = CACurrentMediaTime() + delay
		animation.delegate = self
//		animation.fillMode = kCAFillModeForwards
//		animation.isRemovedOnCompletion = false
		
		add(animation, forKey: property)
	}
	
	public func animationDidStart(_ anim: CAAnimation) {
		guard let keyPath = anim.value(forKey: "keyPath") as? String,
			let toValue = anim.value(forKey: "toValue") else { return }
		
		self.setValue(toValue, forKey: keyPath)
	}
	
	public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
//		guard let keyPath = anim.value(forKey: "keyPath") as? String,
//			let toValue = anim.value(forKey: "toValue") else { return }
//
//		self.setValue(toValue, forKey: keyPath)
	}
	
}
