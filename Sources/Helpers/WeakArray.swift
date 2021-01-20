//
//  WeakArray.swift
//  Xelby
//
//  Created by Yuriy Chudin on 04/09/2019.
//  Copyright © 2019 chood. All rights reserved.
//

import Foundation

@propertyWrapper
public class WeakArray<Element> where Element: AnyObject {
	private var storage = [WeakRef<Element>]()

	public init() {}

	public var wrappedValue: [Element] {
		get {
			return storage.compactMap { $0.value }
		}
		set {
			storage = newValue.map { WeakRef($0) { [weak self] in self?.refreshStorage() } }
		}
	}

	private func refreshStorage() {
		storage.removeAll { $0.value == nil }
	}
}
