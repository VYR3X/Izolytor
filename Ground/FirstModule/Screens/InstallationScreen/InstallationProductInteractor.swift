//
//  YouTubeInteractor.swift
//  Izolyator
//
//  Created by Vladislav Zhokhov on 21.01.2021.
//  Copyright © 2021 Splash Fire. All rights reserved.
//

// Интерфейс взаимодействия с интерактором экрана InstallationProduct
protocol InstallationProductInteractable {}

final class InstallationProductInteractor: InstallationProductInteractable {

	/// Сервис
	private let service: FirstServiceProtocol

	/// Конструктор интерактора
	/// - Parameter service: серви
	init(service: FirstServiceProtocol) {
		self.service = service
	}
}
