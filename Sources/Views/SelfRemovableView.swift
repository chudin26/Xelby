//
//  SelfRemovableView.swift
//  Xelby
//
//  Created by Yuriy Chudin on 04.12.2019.
//  Copyright © 2019 chood. All rights reserved.
//

import UIKit

class SelfRemovableView: UIView {
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		removeFromSuperview()
	}
	
}
