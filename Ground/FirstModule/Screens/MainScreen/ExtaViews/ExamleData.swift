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
	Section(name: "Mac", items: [
		Item(name: "MacBook", detail: "Apple's ultraportable laptop, trading portability for speed and connectivity."),
		Item(name: "MacBook Air", detail: "While the screen could be sharper, the updated 11-inch MacBook Air is a very light ultraportable that offers great performance and battery life for the price."),
		Item(name: "MacBook Pro", detail: "Retina Display The brightest, most colorful Mac notebook display ever. The display in the MacBook Pro is the best ever in a Mac notebook."),
		Item(name: "iMac", detail: "iMac combines enhanced performance with our best ever Retina display for the ultimate desktop experience in two sizes."),
		Item(name: "Mac Pro", detail: "Mac Pro is equipped with pro-level graphics, storage, expansion, processing power, and memory. It's built for creativity on an epic scale."),
		Item(name: "Mac mini", detail: "Mac mini is an affordable powerhouse that packs the entire Mac experience into a 7.7-inch-square frame."),
		Item(name: "OS X El Capitan", detail: "The twelfth major release of OS X (now named macOS)."),
		Item(name: "Accessories", detail: "")
	]),
	Section(name: "iPad", items: [
		Item(name: "iPad Pro", detail: "iPad Pro delivers epic power, in 12.9-inch and a new 10.5-inch size."),
		Item(name: "iPad Air 2", detail: "The second-generation iPad Air tablet computer designed, developed, and marketed by Apple Inc."),
		Item(name: "iPad mini 4", detail: "iPad mini 4 puts uncompromising performance and potential in your hand."),
		Item(name: "Accessories", detail: "")
	]),
	Section(name: "iPhone", items: [
		Item(name: "iPhone 6s", detail: "The iPhone 6S has a similar design to the 6 but updated hardware, including a strengthened chassis and upgraded system-on-chip, a 12-megapixel camera, improved fingerprint recognition sensor, and LTE Advanced support."),
		Item(name: "iPhone 6", detail: "The iPhone 6 and iPhone 6 Plus are smartphones designed and marketed by Apple Inc."),
		Item(name: "iPhone SE", detail: "The iPhone SE was received positively by critics, who noted its familiar form factor and design, improved hardware over previous 4-inch iPhone models, as well as its overall performance and battery life."),
		Item(name: "Accessories", detail: "")
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

