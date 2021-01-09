//
//  ServiceAssembly.swift
//  Ground
//
//  Created by 17790204 on 27.11.2020.
//  Copyright © 2020 Splash Fire. All rights reserved.
//

import Foundation

/// Сборщик сервисов ( названия пока для примера )
class ServiceAssembly {

	/// Создает сервис для работы с первым сервисом
	func makeFirstService() -> FirstServiceProtocol {
		return FirstService()
	}

	/// Создает сервис для работы со вторым сервисом
	func makeSecondService() -> SecondServiceProtocol {
		return SecondService()
	}
}
