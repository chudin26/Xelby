//
//  Validator.swift
//  Xelby
//
//  Created by Yuriy Chudin on 26.11.2019.
//  Copyright © 2019 chood. All rights reserved.
//

import Foundation

public class Validator <Value, Error> {
	
	public typealias ValidationFunc = (Value) -> [Error]?
	
	internal var validationFunc: ValidationFunc
	
	public init(_ f: @escaping ValidationFunc) {
		validationFunc = f
	}
	
	public init(_ funcs: [ValidationFunc]) {
		validationFunc = { value in
			var errors = [Error]()
			for f in funcs {
				if let errs = f(value) {
					errors.append(contentsOf: errs)
				}
			}
			
			return errors.isEmpty ? nil : errors
		}
	}
	
	public func validate(_ value: Value) -> [Error]? {
		return validationFunc(value)
	}
	
}
