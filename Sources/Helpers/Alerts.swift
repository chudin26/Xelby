//
//  Alerts.swift
//  Xelby
//
//  Created by Yuriy Chudin on 29.10.17.
//  Copyright © 2018 Yuriy Chudin. All rights reserved.
//

import UIKit

public class Alerts {
	
	static public func showError(message: String) {
		let alert = UIAlertController(title: "Error".localized, message: message, preferredStyle: .alert)
		let cancel = UIAlertAction(title: "OK".localized, style: .cancel)
		alert.addAction(cancel)
		
		let rootVC = UIApplication.shared.keyWindow?.rootViewController
		rootVC?.present(alert, animated: true, completion: nil)
	}

	static public func showMessage(_ message: String, title: String, onVC vc: UIViewController, commitString: String = "OK", handler: ((UIAlertAction) -> Void)? = nil) {
		let alert = UIAlertController(title: title.localized, message: message, preferredStyle: .alert)
		let cancel = UIAlertAction(title: commitString.localized, style: .cancel, handler: handler)
		alert.addAction(cancel)
		
		vc.present(alert, animated: true, completion: nil)
	}

}
