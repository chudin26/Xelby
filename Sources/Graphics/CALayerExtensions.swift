//
//  CALayer+Animations.swift
//  Xelby
//
//  Created by Yuriy Chudin on 16/06/2018.
//  Copyright © 2018 chood. All rights reserved.
//

import UIKit

public extension CALayer {

	class func animate(duration: CFTimeInterval, animations: () -> ()) {
		CATransaction.begin()
		CATransaction.setAnimationDuration(duration)

		animations()
		
		CATransaction.commit()
	}
	
}

extension CALayer: CAAnimationDelegate {
	
	public func animate(property: String, from: Any? = nil, to: Any, duration: CFTimeInterval = 0, delay: CFTimeInterval = 0) {
		let currentValue = (presentation() ?? self).value(forKey: property)
		
		let animation = CABasicAnimation(keyPath: property)
		animation.fromValue = from ?? currentValue
		animation.toValue = to
		animation.duration = duration
		animation.beginTime = delay
		animation.delegate = self
		add(animation, forKey: property)
	}
	
	public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
		guard let keyPath = anim.value(forKey: "keyPath") as? String,
			let toValue = anim.value(forKey: "toValue") else { return }
		
		self.setValue(toValue, forKey: keyPath)
	}
	
}
