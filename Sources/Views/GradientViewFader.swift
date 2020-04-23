//
//  GradientViewFader.swift
//

import UIKit

public class GradientViewFader: UIView {
	
	public enum Direction: Int {
		case up = 1
		case down = 2
	}

	public var direction: Direction = .down
	
	@IBOutlet public var targetView: UIView!
	@IBInspectable public var ibDirection: Int {
		get { return direction.rawValue }
		set { direction = Direction(rawValue: newValue)! }
	}
	
	@IBInspectable public var fadeOpacity: CGFloat = 0
	
	private var gradientLayer: CAGradientLayer!
	
	public override func awakeFromNib() {
		super.awakeFromNib()
		
		let colors = [UIColor.black, UIColor(white: 0, alpha: fadeOpacity)].map { $0.cgColor }
		gradientLayer = CAGradientLayer()
		gradientLayer.colors = direction == .down ? colors : colors.reversed()
		
		targetView.layer.mask = gradientLayer
		
		targetView.addObserver(self, forKeyPath: #keyPath(UIView.bounds), options: .new, context: nil)
		if targetView is UIScrollView {
			targetView.addObserver(self, forKeyPath: #keyPath(UIScrollView.contentSize), options: .new, context: nil)
		}
	}
	
	deinit {
		targetView.removeObserver(self, forKeyPath: #keyPath(UIView.bounds))
		if targetView is UIScrollView {
			targetView.removeObserver(self, forKeyPath: #keyPath(UIScrollView.contentSize))
		}
	}
	
	public override func layoutSubviews() {
		super.layoutSubviews()
		
		recalculate()
	}
	
	private func recalculate() {
		CATransaction.begin()
		CATransaction.setDisableActions(true)
		
		let targetBounds: CGRect
		if let scrollView = targetView as? UIScrollView {
			targetBounds = .init(origin: .zero, size: scrollView.contentSize)
		} else {
			targetBounds = targetView.bounds
		}
		
		let gradientFrame = targetView.convert(bounds, from: self)
		let p1 = Float(gradientFrame.minY / targetBounds.height)
		let p2 = Float(gradientFrame.maxY / targetBounds.height)
		gradientLayer.locations = [NSNumber(value: p1), NSNumber(value: p2)]
		gradientLayer.frame = targetBounds
		
		CATransaction.commit()
	}
	
	public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
		if keyPath == #keyPath(UIView.bounds) || keyPath == #keyPath(UIScrollView.contentSize) {
			recalculate()
		}
	}

}
