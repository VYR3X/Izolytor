//
//  SecondScreenSMInteractor.swift
//  Ground
//
//  Created by 17790204 on 27.11.2020.
//  Copyright © 2020 Splash Fire. All rights reserved.
//

/// Интерфейс взаимодействия с интерактором экрана SecondScreenSM во флоу GG.
protocol SecondScreenSMInteractable {}

final class SecondScreenSMInteractor: SecondScreenSMInteractable {

 /// Сервис для работы c музыкальными композициями
	private let service: SecondServiceProtocol

	/// Конструктор интерактора экрана новых релизов музыкальных композиций
	/// - Parameter service: серви для получения музыки
	init(service: SecondServiceProtocol) {
		self.service = service
	}

}
