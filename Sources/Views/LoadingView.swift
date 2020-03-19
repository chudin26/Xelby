//
//  LoadingView.swift
//  Xelby
//
//  Created by Yuriy Chudin on 19.03.2020.
//  Copyright © 2020 chood. All rights reserved.
//

import UIKit

open class LoadingView: UIView {

	public static func create(on view: UIView) -> LoadingView {
		let loadingView = LoadingView()
		loadingView.backgroundColor = .init(white: 0, alpha: 0.5)
		
		let indicator = UIActivityIndicatorView(style: .whiteLarge)
		indicator.startAnimating()
		loadingView.addSubview(indicator, attributes: [.centerX, .centerY])
		
		view.addSubview(loadingView, autoLayoutMargin: 0)
		loadingView.fadeIn(duration: 0.1)
		
		return loadingView
	}
	
	public func hide() {
		fadeOut(duration: 0.1) { _ in
			self.removeFromSuperview()
		}
	}

}
