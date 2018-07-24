//
//  CircleButton.swift
//  Xelby
//
//  Created by Yuriy Chudin on 12/07/2018.
//  Copyright © 2018 chood. All rights reserved.
//

import UIKit

@IBDesignable
class CircleButton: SelectableButton {

	func setup() {
		cornerRadius = bounds.height / 2
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
