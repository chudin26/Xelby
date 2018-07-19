//
//  PathMaker.swift
//  Xelby
//
//  Created by Yuriy Chudin on 16/06/2018.
//  Copyright © 2018 chood. All rights reserved.
//

import UIKit

public enum Corner {
	case leftTop
	case rightTop
	case leftBottom
	case rightBottom
	
	public static func all() -> [Corner] {
		return [.leftTop, .rightTop, .leftBottom, .rightBottom]
	}
}

public class PathMaker {
	
	public var size: CGSize
	
	public init(size: CGSize) {
		self.size = size
	}
	
	public func makePolyhedron(edges: Int) -> UIBezierPath {
		let path = UIBezierPath()
		
		let center = CGPoint(x: size.width / 2, y: size.height / 2)
		for i in 0 ... edges - 1 {
			let angle = CGFloat(i) / CGFloat(edges) * CGFloat.pi * 2
			let vec = CGVector(dx: -size.width / 2 * cos(angle), dy: size.height / 2 * sin(angle))
			
			if i == 0 {
				path.move(to: center + vec)
			} else {
				path.addLine(to: center + vec)
			}
		}
		
		path.close()
		return path
	}
	
	public func makeCutCornersRect(corners: [Corner: CGFloat], defaultCornerRadius: CGFloat! = nil) -> UIBezierPath {
		let minRadius = min(size.height / 2, size.width / 2)
		let radiuses = Corner.all().mapToDictionary {
			(key: $0, value: min(corners[$0] ?? defaultCornerRadius, minRadius))
		}
		
		let path = UIBezierPath()
		path.move(to: CGPoint(radiuses[.leftTop]!, 0))
		path.addLine(to: CGPoint(size.width - radiuses[.rightTop]!, 0))
		path.addLine(to: CGPoint(size.width, radiuses[.rightTop]!))
		path.addLine(to: CGPoint(size.width, size.height - radiuses[.rightBottom]!))
		path.addLine(to: CGPoint(size.width - radiuses[.rightBottom]!, size.height))
		path.addLine(to: CGPoint(radiuses[.leftBottom]!, size.height))
		path.addLine(to: CGPoint(0, size.height - radiuses[.leftBottom]!))
		path.addLine(to: CGPoint(0, radiuses[.leftTop]!))
		path.close()
		
		return path
	}

}
