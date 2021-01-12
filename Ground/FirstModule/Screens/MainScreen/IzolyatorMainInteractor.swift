//
//  FirstScreenFMInteractor.swift
//  Ground
//
//  Created by Vladislav Zhokhov on 27.11.2020.
//  Copyright © 2020 Splash Fire. All rights reserved.
//

/// Интерфейс взаимодействия с интерактором экрана IzolyatorMainViewController
protocol IzolyatorMainInteractable {}

final class IzolyatorMainInteractor: IzolyatorMainInteractable {

    /// Сервис
	private let service: FirstServiceProtocol

    /// Конструктор интерактора
	/// - Parameter service: серви
	init(service: FirstServiceProtocol) {
		self.service = service
	}
}
