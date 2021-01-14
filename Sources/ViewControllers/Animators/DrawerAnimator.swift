//
//  DrawerAnimator.swift
//  Xelby
//
//  Created by Yuriy Chudin on 14/07/2018.
//  Copyright © 2018 chood. All rights reserved.
//

import UIKit

public class DrawerAnimator: NSObject, UIViewControllerAnimatedTransitioning {
	
	public enum Direction {
		case fromLeft
		case fromRight
	}
	
	static let fadeViewTag = 123
	
	public var containerView: UIView!
	
	private var dismissing: Bool
	private var direction: Direction
	private var fadeBackgroundColor: UIColor
	
	public init(dismissing: Bool = false, direction: Direction = .fromLeft, fadeBackgroundColor: UIColor = .init(white: 0, alpha: 0.6)) {
		self.dismissing = dismissing
		self.direction = direction
		self.fadeBackgroundColor = fadeBackgroundColor
	}
	
	@objc private func onPan(recognizer: UIPanGestureRecognizer) {
		var offset = recognizer.translation(in: containerView)
		offset = CGPoint(offset.x, 0)
		
		switch recognizer.state {
		case .changed:
			containerView.transform = CGAffineTransform(translationX: offset.x, y: offset.y)
			
		case .ended:
			let velocity = CGVector(point: recognizer.velocity(in: containerView))
			let vector = CGVector(point: offset) + velocity * 0.1
			let limit = CGVector(containerView.bounds.width, containerView.bounds.height * 0)
			if vector.length > limit.length / 4 && limit * vector > 0 {
//				triggerHandler()
			} else {
				resetTransform()
			}
		case .cancelled:
			resetTransform()
			
		default: break
		}
	}
	
	private func resetTransform() {
		UIView.animate(withDuration: 0.2) {
			self.containerView.transform = .identity
		}
	}
	
	// MARK: UIViewControllerAnimatedTransitioning
	public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		return 0.4
	}
	
	public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		let duration = transitionDuration(using: transitionContext)
		
		let containerView = transitionContext.containerView
		let fromView = transitionContext.viewController(forKey: .from)!.view!
		let toView = transitionContext.viewController(forKey: .to)!.view!
		
		if !dismissing {
			let fadeView = UIView(frame: containerView.bounds)
			fadeView.tag = DrawerAnimator.fadeViewTag
			fadeView.backgroundColor = fadeBackgroundColor
			fadeView.fadeIn(duration: duration / 2)
			
			containerView.addSubview(fadeView)
			containerView.addSubview(toView)
		} else {
			if let fadeView = containerView.viewWithTag(DrawerAnimator.fadeViewTag) {
				fadeView.fadeOut(duration: duration)
			}
		}
		
		let drawerView = dismissing ? fromView : toView
		let fromTransform = CGAffineTransform(translationX: (direction == .fromLeft ? -1 : 1) * drawerView.bounds.width / 2, y: 0)
		let toTransform = CGAffineTransform.identity
		let curve = AnimationCurves.superEaseOut

		drawerView.transform = !self.dismissing ? fromTransform : toTransform
		UIView.animate(withDuration: duration, curve: curve, animations: {
			drawerView.transform = self.dismissing ? fromTransform : toTransform
		}, completion: { _ in
			if self.dismissing {
				drawerView.removeFromSuperview()
			}
			
			transitionContext.completeTransition(true)
		})
	}
	
}
