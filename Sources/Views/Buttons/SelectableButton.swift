//
//  SelectableButton.swift
//

import UIKit

@IBDesignable
public class SelectableButton: UIButton {

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
		self.layer.masksToBounds = true
		
		return l
	}()
	
	override public var isHighlighted: Bool {
		get { return super.isHighlighted }
		set { setPressState(state: newValue) }
	}
	
	override public var isSelected: Bool {
		get { return super.isSelected }
		set {
			super.isSelected = newValue
			
			if selectedBackgroundColor != nil {
				backgroundColor = newValue ? selectedBackgroundColor : defaultBackgroundColor
			}
		}
	}
	
	override public func layoutSubviews() {
		super.layoutSubviews()
		
		darkeningLayer.frame = bounds
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
