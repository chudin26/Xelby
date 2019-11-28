//
//  StringValidators.swift
//  Xelby
//
//  Created by Yuriy Chudin on 27.11.2019.
//  Copyright © 2019 chood. All rights reserved.
//

import Foundation

public class StringValidators {
	
	public static let notEmpty = Validator { (string: String) in
		return !string.isEmpty ? nil : ["Should not be empty"]
	}
	
	public static let email = Validator(
		[StringValidators.notEmpty.validationFunc,
		 { (string: String) in
			let emailRegex = "^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$"
			let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
			return emailTest.evaluate(with: string) ? nil : ["Should be an email"]
	}])
	
	public static let weakPassword = Validator { (string: String) in
		return string.count >= 3 ? nil : ["Password should contain at least 3 characters"]
	}
	
}
