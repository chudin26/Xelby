//
//  BorderView.swift
//  Xelby
//
//  Created by Yuriy Chudin on 17.07.18.
//  Copyright © 2018 Yuriy Chudin. All rights reserved.
//

import UIKit

@IBDesignable
open class BorderView: UIView {
	
	@IBInspectable public var borderColor: UIColor {
		get { return layer.borderColor != nil ? UIColor(cgColor: layer.borderColor!) : UIColor.clear }
		set { layer.borderColor = newValue.cgColor }
	}
	
	@IBInspectable public var borderWidth: CGFloat {
		get { return layer.borderWidth }
		set { layer.borderWidth = newValue }
	}
	
	@IBInspectable public var borderRadius: CGFloat {
		get { return layer.cornerRadius }
		set { layer.cornerRadius = newValue }
	}
	
}
