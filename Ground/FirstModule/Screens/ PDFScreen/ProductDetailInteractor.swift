//
//  SecondScreenFMInteractor.swift
//  Ground
//
//  Created by Vladislav Zhokhov on 27.11.2020.
//  Copyright © 2020 Splash Fire. All rights reserved.
//

/// Интерфейс взаимодействия с интерактором экрана ProductDetailInteractor
protocol ProductDetailInteractable {}

/// Интерактор экрана детальной информации
final class ProductDetailInteractor: ProductDetailInteractable {

	/// Сервис
	private let service: SecondServiceProtocol

	/// Конструктор интерактора экрана
	/// - Parameter service: серви
	init(service: SecondServiceProtocol) {
		self.service = service
	}
}
