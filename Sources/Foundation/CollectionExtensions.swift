//
//  CollectionExtensions.swift
//  Xelby
//
//  Created by Yuriy Chudin on 17/07/2018.
//  Copyright © 2018 chood. All rights reserved.
//

import Foundation

public extension Collection {
	
	func mapToDictionary <K: Hashable, V> (transform: (_ element: Iterator.Element) -> (key: K, value: V)?) -> [K: V] {
		var dictionary = [K: V]()
		self.forEach { element in
			if let pair = transform(element) {
				dictionary[pair.key] = pair.value
			}
		}
		
		return dictionary
	}
	
}
