//
//  SelectableButton.swift
//  Xelby
//
//  Created by Yuriy Chudin on 12/07/2018.
//  Copyright © 2018 chood. All rights reserved.
//

import UIKit

@IBDesignable
open class SelectableButton: UIButton {

	@IBInspectable public var borderColor: UIColor? {
		didSet {
			layer.borderColor = borderColor?.cgColor
		}
	}
	
	@IBInspectable public var borderWidth: CGFloat {
		get { return layer.borderWidth }
		set { layer.borderWidth = newValue }
	}
    
    @IBInspectable public var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
	
	public var defaultBackgroundColor: UIColor?
	@IBInspectable public var selectedBackgroundColor: UIColor? {
		didSet {
			defaultBackgroundColor = backgroundColor
		}
	}
	
    @IBInspectable public var useDarkeningLayer: Bool = true
	private lazy var darkeningLayer: CALayer = { [unowned self] in
		var l = CALayer()
		l.backgroundColor = UIColor(white: 0.0, alpha: 0.3).cgColor
		l.opacity = 0.0
		self.layer.addSublayer(l)
		
		return l
	}()
	
	override open var isHighlighted: Bool {
		get { return super.isHighlighted }
		set { setPressState(state: newValue) }
	}
	
	override open var isSelected: Bool {
		get { return super.isSelected }
		set {
			super.isSelected = newValue
			
			if selectedBackgroundColor != nil {
				backgroundColor = newValue ? selectedBackgroundColor : defaultBackgroundColor
			}
		}
	}
	
	override open func layoutSubviews() {
		super.layoutSubviews()
		
		darkeningLayer.frame = bounds
		darkeningLayer.cornerRadius = cornerRadius
	}
	
	private func setPressState(state: Bool) {
        guard self.useDarkeningLayer else {
            return
        }
		        
		CATransaction.begin()
		CATransaction.setAnimationDuration(state ? 0.05 : 0.25)
		
		darkeningLayer.opacity = state ? 1.0 : 0.0
		
		CATransaction.commit()
	}

}
