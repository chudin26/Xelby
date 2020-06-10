//
//  DateConverter.swift
//  Xelby
//
//  Created by Yuriy Chudin on 11.06.2020.
//  Copyright © 2020 chood. All rights reserved.
//

import Foundation

public class DateConverter {

	public static func convertISO8601(string: String) -> Date? {
		if #available(iOS 10.0, *) {
			return ISO8601DateFormatter().date(from: string)
		} else {
			let dateFormatter = DateFormatter()
			dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
			dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
			return dateFormatter.date(from: string)
		}
	}

}
