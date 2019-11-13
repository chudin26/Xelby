//
//  UIControlHandler.swift
//  Xelby
//
//  Created by Yuriy Chudin on 18.10.2019.
//  Copyright © 2019 chood. All rights reserved.
//

import UIKit

public extension UIControl {
	
    func addAction(for controlEvents: UIControl.Event, _ closure: @escaping (UIControl) -> ()) {
		let handler = ClosureHandler(handler: closure, control: self)
        addTarget(handler, action: closureHandlerSelector, for: controlEvents)
        objc_setAssociatedObject(self, "[\(arc4random())]", handler, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
	
}
