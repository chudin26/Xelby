//
//  PanAnimator.swift
//  Xelby
//
//  Created by Yuriy Chudin on 14/07/2018.
//  Copyright © 2018 chood. All rights reserved.
//

import UIKit

public class PanAnimator: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
	
	public var containerView: UIView!
	public var toggleView: UIView? {
		didSet {
			let gesture = UIPanGestureRecognizer(target: self, action: #selector(onPan(recognizer:)))
			toggleView?.addGestureRecognizer(gesture)
		}
	}
	
	private (set) var direction: Direction
	private var triggerHandler: () -> ()
	
	private var dismissing: Bool = false
	
	public init(direction: Direction, triggerHandler: @escaping () -> ()) {
		self.direction = direction
		self.triggerHandler = triggerHandler
	}
	
	@objc private func onPan(recognizer: UIPanGestureRecognizer) {
		var offset = recognizer.translation(in: containerView)
		offset = CGPoint(direction.isHorizontal ? offset.x : 0, direction.isHorizontal ? 0 : offset.y)
		
		switch recognizer.state {
		case .changed:
			containerView.transform = CGAffineTransform(translationX: offset.x, y: offset.y)
			
		case .ended:
			let velocity = CGVector(point: recognizer.velocity(in: containerView))
			let vector = CGVector(point: offset) + velocity * 0.1
			let limit = CGVector(containerView.bounds.width * direction.vector.dx, containerView.bounds.height * direction.vector.dy)
			if vector.length > limit.length / 4 && limit * vector > 0 {
				triggerHandler()
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
		return 0.3
	}
	
	public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		let duration = transitionDuration(using: transitionContext)
		
		let fromView = transitionContext.view(forKey: .from)!
		let toView = transitionContext.view(forKey: .to)!

		let containerView = transitionContext.containerView
		containerView.addSubview(toView)
		
		let dir = dismissing ? direction.inverse : direction
		toView.transform = dir.transform(forToView: fromView)
		UIView.animate(withDuration: duration, delay: 0, curve: AnimationCurves.easeOut, animations: {
			fromView.transform = dir.transform(forFromView: fromView)
			toView.transform = .identity
		}, completion: { _ in
			transitionContext.completeTransition(true)
		})
	}
	
	// MARK: UIViewControllerTransitioningDelegate
	public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		dismissing = false
		return self
	}
	
	public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		dismissing = true
		return self
	}
	
}

extension PanAnimator {

	public enum Direction {
		case up
		case down
		case left
		case right
		
		var vector: CGVector {
			switch self {
			case .up: return CGVector(dx: 0, dy: -1)
			case .down: return CGVector(dx: 0, dy: 1)
			case .left: return CGVector(dx: -1, dy: 0)
			case .right: return CGVector(dx: 1, dy: 0)
			}
		}
		
		var isHorizontal: Bool {
			return self == .left || self == .right
		}
		
		var inverse: Direction {
			switch self {
			case .up: return .down
			case .down: return .up
			case .left: return .right
			case .right: return .left
			}
		}
		
		func transform(forToView view: UIView) -> CGAffineTransform {
			return inverse.transform(forFromView: view)
		}
		
		func transform(forFromView view: UIView) -> CGAffineTransform {
			return CGAffineTransform(translationX: view.bounds.width * vector.dx, y: view.bounds.height * vector.dy)
		}
	}

}
