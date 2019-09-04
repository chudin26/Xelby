//
//  XibView.swift
//  Xelby
//
//  Created by Yuriy Chudin on 04/09/2019.
//  Copyright © 2019 chood. All rights reserved.
//

import UIKit

// Use it to see a view from xib directly in Interface Builder

@IBDesignable
public class XibView: UIView {
	
	@IBInspectable private (set) var xibName: String? {
		didSet {
			setup()
		}
	}
	
	public var contentView: UIView?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setup()
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setup()
	}
	
	private func setup() {
		guard
			let nibName = xibName,
			let view = UIView.instantiate(fromNib: nibName) else {
				return
		}
		
		view.embed(in: self)
		
		contentView?.removeFromSuperview()
		contentView = view
	}
	
}
