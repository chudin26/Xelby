//
//  ViewSwitch.swift
//  Xelby
//
//  Created by Yuriy Chudin on 06.05.2020.
//  Copyright © 2020 chood. All rights reserved.
//

import UIKit

public class ViewSwitch: UIView {
		
	@IBOutlet public var views: [UIView]!

	public private (set) var currentIndex: Int = -1
	
	public func switchTo(index: Int, with animationType: Animator.AnimationType? = nil, duration: TimeInterval? = nil, curve: CAMediaTimingFunction? = nil) {
		if index == currentIndex {
			return
		}
		
		let oldView = currentIndex == -1 ? nil : views[currentIndex]
		let newView = views[index]
		
		if let animType = animationType {
			var reversedType = animType
			if case let .slide(direction) = animType {
				reversedType = .slide(direction: direction.reversed)
			}
			
			if let oldView = oldView {
				Animator.startAnimation(forView: oldView, type: reversedType, duration: duration, curve: curve, reverse: true, containerView: self) {
					oldView.isHidden = true
				}
			}

			newView.isHidden = false
			Animator.startAnimation(forView: newView, type: animType, duration: duration, curve: curve, containerView: self)
		} else {
			oldView?.isHidden = true
			newView.isHidden = false
		}
		
		currentIndex = index
	}
	
	public func reset() {
		currentIndex = -1
		views.forEach { $0.isHidden = true }
	}

}
