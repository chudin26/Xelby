//
//  WeakRef.swift
//  Xelby
//
//  Created by Yuriy Chudin on 04/09/2019.
//  Copyright © 2019 chood. All rights reserved.
//

import Foundation

public struct WeakRef <T> where T: AnyObject {

	public private(set) weak var value: T?

	public init(_ value: T?) {
		self.value = value
	}
}
