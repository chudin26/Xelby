//
//  ClosureHandler.swift
//  Xelby
//
//  Created by Yuriy Chudin on 14/07/2018.
//  Copyright © 2018 chood. All rights reserved.
//

import UIKit

public typealias VoidFunc = () -> ()
public typealias Func <T> = (T) -> ()

let closureHandlerSelector = Selector(("handle"))

public class ClosureHandler <T: AnyObject>: NSObject {

	private var handler: ((T) -> Void)?
	internal weak var control: T?
	
	public init(handler: @escaping (T) -> Void, control: T? = nil) {
		self.handler = handler
		self.control = control
	}
	
	@objc private func handle() {
		if let control = self.control {
			handler?(control)
		}
	}
}
