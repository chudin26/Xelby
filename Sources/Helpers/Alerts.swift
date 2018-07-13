//
//  Alerts.swift
//  Metal
//
//  Created by Yuriy Chudin on 29.10.16.
//  Copyright © 2016 Yuriy Chudin. All rights reserved.
//

import UIKit

public class Alerts {
	
	static public func showError(message: String) {
		let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
		let cancel = UIAlertAction(title: "OK", style: .cancel)
		alert.addAction(cancel)
		
		let rootVC = UIApplication.shared.keyWindow?.rootViewController
		rootVC?.present(alert, animated: true, completion: nil)
	}

}
