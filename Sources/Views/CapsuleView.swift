//
//  CapsuleView.swift
//  Xelby
//
//  Created by Yuriy Chudin on 29.11.2019.
//  Copyright © 2019 chood. All rights reserved.
//

import UIKit

@IBDesignable
class CapsuleView: UIView {
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		layer.cornerRadius = min(bounds.width, bounds.height) / 2
	}
	
}
