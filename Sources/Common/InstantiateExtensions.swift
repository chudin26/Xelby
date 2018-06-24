//
//  InstantiateExtensions.swift
//  Xelby
//
//  Created by Yuriy Chudin on 29/06/16.
//  Copyright © 2016 Yuriy Chudin. All rights reserved.
//

import UIKit

public extension UITableView {
	
	func dequeueReusableCell <T> () -> T {
		return self.dequeueReusableCell(withIdentifier: "\(T.self)") as! T
	}
	
}

public extension UIStoryboard {
	
	func instantiateViewController <T> () -> T {
		return self.instantiateViewController(withIdentifier: "\(T.self)") as! T
	}
	
}

public extension UITableViewCell {
	
	static func className() -> String {
		return "\(self)"
	}
	
}
