//
//  AttributedLabel.swift
//  Xelby
//
//  Created by Yuriy Chudin on 26.11.2019.
//  Copyright © 2019 chood. All rights reserved.
//

import UIKit

@IBDesignable
public class AttributedButton: UIButton {
	
	@IBInspectable public var spacing: CGFloat = 0
		
	private func setup() {
		guard let text = title(for: .normal) else { return }
		
		let attributedString = NSMutableAttributedString(string: text)
		attributedString.addAttribute(.kern, value: spacing, range: NSMakeRange(0, text.count))
		
		titleLabel?.attributedText = attributedString
	}
	
	public override func prepareForInterfaceBuilder() {
		setup()
	}
	
	public override func awakeFromNib() {
		super.awakeFromNib()
		setup()
	}
	
}
