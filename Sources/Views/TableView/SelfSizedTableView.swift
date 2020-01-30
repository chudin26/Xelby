//
//  SelfSizedTableView.swift
//  Xelby
//
//  Created by Yuriy Chudin on 30.01.2020.
//  Copyright © 2020 chood. All rights reserved.
//

import UIKit

public class SelfSizedTableView: UITableView {

	public var maxHeight: CGFloat = UIScreen.main.bounds.size.height
	
	public override func reloadData() {
		super.reloadData()
		
		self.invalidateIntrinsicContentSize()
		self.layoutIfNeeded()
	}
	
	public override func layoutSubviews() {
		super.layoutSubviews()
		
		invalidateIntrinsicContentSize()
	}
	
	public override var intrinsicContentSize: CGSize {
		let height = min(contentSize.height, maxHeight)
		return CGSize(width: contentSize.width, height: height)
	}

}
