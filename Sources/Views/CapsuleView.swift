//
//  CapsuleView.swift
//  Xelby
//
//  Created by Yuriy Chudin on 29.11.2019.
//  Copyright © 2019 chood. All rights reserved.
//

import UIKit

@IBDesignable
open class CapsuleView: BorderView {
	
	override open func layoutSubviews() {
		super.layoutSubviews()
		
		borderRadius = min(bounds.width, bounds.height) / 2
	}
	
}
