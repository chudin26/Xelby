//
//  InstantiateExtensions.swift
//  Xelby
//
//  Created by Yuriy Chudin on 29/06/16.
//  Copyright © 2016 Yuriy Chudin. All rights reserved.
//

import UIKit

public extension UITableView {
	
	func dequeueReusableCell <T: UITableViewCell> () -> T {
		return self.dequeueReusableCell(withIdentifier: "\(T.self)") as! T
	}
	
}

public extension UIStoryboard {
	
	func instantiateViewController <T: UIViewController> () -> T {
		return self.instantiateViewController(withIdentifier: "\(T.self)") as! T
	}
	
}

public extension UICollectionView {
	
	func dequeueReusableCell <T: UICollectionViewCell> (for indexPath: IndexPath) -> T {
		return self.dequeueReusableCell(withReuseIdentifier: "\(T.self)", for: indexPath) as! T
	}
	
}

public extension UIViewController {
	
	class func instantiateFromStoryboard(name: String) -> Self {
		return UIStoryboard(name: name, bundle: nil).instantiateViewController()
	}
	
}
