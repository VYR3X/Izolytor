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

enum ProductEnum {
	case Transformattor
	case Linean
	case Parallel
	case Wood
	case Iron
}

/// Модель с продуктом 
struct ProductServiceModel {
	//	var git: String
	//	var type: String
	//	var models: [Model]
	//	var typeInfo: String
	//
	//	var rycovodstvo: String // название локально хранящейся pdf ( руководство по эксплуатации
	//	var videoId: String // "v?=1234" 1234 это строка id
	//	var collapsed: Bool

	struct MainScreenProductType {
		var git: String
		var typeName: String
		var models: [VModel]
		var typeInfo: String
		var modelSectionCollapsed: Bool // секции свернуты по умолчанию
	}

	struct YouTubeScreenProductType{
		var videoId: String // "v?=1234" 1234 это строка id
		var videoSectionCollapsed: Bool
	}

	struct MontaghScreenProductType {
		var rycovodstvo: String // название локально хранящейся pdf ( руководство по эксплуатации )
	}
}

struct VModel {
	var name: String
	var object: String //NSObject // 3d model
	var chertezh: String // название локально хранящейся pdf ( чертеж с размерами )
}


