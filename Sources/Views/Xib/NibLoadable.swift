//
//  NibLoadable.swift
//  Xelby
//
//  Created by Yuriy Chudin on 04/09/2019.
//  Copyright © 2019 chood. All rights reserved.
//

import UIKit

public protocol NibLoadable {
	func initialize()
}

public extension NibLoadable where Self: UIView {
	
	func setupFromNib() {
		let bundle = Bundle(for: type(of: self))
		let nibName = String(describing: type(of: self))
		let nib = UINib(nibName: nibName, bundle: bundle)
		
		guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
			fatalError("Error loading \(self) from nib")
		}
		
		addSubview(view)
		
		view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
		view.frame = bounds
		
		initialize()
	}
	
}

public class NibView: UIView, NibLoadable {
	
	public func initialize() {}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setupFromNib()
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupFromNib()
	}
	
}
