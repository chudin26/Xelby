//
//  WeakRef.swift
//  Xelby
//
//  Created by Yuriy Chudin on 04/09/2019.
//  Copyright © 2019 chood. All rights reserved.
//

import Foundation

class WeakRef <T> where T: AnyObject {
	
	private(set) weak var value: T?
	
	init(value: T?) {
		self.value = value
	}
	
}
