//
//  AnimationExtensions.swift
//  Xelby
//
//  Created by Yuriy Chudin on 16/06/2018.
//  Copyright © 2018 chood. All rights reserved.
//

import UIKit

public extension CALayer {

	class func animate(duration: CFTimeInterval, curve: CAMediaTimingFunction? = nil, animations: () -> ()) {
		CATransaction.begin()
		CATransaction.setAnimationDuration(duration)
		CATransaction.setAnimationTimingFunction(curve)

		animations()
		
		CATransaction.commit()
	}
	
	class func performWithoutAnimation(_ actions: () -> Void) {
		CATransaction.begin()
		CATransaction.setDisableActions(true)
		
		actions()
		
		CATransaction.commit()
	}
	
}

public extension UIView {
	
	class func animate(withDuration duration: TimeInterval, delay: TimeInterval = 0, curve: CAMediaTimingFunction, animations: @escaping () -> (), completion: ((Bool) -> Void)? = nil) {
		CATransaction.begin()
		CATransaction.setAnimationTimingFunction(curve)

		UIView.animate(withDuration: duration, delay: delay, options: [], animations: animations, completion: completion)
		
		CATransaction.commit()
	}
	
}

extension CAAnimation {
	
	public class AnimationHandler: NSObject, CAAnimationDelegate {
		public var onStart: ((CAAnimation) -> ())?
		public var onStop: ((CAAnimation, Bool) -> ())?
		
		public init(onStart: ((CAAnimation) -> ())? = nil, onStop: ((CAAnimation, Bool) -> ())?) {
			self.onStart = onStart
			self.onStop = onStop
		}

		public func animationDidStart(_ anim: CAAnimation) {
			onStart?(anim)
		}
		
		public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
			onStop?(anim, flag)
		}
	}

	private static var associatedObjectHandler: UInt8 = 0
	public var animationHandler: AnimationHandler? {
		get { return objc_getAssociatedObject(self, &CAAnimation.associatedObjectHandler) as? AnimationHandler }
		set {
			objc_setAssociatedObject(self, &CAAnimation.associatedObjectHandler, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
			delegate = newValue
		}
	}

}

extension CALayer {
	
	public func animate(property: String, from: Any? = nil, to: Any, duration: CFTimeInterval = 0, delay: CFTimeInterval = 0, curve: CAMediaTimingFunction? = nil, handler: CAAnimation.AnimationHandler? = nil) {
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
		
		let animationHandler = CAAnimation.AnimationHandler(onStart: { [weak self] anim in
			guard let keyPath = anim.value(forKey: "keyPath") as? String,
				let toValue = anim.value(forKey: "toValue") else { return }
			
			self?.setValue(toValue, forKey: keyPath)
			handler?.onStart?(anim)
		}, onStop: handler?.onStop)
		
		animation.animationHandler = animationHandler
		
		add(animation, forKey: property)
	}
	
}
