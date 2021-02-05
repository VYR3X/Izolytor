//
//  CatalogModel.swift
//  Izolyator
//
//  Created by Vladislav Zhokhov on 29.01.2021.
//  Copyright © 2021 Splash Fire. All rights reserved.
//

/// Модель для отображения на экране ( поиска / каталога )
struct CatalogModel {

	/// Типы высоковольтного ввода
	enum BushingType: String {
		case transformer = "ВВ для силовых трансформаторов и шунтирующих реакторов"
		case oilSwitch = "ВВ для маслянных выключателей"
		case linear = "Линейные ВВ"
		case cableConnection = "ВВ для КРУЭ и кабельного подключения трансформаторов"
	}

	/// Модель ввода
	struct HighVoltageBushingModel {
		// Тип ввода
		let type: BushingType //.transformer
		// Класс напряжения
		let voltageClassModels: [VoltageСlassModel]
	}
}

/// Класс напряжения
struct VoltageСlassModel {
	// Напряжение: 12 киловольт
	let voltageName: String // может сделать структуры с конкретными занчениями ?
	// Cписок вводов соотвествующих своему классу напряжения
	let bushingModels: [FullBushingInfoModel]
}

/// Модель высоковольтного ввода для экрана поиска
struct FullBushingInfoModel {
	// Наименование ввода: TCNSIV-90-12/1000 (0)
	let bushingName: String
	// Маркировка: 686381.279
	let drawing: String
	// Упаковка
//	let packaging: Packaging
	// масса
//	let weight: Weight
}

/// Упаковка
struct Packaging {
	// Материал упаковки
	let material: String
	// Габаритные размеры
	let dimensions: Dimension

	/// Габаритные размеры (Д*Ш*В)
	struct Dimension {
		/// Длина ввода
		let length: Int
		/// Ширина ввода
		let width: Int
		/// Высота ввода
		let height: Int
	}
}

// Масса ввода ( нетто / брутто )
struct Weight {
	// масса брутто
	let grossWeight: Float
	// масса нетто
	let netWeight: Float
}
