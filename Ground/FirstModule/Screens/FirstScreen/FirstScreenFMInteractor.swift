//
//  FirstScreenFMInteractor.swift
//  Ground
//
//  Created by 17790204 on 27.11.2020.
//  Copyright © 2020 Splash Fire. All rights reserved.
//

/// Интерфейс взаимодействия с интерактором экрана FirstScreenFM во флоу Ground.
protocol FirstScreenFMInteractable {}

final class FirstScreenFMInteractor: FirstScreenFMInteractable {

    /// Сервис
	private let service: FirstServiceProtocol

    /// Конструктор интерактора
	/// - Parameter service: серви
	init(service: FirstServiceProtocol) {
		self.service = service
	}

}
