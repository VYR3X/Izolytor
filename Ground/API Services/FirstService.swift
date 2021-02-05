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

	func getProductType(completion: @escaping (Result<[ProductServiceModel.MainScreenProductType], Error>) -> Void)
}

/// Интерактор списка песен музыкального альбома
class FirstService: FirstServiceProtocol {

	/// тут весь массив данных сформируем и вернем
	func getProductType(completion: @escaping (Result<[ProductServiceModel.MainScreenProductType], Error>) -> Void) {
		let product = [ProductServiceModel.MainScreenProductType(git: "asd",
																 typeName: "Трансформаторные вводы",
																 models: [VModel(name: "ГКТIII-171",
																				 object: "3d model 171",
																				 chertezh: "модель 1"),
																		  VModel(name: "ГКТIII-171-01",
																				 object: "3d model 171",
																				 chertezh: "модель 2")],
																 typeInfo: "Высоковольтный ввод – один из важнейших элементов в контуре «электростанция – линия электропередачи – трансформаторная подстанция». От качества ввода, его эксплуатационных свойств зависит работоспособность всей энергетической системы и стабильное обеспечение потребителей электроэнергией.",
																 modelSectionCollapsed: true),
					   ProductServiceModel.MainScreenProductType(git: "asd",
																 typeName: "Маслянные выключатели",
																 models: [VModel(name: "ГКТIII-181",
																				 object: "3d model 181",
																				 chertezh: "модель 1"),
																		  VModel(name: "ГКТIII-181-01",
																				 object: "3d model 181",
																				 chertezh: "модель 2"),
																		  VModel(name: "ГКТIII-181-02",
																				 object: "3d model 151",
																				 chertezh: "модель 3"),
																		  VModel(name: "ГКТIII-181-03",
																				 object: "3d model 151",
																				 chertezh: "модель 4")],
																 typeInfo: "как круто что это маслянные выключатели",
																 modelSectionCollapsed: true),
					   ProductServiceModel.MainScreenProductType(git: "asd",
																 typeName: "Линейные",
																 models: [VModel(name: "ГКТIII-191",
																				 object: "3d model 191",
																				 chertezh: "модель 1"),
																		  VModel(name: "ГКТIII-191-01",
																				 object: "3d model 191",
																				 chertezh: "модель 2")],
																 typeInfo: "как круто что это линейный тип",
																 modelSectionCollapsed: true),
					   ProductServiceModel.MainScreenProductType(git: "asd",
																 typeName: "Кабельное подулючение",
																 models: [VModel(name: "ГКТIII-151",
																				 object: "3d model 151",
																				 chertezh: "модель 1"),
																		  VModel(name: "ГКТIII-151-01",
																				 object: "3d model 151",
																				 chertezh: "модель 2"),
																		  VModel(name: "ГКТIII-151-01",
																				 object: "3d model 151",
																				 chertezh: "модель 3"),
																		  VModel(name: "ГКТIII-151-01",
																				 object: "3d model 151",
																				 chertezh: "модель 4")],
																 typeInfo: "как круто что это кабельное подулючение",
																 modelSectionCollapsed: true)]
		completion(.success(product))
	}

}

