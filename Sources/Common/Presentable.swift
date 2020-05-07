//
//  Presentable.swift
//  Xelby
//
//  Created by Yuriy Chudin on 04/09/2019.
//  Copyright © 2019 chood. All rights reserved.
//

import UIKit

public enum PresentStyle {
	case present
	case push
}

public protocol Presenting {
	associatedtype Presentable
	
	func present(_ presentable: Presentable, presentStyle: PresentStyle, animated: Bool)
	func dismiss(presentStyle: PresentStyle, animated: Bool)
}

extension UIViewController: Presenting {
	
	public func present(_ presentable: UIViewController, presentStyle: PresentStyle, animated: Bool) {
		switch presentStyle {
		case .present:
			self.present(presentable, animated: animated, completion: nil)
			
		case .push:
			self.navigationController?.pushViewController(presentable, animated: animated)
		}
		
	}
	
	public func dismiss(presentStyle: PresentStyle, animated: Bool) {
		switch presentStyle {
		case .present:
			presentingViewController?.dismiss(animated: animated, completion: nil)
			
		case .push:
			self.navigationController?.popViewController(animated: animated)
		}
	}
	
}
