//
//  UIViewLayout.swift
//  Xelby
//
//  Created by Yuriy Chudin on 24/07/2018.
//  Copyright © 2018 chood. All rights reserved.
//

import UIKit

public extension UIView {
	
	@discardableResult
	func addConstraint(toView: UIView, attribute: NSLayoutConstraint.Attribute, constant: CGFloat, multiplier: CGFloat = 1) -> NSLayoutConstraint {
		let constraint: NSLayoutConstraint
		if attribute == .width || attribute == .height {
			constraint = NSLayoutConstraint(item: toView, attribute: attribute, relatedBy: .equal, toItem: nil, attribute: attribute, multiplier: multiplier, constant: constant)
		} else {
			var constant = constant
			if [.trailing, .bottom, .right].contains(attribute) {
				constant = -constant
			}
			
			constraint = NSLayoutConstraint(item: toView, attribute: attribute, relatedBy: .equal, toItem: self, attribute: attribute, multiplier: multiplier, constant: constant)
		}
		
		constraint.isActive = true
		addConstraint(constraint)
		
		return constraint
	}
	
	@discardableResult
	func addConstraint(attribute: NSLayoutConstraint.Attribute, constant: CGFloat, multiplier: CGFloat = 1) -> NSLayoutConstraint {
		precondition(attribute == .width || attribute == .height, "Attribute must be NSLayoutAttributeWidth or NSLayoutAttributeHeight")
		
		let constraint = NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .equal, toItem: nil, attribute: attribute, multiplier: multiplier, constant: constant)
		addConstraint(constraint)
		
		return constraint
	}

	@discardableResult
	func addConstraint(attribute: NSLayoutConstraint.Attribute, view1: UIView, view2: UIView, constant: CGFloat, multiplier: CGFloat = 1) -> NSLayoutConstraint {
		let constraint = NSLayoutConstraint(item: view1, attribute: attribute, relatedBy: .equal, toItem: view2, attribute: attribute, multiplier: multiplier, constant: constant)
		addConstraint(constraint)
		
		return constraint
	}

	func addConstraints(attributes: [NSLayoutConstraint.Attribute], betweenView view1: UIView, andView view2: UIView, constant: CGFloat, multiplier: CGFloat = 1) {
		for attr in attributes {
			addConstraint(NSLayoutConstraint(item: view1, attribute: attr, relatedBy: .equal, toItem: view2, attribute: attr, multiplier: multiplier, constant: constant))
		}
	}

	func addConstraints(attributes: [NSLayoutConstraint.Attribute: CGFloat], betweenView view1: UIView, andView view2: UIView) {
		for attr in attributes {
			addConstraint(NSLayoutConstraint(item: view1, attribute: attr.key, relatedBy: .equal, toItem: view2, attribute: attr.key, multiplier: 1, constant: attr.value))
		}
	}

	func addConstraints(toView view: UIView, attributes: [NSLayoutConstraint.Attribute: CGFloat]) {
		for attr in attributes {
			if attr.key == .width || attr.key == .height {
				view.addConstraint(attribute: attr.key, constant: attr.value)
			} else {
				addConstraint(toView: view, attribute: attr.key, constant: attr.value)
			}
		}
	}
	
	@discardableResult
	func addSpacingConstraints(betweenViews views: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat = 0) -> [NSLayoutConstraint] {
        let firstAttribute: NSLayoutConstraint.Attribute = axis == .horizontal ? .trailing : .bottom
        let secondAttribute: NSLayoutConstraint.Attribute = axis == .horizontal ? .leading : .top
		
		var constraints = [NSLayoutConstraint]()
		for i in 0 ..< views.count - 1 {
			let constraint = NSLayoutConstraint(item: views[i + 1], attribute: secondAttribute, relatedBy: .equal, toItem: views[i], attribute: firstAttribute, multiplier: 1, constant: spacing)
			constraints.append(constraint)
		}
		
		addConstraints(constraints)
		return constraints
	}
	
	func addSubview(_ view: UIView, autoLayoutMargin margin: CGFloat) {
		addSubview(view, autoLayoutEdgeMargin: UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin))
	}
	
	func addSubview(_ view: UIView, autoLayoutEdgeMargin margin: UIEdgeInsets) {
		addSubview(view, attributes: [.leading: margin.left,
		                              .trailing: margin.right,
		                              .top: margin.top,
		                              .bottom: margin.bottom])
	}
	
	func addSubview(_ view: UIView, attributes: [NSLayoutConstraint.Attribute]) {
		view.translatesAutoresizingMaskIntoConstraints = false
		
		addSubview(view)
		attributes.forEach { addConstraint(toView: view, attribute: $0, constant: 0) }
	}

	func addSubview(_ view: UIView, attributes: [NSLayoutConstraint.Attribute: CGFloat]) {
		if subviews.contains(view) {
			return
		}
		
		view.translatesAutoresizingMaskIntoConstraints = false
		
		addSubview(view)
		addConstraints(toView: view, attributes: attributes)
	}
	
}
