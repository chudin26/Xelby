//
//  WeakWatcher.swift
//  Xelby
//
//  Created by Alexey Ilin on 20.01.2021.
//  Copyright © 2021 chood. All rights reserved.
//

import Foundation

private var key: UInt8 = 0
public class WeakWatcher {
	private var onDeinit: () -> ()

	private init(onDeinit: @escaping () -> ()) {
		self.onDeinit = onDeinit
	}

	public static func watch(_ obj: Any, onDeinit: @escaping () -> ()) {
		watch(obj, key: &key, onDeinit: onDeinit)
	}

	public static func watch(_ obj: Any, key: UnsafeRawPointer, onDeinit: @escaping () -> ()) {
		objc_setAssociatedObject(obj, key, WeakWatcher(onDeinit: onDeinit), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
	}

	deinit {
		self.onDeinit()
	}
}
