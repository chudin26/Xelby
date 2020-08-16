//
//  AppInfo.swift
//  Xelby
//
//  Created by Yuriy Chudin on 17.08.2020.
//  Copyright © 2020 chood. All rights reserved.
//

import Foundation

public class AppInfo {

	public static var infoDict: [String: Any]? {
		return Bundle.main.infoDictionary
	}
	
	public static var appVersion: String {
		return infoDict?["CFBundleShortVersionString"] as? String ?? "unknown"
	}

	public static var buildVersion: String {
		return infoDict?["CFBundleVersion"] as? String ?? "unknown"
	}
	
	public static var name: String? {
		return infoDict?["CFBundleName"] as? String		
	}

}
