//
//  PathMaker.swift
//  Xelby
//
//  Created by Yuriy Chudin on 16/06/2018.
//  Copyright © 2018 chood. All rights reserved.
//

import UIKit

public class PathMaker {
	
	private init() {}
	
	public static func makePolyhedron(edges: Int, size: CGSize) -> UIBezierPath {
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

}
