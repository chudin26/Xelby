//
//  DIContainer.swift
//  Xelby
//
//  Created by Yuriy Chudin on 13/09/2019.
//  Copyright © 2019 chood. All rights reserved.
//

import Foundation

open class DIContainer {
	
	public struct Options: OptionSet, Hashable {
		public let rawValue: Int
		
		public init(rawValue: Int) {
			self.rawValue = rawValue
		}
		
		public static let singleton = Options(rawValue: 1 << 0)
	}
	
	private struct ServiceKey: Hashable {
		
		let serviceType: Any.Type
		let name: String?
		let options: Options
		let typeChecker: (Any) -> Bool
		
		internal init <Service> (serviceType: Service.Type, name: String? = nil, options: Options = []) {
			self.serviceType = serviceType
			self.name = name
			self.options = options
			self.typeChecker = { value in return value is Service }
		}
		
		func isConformsTo(value: Any) -> Bool {
			return typeChecker(value)
		}

		public func hash(into hasher: inout Hasher) {
			hasher.combine(ObjectIdentifier(serviceType))
			hasher.combine(name?.hashValue ?? 0)
		}

		static func == (lhs: DIContainer.ServiceKey, rhs: DIContainer.ServiceKey) -> Bool {
			return lhs.serviceType == rhs.serviceType && lhs.name == rhs.name
		}

	}
	
	typealias Factory = (DIContainer) -> Any
	typealias Setter = (DIContainer, Any) -> ()
	
	private var singletons: [ServiceKey: Any] = [:]
	private var factories: [ServiceKey: Factory] = [:]
	private var setters: [ServiceKey: Setter] = [:]
	
	public init() {
		
	}
	
	public func register <Service> (_ service: Service.Type, options: Options = [], factory: @escaping (DIContainer) -> Service) {
		let serviceKey = ServiceKey(serviceType: service, options: options)
		factories[serviceKey] = factory
	}

	public func register <Service> (_ service: Service.Type, setter: @escaping (DIContainer, Service) -> ()) {
		let serviceKey = ServiceKey(serviceType: service)
		setters[serviceKey] = { container, value in setter(container, value as! Service) }
	}

	public func resolve <Service> (_ service: Service.Type) -> Service? {
		let serviceKey = ServiceKey(serviceType: service)
		let factory = factories[serviceKey]
		
		if let service = singletons[serviceKey] as? Service {
			return service
		}
		
		if let service = factory?(self) as? Service {
			if serviceKey.options.contains(.singleton) {
				singletons[serviceKey] = service
			}

			return setup(service)
		}
		
		return nil
	}
	
	@discardableResult
	public func setup <Service> (_ service: Service) -> Service {
		for (key, setter) in setters where key.isConformsTo(value: service) {
			setter(self, service)
		}
		
		return service
	}
	
}
