//
//  AttributedLabel.swift
//  Xelby
//
//  Created by Yuriy Chudin on 26.11.2019.
//  Copyright © 2019 chood. All rights reserved.
//

import UIKit

@IBDesignable
public class AttributedLabel: UILabel {
	
	@IBInspectable public var spacing: CGFloat = 0
	@IBInspectable public var underline: Bool = false
	
	public override var text: String? {
		didSet {
			setup()
		}
	}
	
	private func setup() {
		guard let text = text else { return }
		
		let attributedString = NSMutableAttributedString(string: text)
		let range = NSMakeRange(0, text.count)
		
		if spacing > 0 {
			attributedString.addAttribute(.kern, value: spacing, range: range)
		}
		
		if underline {
			attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single, range: range)
		}
		
		attributedText = attributedString
	}
	
	public override func prepareForInterfaceBuilder() {
		setup()
	}
	
	public override func awakeFromNib() {
		super.awakeFromNib()
		setup()
	}
	
}
