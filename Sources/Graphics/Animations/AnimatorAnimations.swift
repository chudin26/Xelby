//
//  AnimatorAnimations.swift
//  Xelby
//
//  Created by Yuriy Chudin on 07/07/2018.
//  Copyright © 2018 chood. All rights reserved.
//

import UIKit

extension Animator.AnimationType {

	func setToAnimatedState(view: UIView, containerView: UIView) {
		switch self {
		case .slideIn(let direction):
			let parentFrame = containerView.bounds
			let originalFrame: CGRect = view.frame
			// TODO: test on a real device and compare a difference between frame animation and transform animation
			
//			var startFrame: CGRect = originalFrame
//			switch direction {
//			case .fromTop: startFrame.origin.y = parentFrame.minY - originalFrame.height
//			case .fromBottom: startFrame.origin.y = parentFrame.maxY + originalFrame.height
//			case .fromLeft: startFrame.origin.x = parentFrame.minX - originalFrame.width
//			case .fromRight: startFrame.origin.x = parentFrame.maxX + originalFrame.width
//			}
//
//			setToStart = { anim.view.frame = startFrame }
//			setToEnd = { anim.view.frame = originalFrame }
			
			let startTransform: CGAffineTransform
			switch direction {
			case .fromTop: 		startTransform = CGAffineTransform(translationX: 0, y: parentFrame.minY - originalFrame.maxY)
			case .fromBottom: 	startTransform = CGAffineTransform(translationX: 0, y: parentFrame.maxY - originalFrame.minY)
			case .fromLeft: 	startTransform = CGAffineTransform(translationX: parentFrame.minX - originalFrame.maxX, y: 0)
			case .fromRight: 	startTransform = CGAffineTransform(translationX: parentFrame.maxX - originalFrame.minX, y: 0)
			}
			
			view.transform = startTransform

		case .slide(let direction):
			let parentFrame = containerView.bounds
			let originalFrame: CGRect = view.frame
			
			let startTransform: CGAffineTransform
			switch direction {
			case .fromTop: 		startTransform = CGAffineTransform(translationX: 0, y: parentFrame.minY - originalFrame.maxY)
			case .fromBottom: 	startTransform = CGAffineTransform(translationX: 0, y: parentFrame.maxY - originalFrame.minY)
			case .fromLeft: 	startTransform = CGAffineTransform(translationX: parentFrame.minX - originalFrame.maxX, y: 0)
			case .fromRight: 	startTransform = CGAffineTransform(translationX: parentFrame.maxX - originalFrame.minX, y: 0)
			}
			
			view.transform = startTransform

		case .scaleUp, .scale:
			view.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
			
		case .fadeIn, .fade:
			view.alpha = 0
		}
	}
	
	func setToOriginalState(view: UIView, containerView: UIView) {
		switch self {
		case .slideIn(_), .scaleUp, .slide, .scale:
			view.transform = .identity
			
		case .fadeIn, .fade:
			view.alpha = 1
		}
	}
	
}
