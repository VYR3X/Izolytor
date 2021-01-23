//
//  FirstScreenFMInteractor.swift
//  Ground
//
//  Created by Vladislav Zhokhov on 27.11.2020.
//  Copyright © 2020 Splash Fire. All rights reserved.
//

/// Интерфейс взаимодействия с интерактором экрана IzolyatorMainViewController
protocol IzolyatorMainInteractable {
	func getDataSource(completion: @escaping (Result<[ProductServiceModel.MainScreenProductType], Error>) -> Void)
}

final class IzolyatorMainInteractor: IzolyatorMainInteractable {

    /// Сервис
	private let service: FirstServiceProtocol

    /// Конструктор интерактора
	/// - Parameter service: серви
	init(service: FirstServiceProtocol) {
		self.service = service
	}

	func getDataSource(completion: @escaping (Result<[ProductServiceModel.MainScreenProductType], Error>) -> Void) {
//		service.getRequest { productsModelResult in
//			switch productsModelResult {
//			case let .success(productsModel):
//				completion(.success(productsModelResult))
////				self?.productsModel = productsModel
////				completion(.success(productsModel))
//			case let .failure(error):
//				completion(.failure(error))
//			}
//		}
		service.getProductType { productsModelResult in
			switch productsModelResult {
			case let .success(productsModel):
				completion(.success(productsModel))
			case let .failure(error):
				completion(.failure(error))
			}
		}
	}
}
