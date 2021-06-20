//
//  FirstScreenTMInteractor.swift
//  Ground
//
//  Created by 17790204 on 27.11.2020.
//  Copyright © 2020 Splash Fire. All rights reserved.
//

/// Интерфейс взаимодействия с интерактором экрана Profile
protocol ProfileInteractable {}

/// Интерактор экрана профиль
final class ProfileInteractor: ProfileInteractable {

	/// Сервис для работы для получения данных о продуктах
	private let service: FirstServiceProtocol

	/// Конструктор интерактора экрана новых релизов музыкальных композиций
	/// - Parameter service: серви для получения музыки
	init(service: FirstServiceProtocol) {
		self.service = service
	}

}
