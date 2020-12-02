//
//  PathView.swift
//  Xelby
//
//  Created by Yuriy Chudin on 01.12.2020.
//  Copyright © 2020 chood. All rights reserved.
//

import UIKit

@IBDesignable
public class PathView: UIView {
	
	// Points where (0, 0) is top left corner and (1, 1) is bottom right
	// Example format: 0.4, 0.5; 0.1, 0.2; 0.7, 0.22;
	@IBInspectable public var pointString: String = "" { didSet { update() } }
	
	@IBInspectable public var strokeColor: UIColor? = .black { didSet { update() } }
	@IBInspectable public var fillColor: UIColor? = .white { didSet { update() } }
	@IBInspectable public var lineWidth: CGFloat = 1 { didSet { update() } }
	
	private var shapeLayer: CAShapeLayer {
		get { return layer as! CAShapeLayer }
	}
	
	override public class var layerClass: AnyClass {
		get {
			return CAShapeLayer.self
		}
	}
	
	override public func layoutSubviews() {
		super.layoutSubviews()
		
		update()
	}
	
	private func update() {
		let points = pointString.split(separator: ";")
			.map { $0.trimmingCharacters(in: .whitespaces) }
			.compactMap { (str: String) -> CGPoint? in
				if let values = try? NumberParser().parse(from: str).map({ CGFloat($0) }), values.count == 2 {
					return CGPoint(values[0], values[1])
				} else {
					return nil
				}
			}
			.map { CGPoint(bounds.width * $0.x, bounds.height * $0.y) }

		guard points.count > 1 else { return }
		
		let path = UIBezierPath()
		path.move(to: points.first!)
		for i in 1 ..< points.count {
			path.addLine(to: points[i])
		}
		path.close()
				
		shapeLayer.path = path.cgPath
		shapeLayer.lineWidth = lineWidth
		shapeLayer.fillColor = fillColor?.cgColor
		shapeLayer.strokeColor = strokeColor?.cgColor
	}
	
}
