//
//  Array.swift
//  Izolyator
//
//  Created by Vladislav Zhokhov on 13.01.2021.
//  Copyright © 2021 Splash Fire. All rights reserved.
//

extension Array {

	/// Присоединяет новый элемент к массиву в случае, если выполняется условие.
	///
	/// - Parameters:
	///   - newElement: *Обязательный.* Новый элемент.
	///   - conditionClosure: *Обязательный.* Условие присоединения.
	mutating func append(_ newElement: Element, if conditionClosure: @autoclosure () -> Bool) {
		if conditionClosure() {
			append(newElement)
		}
	}
	/// Вставляет новый элемент в указанное место массива в случае, если выполняется условие.
	///
	/// - Parameters:
	///   - newElement: *Обязательный.* Новый элемент.
	///   - index: *Обязательный.* Позиция (индекс) элемента.
	///   - conditionClosure: *Обязательный.* Условие вставки.
	mutating func insert(_ newElement: Element, at index: Int, if conditionClosure: @autoclosure () -> Bool) {
		if conditionClosure() {
			insert(newElement, at: index)
		}
	}

	/// Безопасно возвращает элемент последовательности.
	///
	/// - Parameters:
	///   - index: Индекс элемента.
	///   - element: Возвращаемый при некорректном индексе элемент.
	subscript(index: Int, element: Element?) -> Element? {
		let arr = self
		guard index >= 0, index < arr.count else { return element }
		return arr[index]
	}

	/// Безопасно возвращает элемент последовательности.
	///
	/// - Parameters:
	///   - index: Индекс элемента.
	///   - element: Возвращаемый при некорректном индексе элемент.
	subscript(safe index: Int) -> Element? {
		let arr = self
		guard index >= 0, index < arr.count else { return nil }
		return arr[index]
	}
}

