//
//  FirstService.swift
//  Ground
//
//  Created by 17790204 on 27.11.2020.
//  Copyright © 2020 Splash Fire. All rights reserved.
//

import Foundation

/// Интерфейс взаимодействия с интерактором экрана списка c песен в альбоме
protocol FirstServiceProtocol {

	func getProductType(completion: @escaping (Result<[ProductServiceModel.MainScreenProductModel], Error>) -> Void)
}

/// Интерактор списка песен музыкального альбома
class FirstService: FirstServiceProtocol {

	/// тут весь массив данных сформируем и вернем
	func getProductType(completion: @escaping (Result<[ProductServiceModel.MainScreenProductModel], Error>) -> Void) {
		let product = [ProductServiceModel.MainScreenProductModel(gifName: "asd",
																 typeName: "Трансформаторные вводы",
																 models: [DescriptionProductModel(productName: "ГКТIII-171",
																								  model3DName: "3d model 171",
																				 schemeName: "модель 1"),
																		  DescriptionProductModel(productName: "ГКТIII-171-01",
																								  model3DName: "3d model 171",
																				 schemeName: "модель 2")],
																 typeInfo: "Высоковольтный ввод – один из важнейших элементов в контуре «электростанция – линия электропередачи – трансформаторная подстанция». От качества ввода, его эксплуатационных свойств зависит работоспособность всей энергетической системы и стабильное обеспечение потребителей электроэнергией.",
																 modelSectionCollapsed: true),
					   ProductServiceModel.MainScreenProductModel(gifName: "asd",
																 typeName: "Маслянные выключатели",
																 models: [DescriptionProductModel(productName: "ГКТIII-181",
																								  model3DName: "3d model 181",
																				 schemeName: "модель 1"),
																		  DescriptionProductModel(productName: "ГКТIII-181-01",
																								  model3DName: "3d model 181",
																				 schemeName: "модель 2"),
																		  DescriptionProductModel(productName: "ГКТIII-181-02",
																								  model3DName: "3d model 151",
																				 schemeName: "модель 3"),
																		  DescriptionProductModel(productName: "ГКТIII-181-03",
																								  model3DName: "3d model 151",
																				 schemeName: "модель 4")],
																 typeInfo: "Это маслянные выключатели",
																 modelSectionCollapsed: true),
					   ProductServiceModel.MainScreenProductModel(gifName: "asd",
																 typeName: "Линейные",
																 models: [DescriptionProductModel(productName: "ГКТIII-191",
																								  model3DName: "3d model 191",
																				 schemeName: "модель 1"),
																		  DescriptionProductModel(productName: "ГКТIII-191-01",
																								  model3DName: "3d model 191",
																				 schemeName: "модель 2")],
																 typeInfo: "Это линейный тип",
																 modelSectionCollapsed: true),
					   ProductServiceModel.MainScreenProductModel(gifName: "asd",
																 typeName: "Кабельное подключение",
																 models: [DescriptionProductModel(productName: "ГКТIII-151",
																								  model3DName: "3d model 151",
																				 schemeName: "модель 1"),
																		  DescriptionProductModel(productName: "ГКТIII-151-01",
																								  model3DName: "3d model 151",
																				 schemeName: "модель 2"),
																		  DescriptionProductModel(productName: "ГКТIII-151-01",
																								  model3DName: "3d model 151",
																				 schemeName: "модель 3"),
																		  DescriptionProductModel(productName: "ГКТIII-151-01",
																								  model3DName: "3d model 151",
																				 schemeName: "модель 4")],
																 typeInfo: "Это кабельное подключение",
																 modelSectionCollapsed: true)]
		completion(.success(product))
	}

}

