//
//  WeakDictionary.swift
//  Xelby
//
//  Created by Alexey Ilin on 21.01.2021.
//  Copyright © 2021 chood. All rights reserved.
//

import Foundation

@propertyWrapper
public struct WeakDictionary<T: Hashable, Element: AnyObject> {
	private var storage = [T:WeakRef<Element>]()

	public init() {}

	public init(wrappedValue: [T:Element]) {
		self.wrappedValue = wrappedValue
	}

	public var wrappedValue: [T:Element] {
		mutating get {
			refreshStorage()
			return Dictionary(uniqueKeysWithValues: storage.map { key, value in (key, value.value!) })
		}
		set {
			storage = Dictionary(uniqueKeysWithValues: newValue.map { key, value in (key, WeakRef(value)) })
		}
	}

	private mutating func refreshStorage() {
		storage = storage.filter { $0.value.value != nil }
	}
}
