//
//  GestureRecognizerClosures.swift
//  Xelby
//
//  Created by Yuriy Chudin on 14/07/2018.
//  Copyright © 2018 chood. All rights reserved.
//

import UIKit

public extension UIGestureRecognizer {
	
	static private var HandlerKey: UInt8 = 0
	
	func setHandler <T: UIGestureRecognizer> (_ instance: T, handler: ClosureHandler <T>) {
		objc_setAssociatedObject(self, &UIGestureRecognizer.HandlerKey, handler, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		handler.control = instance
	}
	
	func handler <T> () -> ClosureHandler <T> {
		return objc_getAssociatedObject(self, &UIGestureRecognizer.HandlerKey) as! ClosureHandler <T>
	}
	
}

public extension UITapGestureRecognizer {
	
	convenience init(taps: Int = 1, touches: Int = 1, handler: @escaping (UITapGestureRecognizer) -> Void) {
		let handler = ClosureHandler <UITapGestureRecognizer> (handler: handler)
		self.init(target: handler, action: closureHandlerSelector)
		setHandler(self, handler: handler)
		numberOfTapsRequired = taps
		numberOfTouchesRequired = touches
	}
	
}

public extension UILongPressGestureRecognizer {
	
	convenience init(handler: @escaping (UILongPressGestureRecognizer) -> Void) {
		let handler = ClosureHandler <UILongPressGestureRecognizer> (handler: handler)
		self.init(target: handler, action: closureHandlerSelector)
		setHandler(self, handler: handler)
	}
	
}

public extension UISwipeGestureRecognizer {
	
	convenience init(direction: UISwipeGestureRecognizer.Direction, handler: @escaping (UISwipeGestureRecognizer) -> Void) {
		let handler = ClosureHandler <UISwipeGestureRecognizer> (handler: handler)
		self.init(target: handler, action: closureHandlerSelector)
		setHandler(self, handler: handler)
		self.direction = direction
	}
	
}

public extension UIPanGestureRecognizer {
	
	convenience init(handler: @escaping (UIPanGestureRecognizer) -> Void) {
		let handler = ClosureHandler <UIPanGestureRecognizer> (handler: handler)
		self.init(target: handler, action: closureHandlerSelector)
		setHandler(self, handler: handler)
	}
	
}

public extension UIPinchGestureRecognizer {
	
	convenience init(handler: @escaping (UIPinchGestureRecognizer) -> Void) {
		let handler = ClosureHandler <UIPinchGestureRecognizer> (handler: handler)
		self.init(target: handler, action: closureHandlerSelector)
		setHandler(self, handler: handler)
	}
}

public extension UIRotationGestureRecognizer {
	
	convenience init(handler: @escaping (UIRotationGestureRecognizer) -> Void) {
		let handler = ClosureHandler <UIRotationGestureRecognizer> (handler: handler)
		self.init(target: handler, action: closureHandlerSelector)
		setHandler(self, handler: handler)
	}
	
}

public extension UIScreenEdgePanGestureRecognizer {
	
	convenience init(screenEdgeHandler: @escaping (UIScreenEdgePanGestureRecognizer) -> Void) {
		let handler = ClosureHandler <UIScreenEdgePanGestureRecognizer> (handler: screenEdgeHandler)
		self.init(target: handler, action: closureHandlerSelector)
		setHandler(self, handler: handler)
	}

}
