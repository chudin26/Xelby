//
//  Coordinator.swift
//  Xelby
//
//  Created by Yuriy Chudin on 04/09/2019.
//  Copyright © 2019 chood. All rights reserved.
//

import Foundation

public protocol Coordinator {
	associatedtype Presenting
	func start(in presenting: Presenting)
}
