//
//  RangeExtensions.swift
//  Xelby
//
//  Created by Yuriy Chudin on 24.10.2019.
//  Copyright © 2019 chood. All rights reserved.
//

import Foundation

public extension ClosedRange {
	
	func clamp(_ value: Bound) -> Bound {
		return Swift.min(Swift.max(value, lowerBound), upperBound)
	}
	
}
