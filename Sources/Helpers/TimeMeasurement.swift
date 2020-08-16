//
//  TimeMeasurement.swift
//  Xelby
//
//  Created by Yuriy Chudin on 13/07/2018.
//  Copyright © 2018 chood. All rights reserved.
//

public final class TimeMeasurement {
	
	@discardableResult
	public static func measure(entityName: String, block: () -> ()) -> TimeInterval {
		let startDate = Date()
		block()
		let interval = Date().timeIntervalSince(startDate)
		Logger.debug("TimeMeasurement: \(entityName) operation takes \(interval) time")
		
		return interval
	}

}
