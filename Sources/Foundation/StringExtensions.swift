//
//  StringExtensions.swift
//  Xelby
//
//  Created by Yuriy Chudin on 17/07/2018.
//  Copyright © 2018 chood. All rights reserved.
//

import Foundation

public extension String {

	var localized: String {
		return NSLocalizedString(self, comment: "")
	}
	
}
