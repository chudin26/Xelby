//
//  WeakArray.swift
//  Xelby
//
//  Created by Yuriy Chudin on 04/09/2019.
//  Copyright © 2019 chood. All rights reserved.
//

import Foundation

class WeakArray <T: AnyObject> {
	
	private var array = NSPointerArray.weakObjects()
	
	func add(_ object: T) {
		let pointer = Unmanaged.passUnretained(object).toOpaque()
		array.addPointer(pointer)
	}
	
	func insertObject(_ object: T, at index: Int) {
		guard index < array.count else { return }
		let pointer = Unmanaged.passUnretained(object).toOpaque()
		array.insertPointer(pointer, at: index)
	}
	
	func replaceObject(at index: Int, withObject object: AnyObject?) {
		guard index < array.count, let strongObject = object else { return }
		let pointer = Unmanaged.passUnretained(strongObject).toOpaque()
		array.replacePointer(at: index, withPointer: pointer)
	}
	
	func object(at index: Int) -> T? {
		guard index < array.count, let pointer = array.pointer(at: index) else { return nil }
		return Unmanaged<T>.fromOpaque(pointer).takeUnretainedValue()
	}
	
	func removeObject(at index: Int) {
		guard index < array.count else { return }
		array.removePointer(at: index)
	}
	
	func forEach(body: (T) -> ()) {
		for i in 0 ..< array.count {
			if let obj = object(at: i) {
				body(obj)
			}
		}
	}
	
}
