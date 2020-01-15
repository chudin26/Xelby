//
//  DictionaryExtensions.swift
//  Xelby
//
//  Created by Yuriy Chudin on 22.09.16.
//  Copyright © 2016 Yuriy Chudin. All rights reserved.
//

import Foundation

public extension Dictionary {
	
	init(keyValuePairs: [(Key, Value)]) {
		self.init()
		
		for pair in keyValuePairs {
			self[pair.0] = pair.1
		}
	}

	static func + <K, V> (left: [K: V], right: [K: V]?) -> [K: V] {
		guard let right = right else { return left }
		return left.reduce(right) {
			var new = $0 as [K: V]
			new.updateValue($1.1, forKey: $1.0)
			return new
		}
	}
	
	static func += <K, V> (left: inout [K: V], right: [K: V]?) {
		guard let right = right else { return }
		right.forEach { key, value in
			left.updateValue(value, forKey: key)
		}
	}

	func compactMapKeys <T> (_ transform: ((Key) throws -> T?)) rethrows -> Dictionary <T, Value> {
		return try self.reduce(into: [T: Value]()) { (result, x) in
			if let key = try transform(x.key) {
				result[key] = x.value
			}
		}
	}

	func mapKeys <T> (_ transform: ((Key) throws -> T)) rethrows -> Dictionary <T, Value> {
		return try self.reduce(into: [T: Value]()) { (result, x) in
			let key = try transform(x.key)
			result[key] = x.value
		}
	}

}
