//
//  AnimatableViewController.swift
//  Xelby
//
//  Created by Yuriy Chudin on 22/06/2018.
//  Copyright © 2018 chood. All rights reserved.
//

import UIKit

open class AnimatableViewController: UIViewController {
	
	public var animator: Animator!
	
	private var animationStarted: Bool = false

	override open func viewDidLoad() {
        super.viewDidLoad()

		animator = Animator(containerView: view)
    }

	override open func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}
	
	open override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		if !animationStarted {
			if animateOnViewAppear() {
				animator.start(reverse: false)
				animationStarted = true
			}
		}
	}
	
	override open func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		
		if animateOnViewDisappear() {
			animator.start(reverse: true)
		}
	}
	
	open func animateOnViewAppear() -> Bool {
		return true
	}

	open func animateOnViewDisappear() -> Bool {
		return false
	}

}
