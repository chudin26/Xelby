//
//  UIViewFadeAnimations.swift
//  Xelby
//
//  Created by Yuriy Chudin on 26/09/2019.
//  Copyright © 2019 chood. All rights reserved.
//

import UIKit

public extension UIView {
	
	static let defaultDuration: TimeInterval = 0.25
	
	
	typealias AnimationBlock = (UIView) -> ()
	typealias CompletionBlock = (Bool) -> ()
	
	enum Fade {
		@available(*, deprecated)
		case fade
		
		case opacity
		case scale
		
		enum State {
			case hide
			case show
		}
		
		internal func setup(view: UIView, for state: State) {
			switch self {
			case .fade, .opacity: return view.alpha = state == .show ? 1 : 0
			case .scale: return view.transform = CGAffineTransform(scale: state == .show ? 1 : 0.01)
			}
		}
		
	}

	func fadeIn(duration: TimeInterval = defaultDuration, delay: TimeInterval = 0, type: Fade = .opacity, completion: CompletionBlock? = nil) {
		isHidden = false
		type.setup(view: self, for: .hide)
		
		UIView.animate(withDuration: duration, delay: delay, animations: {
			type.setup(view: self, for: .show)
		}, completion: { success in
			completion?(success)
		})
	}
	
	func fadeOut(duration: TimeInterval = defaultDuration, delay: TimeInterval = 0, type: Fade = .opacity, completion: CompletionBlock? = nil) {
		UIView.animate(withDuration: duration, delay: delay, options: .beginFromCurrentState, animations: {
			type.setup(view: self, for: .hide)
		}, completion: { success in
			self.isHidden = true
			completion?(success)
		})
	}
	
	func fade(_ out: Bool, duration: TimeInterval = defaultDuration, delay: TimeInterval = 0, type: Fade = .opacity, completion: CompletionBlock? = nil) {
		if out {
			fadeOut(duration: duration, delay: delay, type: type, completion: completion)
		} else {
			fadeIn(duration: duration, delay: delay, type: type, completion: completion)
		}
	}

}
