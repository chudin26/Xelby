//
//  CircleButton.swift
//  Xelby
//
//  Created by Yuriy Chudin on 12/07/2018.
//  Copyright © 2018 chood. All rights reserved.
//

import UIKit

@IBDesignable
open class CircleButton: SelectableButton {

	func setup() {
		cornerRadius = bounds.height / 2
	}
	
	open override func awakeFromNib() {
		setup()
	}
	
	open override func prepareForInterfaceBuilder() {
		setup()
	}
	
	open override func layoutSubviews() {
		super.layoutSubviews()
		
		setup()
	}
	
}
