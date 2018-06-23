//
//  Dictionary+Additions.swift
//  Xelby
//
//  Created by Yuriy Chudin on 22.09.16.
//  Copyright © 2016 Yuriy Chudin. All rights reserved.
//

import Foundation

public extension Dictionary {

	static func + <K, V> (left: Dictionary <K, V>, right: Dictionary <K, V>?) -> Dictionary <K, V> {
		guard let right = right else { return left }
		return left.reduce(right) {
			var new = $0 as [K:V]
			new.updateValue($1.1, forKey: $1.0)
			return new
		}
	}
	
	static func += <K, V> (left: inout Dictionary <K, V>, right: Dictionary <K, V>?) {
		guard let right = right else { return }
		right.forEach { key, value in
			left.updateValue(value, forKey: key)
		}
	}

}
