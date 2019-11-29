//
//  SelectableTableViewCell.swift
//  Xelby
//
//  Created by Yuriy Chudin on 29.11.2019.
//  Copyright © 2019 chood. All rights reserved.
//

import UIKit

open class SelectableTableViewCell: UITableViewCell {
	
	@IBOutlet public var selectedView: UIView?
	@IBOutlet public var highlightedView: UIView?
	
	override open func setSelected(_ selected: Bool, animated: Bool) {
		selectedView?.fade(!selected, duration: animated ? (selected ? 0.3 : 0.05) : 0)
	}
	
	override open func setHighlighted(_ highlighted: Bool, animated: Bool) {
		highlightedView?.fade(!highlighted, duration: animated ? (highlighted ? 0.05 : 0.3) : 0)
	}
	
}
