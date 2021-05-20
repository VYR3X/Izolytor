//
//  ExamleData.swift
//  Izolyator
//
//  Created by 17790204 on 17.01.2021.
//  Copyright © 2021 Splash Fire. All rights reserved.
//

import Foundation
import PDFKit
//
// MARK: - Section Data Structure
//
public struct Item {
	var name: String
	var detail: String

	public init(name: String, detail: String) {
		self.name = name
		self.detail = detail
	}
}

public struct Section {
	var name: String
	var items: [Item]
	var collapsed: Bool

	public init(name: String, items: [Item], collapsed: Bool = true) {
		self.name = name
		self.items = items
		self.collapsed = collapsed
	}
}

public var sectionsData: [Section] = [
	Section(name: "Видео материала", items: []),
	Section(name: "Модели и чертежи", items: [
		Item(name: "171", detail: "чертеж данной модели"),
		Item(name: "171.01", detail: "чертеж данной модели")
	]),
	Section(name: "Руководство по эксплуатации", items: [
		Item(name: "Трансформаторные вводы", detail: "детальное руководство по эксплуатации")
	]),
	Section(name: "AR объект", items: [
		Item(name: "AR object", detail: "отображение 3d модели ввода в AR")
	])
]

var mainScreenDataSource: [ProductServiceModel] = []

/// Перечень типо вводов
enum ProductEnum {
	/// Трансформаторный
	case Transformattor
	/// Линейный
	case Linean
	case Parallel
	case Wood
	case Iron
}

/// Модель с продуктом 
struct ProductServiceModel {

	/// Модель данных ввода на главном экране выбора продукта
	struct MainScreenProductModel {
		/// url где хранится картинка на бэке
		var gifName: String
		/// тип ввода
		var typeName: String
		/// модели данного типа ввода
		var models: [DescriptionProductModel]
		/// краткая информация по выбранному типу
		var typeInfo: String
		/// флаг открывать секцию или нет
		var modelSectionCollapsed: Bool // секции свернуты по умолчанию
	}

	/// Модель видео на экране монтажа
	struct InstallationScreenVideoModel {
		/// id видео  берется из адресной строки youtube
		/// Пример:	"v?=1234" 1234 это строка id
		var videoId: String
		/// секция видео закрыта или нет
		var videoSectionCollapsed: Bool
		/// описание видео  ( опциональная вещь )
		var videoDescription: String
	}

	/// Модель руководства по эксплуатации на экране монтажа
	struct InstallationScreenManualModel {
		/// название локально хранящейся pdf ( руководство по эксплуатации )
		var manualPdfName: String
	}
}

/// Описание ввода для экрана поиска
struct DescriptionProductModel {
	/// название ввода
	var productName: String
	/// наименование 3d модели
	var model3DName: String //NSObject
	/// название  pdf - схема ввода ( чертеж )
	var schemeName: String
}


