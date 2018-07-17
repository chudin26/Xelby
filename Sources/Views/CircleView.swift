//
//  CircleView.swift
//  Xelby
//
//  Created by Yuriy Chudin on 17.07.18.
//  Copyright © 2018 Yuriy Chudin. All rights reserved.
//

import UIKit

@IBDesignable
class CircleView: UIView {

	func setup() {
		layer.cornerRadius = bounds.height / 2
	}
	
	override func awakeFromNib() {
		setup()
	}
	
	override func prepareForInterfaceBuilder() {
		setup()
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		setup()
	}

}
