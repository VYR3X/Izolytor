//
//  SecondScreenFMInteractor.swift
//  Ground
//
//  Created by 17790204 on 27.11.2020.
//  Copyright © 2020 Splash Fire. All rights reserved.
//

/// Интерфейс взаимодействия с интерактором экрана SecondScreenFM во флоу Ground.
protocol SecondScreenFMInteractable {}

final class SecondScreenFMInteractor: SecondScreenFMInteractable {

    /// Сервис
	   private let service: SecondServiceProtocol

	   /// Конструктор интерактора экрана
	   /// - Parameter service: серви
	   init(service: SecondServiceProtocol) {
		   self.service = service
	   }

}
