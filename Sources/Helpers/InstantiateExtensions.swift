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

public extension UIView {
	
	class func instantiate <T: UIView> (fromNib nibName: String, index: Int) -> T? {
		return Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)?[index] as? T
	}
	
	class func instantiate <T: UIView> (index: Int = 0) -> T {
		return instantiate(fromNib: "\(T.self)", index: index)!
	}
	
	class func instantiate(fromNib nibName: String) -> Self? {
		return instantiate(fromNib: nibName, index: 0)
	}
	
	class func instantiateFromNib() -> Self? {
		return instantiate(fromNib: "\(self)")
	}

}
