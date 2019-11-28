//
//  ValidationTextField.swift
//  Xelby
//
//  Created by Yuriy Chudin on 27.11.2019.
//  Copyright © 2019 chood. All rights reserved.
//

import UIKit

@IBDesignable
open class ValidationTextField: UITextField, UITextFieldDelegate {
	
	@IBInspectable public var bottomLineColor: UIColor? {
		didSet {
			if let color = bottomLineColor {
				bottomLine?.backgroundColor = color
			}
		}
	}
	
	public var validator: Validator <String, String>?
	
	public var onValid: ((/* errors: */[String]?) -> ())?
	public var onReturn: ((ValidationTextField) -> ())?
	
	public var isValid: Bool {
		return validator?.validate(text ?? "") == nil
	}
	
	private var bottomLine: UIView!
				
	override public func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
		setup()
	}
	
	open override func awakeFromNib() {
		super.awakeFromNib()
		setup()
	}
	
	private func setup() {
		delegate = self
		
//		addTarget(self, action: #selector(onTextChanged(_:)), for: .editingChanged)
		
		guard let color = bottomLineColor else { return }
		
		if bottomLine == nil {
			bottomLine = UIView()
			bottomLine.translatesAutoresizingMaskIntoConstraints = false
			bottomLine.addConstraint(attribute: .height, constant: 1)
			addSubview(bottomLine, attributes: [.bottom, .leading, .trailing])
		}

		bottomLine.backgroundColor = color
	}
	
//	@objc private func onTextChanged(_ textField: UITextField) {
//		let errors = validator?.validate(textField.text ?? "")
//		onValid?(errors)
//	}
	
	public func textFieldDidBeginEditing(_ textField: UITextField) {
		onValid?(nil)
	}

	public func textFieldDidEndEditing(_ textField: UITextField) {
		let errors = validator?.validate(textField.text ?? "")
		onValid?(errors)
	}
	
	public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		onReturn?(self)
		return true
	}
	
}
