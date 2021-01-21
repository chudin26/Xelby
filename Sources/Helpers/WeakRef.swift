//
//  WeakRef.swift
//  Xelby
//
//  Created by Yuriy Chudin on 04/09/2019.
//  Copyright © 2019 chood. All rights reserved.
//

import Foundation

public class WeakRef <T> where T: AnyObject {

	private var onDispose: (() -> ())? = nil
	public private(set) weak var value: T?

	public init(_ value: T?, onDispose: (() -> ())? = nil) {
		self.value = value
		self.onDispose = onDispose
		setupWatcher()
	}

	private func setupWatcher() {
		guard let value = value, let onDispose = onDispose else { return }
		WeakWatcher.watch(value, onDeinit: onDispose)
	}
}
