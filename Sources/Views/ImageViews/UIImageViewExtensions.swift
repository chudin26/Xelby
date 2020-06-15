//
//  UIImageViewExtensions.swift
//  Xelby
//
//  Created by Yuriy Chudin on 21/09/2018.
//  Copyright © 2018 chood. All rights reserved.
//

import UIKit

public extension UIImageView {

	func loadImageAsync(fromFileUrl fileUrl: URL) {
		let	loadingView = makeLoadingView()

		DispatchQueue.global().async {
			let imageData = UIImage(contentsOfFile: fileUrl.path)

			DispatchQueue.main.async {
				self.image = imageData
				loadingView.removeFromSuperview()
			}
		}
	}
	
	func loadImageAsync(fromUrl url: URL) {
		let	loadingView = makeLoadingView()

		DispatchQueue.global().async {
			if let imageData = try? Data(contentsOf: url) {
				DispatchQueue.main.async {
					self.image = UIImage(data: imageData)
					loadingView.removeFromSuperview()
				}
			}
		}
	}
	
	func setImageFromBase64(dataString: String) {
		if let url = URL(string: dataString),
			let imageData = try? Data(contentsOf: url),
			let image = UIImage(data: imageData) {
			self.image = image
		}
	}
	
	private func makeLoadingView() -> UIView {
		let	loadingView = UIActivityIndicatorView(style: .gray)
		loadingView.frame = bounds
		loadingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		loadingView.startAnimating()
		self.addSubview(loadingView)
		
		return loadingView
	}

}
