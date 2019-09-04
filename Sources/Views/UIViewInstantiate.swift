//
//  UIViewInstantiate.swift
//  Xelby
//
//  Created by Yuriy Chudin on 04/09/2019.
//  Copyright © 2019 chood. All rights reserved.
//

import UIKit

public extension UIView {
	
	static func instantiate <T: UIView> (fromNib nibName: String, index: Int) -> T? {
		return Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)?[index] as? T
	}
	
	static func instantiate <T: UIView> (index: Int = 0) -> T {
		return instantiate(fromNib: "\(T.self)", index: index)!
	}
	
	class func instantiate(fromNib nibName: String) -> Self? {
		return instantiate(fromNib: nibName, index: 0)
	}
	
	class func instantiateFromNib() -> Self? {
		return instantiate(fromNib: "\(self)")
	}
	
}
