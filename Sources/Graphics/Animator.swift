//
//  Animator.swift
//  Xelby
//
//  Created by Yuriy Chudin on 21/06/2018.
//  Copyright © 2018 chood. All rights reserved.
//

import UIKit

public class Animator {
	
	public enum AnimationType {
		public enum MoveDirection {
			case fromTop
			case fromBottom
			case fromLeft
			case fromRight
		}
		
		case slideIn(direction: MoveDirection)
		case scaleUp
		case fadeIn
	}
	
	private struct Animation {
		let type: AnimationType
		let view: UIView
		let duration: TimeInterval
		let delay: TimeInterval
	}
	
	private var animations: [Animation] = []
	
	public var defaultDuration: TimeInterval = 0.6
	
	weak var containerView: UIView?
	
	public init(containerView: UIView) {
		self.containerView = containerView
	}

	public func addAnimation(forView view: UIView, type: AnimationType, duration: TimeInterval? = nil, delay: TimeInterval = 0) {
		let animation = Animation(type: type, view: view, duration: duration ?? defaultDuration, delay: delay)
		animations.append(animation)
	}
	
	public func start(reverse: Bool = false) {
		for anim in animations {
			let setToStart = { anim.type.setToAnimatedState(view: anim.view, containerView: self.containerView!) }
			let setToEnd = { anim.type.setToOriginalState(view: anim.view, containerView: self.containerView!) }
			
			!reverse ? setToStart() : setToEnd()
			UIView.animate(withDuration: anim.duration, delay: anim.delay, curve: AnimationCurve.springEaseOut, animations: {
				reverse ? setToStart() : setToEnd()
			}, completion: nil)
		}
	}

}
