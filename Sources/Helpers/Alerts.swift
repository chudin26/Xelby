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

}
