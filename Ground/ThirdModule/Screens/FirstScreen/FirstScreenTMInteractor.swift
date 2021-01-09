//
//  FirstScreenTMInteractor.swift
//  Ground
//
//  Created by 17790204 on 27.11.2020.
//  Copyright © 2020 Splash Fire. All rights reserved.
//

/// Интерфейс взаимодействия с интерактором экрана FirstScreenTM во флоу GG.
protocol FirstScreenTMInteractable {}

final class FirstScreenTMInteractor: FirstScreenTMInteractable {

	/// Сервис для работы c музыкальными композициями
	private let service: FirstServiceProtocol

	/// Конструктор интерактора экрана новых релизов музыкальных композиций
	/// - Parameter service: серви для получения музыки
	init(service: FirstServiceProtocol) {
		self.service = service
	}

}
