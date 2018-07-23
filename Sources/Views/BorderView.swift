//
//  BorderView.swift
//  Xelby
//
//  Created by Yuriy Chudin on 17.07.18.
//  Copyright © 2018 Yuriy Chudin. All rights reserved.
//

import UIKit

@IBDesignable
class BorderView: UIView {
	
	@IBInspectable var borderColor: UIColor {
		get { return UIColor(cgColor: layer.borderColor!) }
		set { layer.borderColor = newValue.cgColor }
	}
	
	@IBInspectable var borderWidth: CGFloat {
		get { return layer.borderWidth }
		set { layer.borderWidth = newValue }
	}

	@IBInspectable var borderRadius: CGFloat {
		get { return layer.cornerRadius }
		set { layer.cornerRadius = newValue }
	}
	
}
