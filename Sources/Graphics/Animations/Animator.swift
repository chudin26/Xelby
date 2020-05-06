//
//  Animator.swift
//  Xelby
//
//  Created by Yuriy Chudin on 21/06/2018.
//  Copyright © 2018 chood. All rights reserved.
//

import UIKit

// Animator is needed for running several animations simultaneously. Useful for fade (or scale) in/out views
public class Animator {
	
	public enum AnimationType {
		
		public enum MoveDirection {
			case fromTop
			case fromBottom
			case fromLeft
			case fromRight
			
			var reversed: MoveDirection {
				switch self {
				case .fromTop: return .fromBottom
				case .fromBottom: return .fromTop
				case .fromLeft: return .fromRight
				case .fromRight: return .fromLeft
				}
			}
		}
		
		@available(*, deprecated, message: "Use 'slide' instead")
		case slideIn(direction: MoveDirection)
		case slide(direction: MoveDirection)
		
		@available(*, deprecated, message: "Use 'scale' instead")
		case scaleUp
		case scale

		@available(*, deprecated, message: "Use 'fade' instead")
		case fadeIn
		case fade
		
	}
	
	public struct Animation {
		let type: AnimationType
		let view: UIView
		let duration: TimeInterval
		let curve: CAMediaTimingFunction
		let delay: TimeInterval
	}
	
	private var animations: [Animation] = []
	
	public var defaultDuration: TimeInterval = 0.5
	public var defaultCurve: CAMediaTimingFunction = AnimationCurves.superEaseOut
	
	weak var containerView: UIView?
	
	public init(containerView: UIView) {
		self.containerView = containerView
	}

	public func addAnimation(forView view: UIView, type: AnimationType, duration: TimeInterval? = nil, curve: CAMediaTimingFunction? = nil, delay: TimeInterval = 0) {
		let animation = Animation(type: type,
								  view: view,
								  duration: duration ?? defaultDuration,
								  curve: curve ?? defaultCurve,
								  delay: delay)
		animations.append(animation)
	}
	
	public func start(reverse: Bool = false) {
		for anim in animations {
			Animator.start(animation: anim, reverse: reverse, containerView: self.containerView!)
		}
	}
	
	static public func start(animation: Animation, reverse: Bool = false, containerView: UIView, completion: VoidFunc? = nil) {
		let setToStart = { animation.type.setToAnimatedState(view: animation.view, containerView: containerView) }
		let setToEnd = { animation.type.setToOriginalState(view: animation.view, containerView: containerView) }
		
		!reverse ? setToStart() : setToEnd()
		UIView.animate(withDuration: animation.duration, delay: animation.delay, curve: animation.curve, animations: {
			reverse ? setToStart() : setToEnd()
		}, completion: { _ in completion?() })
	}

	static public func startAnimation(forView view: UIView, type: AnimationType, duration: TimeInterval? = nil, curve: CAMediaTimingFunction? = nil, delay: TimeInterval = 0, reverse: Bool = false, containerView: UIView, completion: VoidFunc? = nil) {
		let animation = Animation(type: type,
								  view: view,
								  duration: duration ?? 0.5,
								  curve: curve ?? AnimationCurves.superEaseOut,
								  delay: delay)
		start(animation: animation, reverse: reverse, containerView: containerView, completion: completion)
	}

}
