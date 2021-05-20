//
//  SkyPinPadConfiguration.swift
//  Skyline
//
//  Created by 17790204 on 05.05.2021.
//

import UIKit

///  Вспомогательная кнопка на пинпаде
public struct SkyPinPadAccessoryButtonInfo {

	///  Картинка
//	public var picture: Picture?
	// Здесь могут быть любые свойства, которые мы можем захотеть поменять у кнопки
}

///  Конфигурация пинпада
public class SkyPinPadConfiguration<Type: SkyPinPad>: SkyViewConfiguration<Type> {

	/// Шрифт кнопок с цифрами
//	public var digitFont: UIFont =  {
//		didSet {
//			owner?.updateDigitButtons()
//		}
//	}

	/// Цвет цифр
	public var digitColor: Color = .onBackgroundPrimary {
		didSet {
			owner?.updateDigitButtons()
		}
	}

	/// Левая вспомогательная кнопка
	public var leftButtonInfo: SkyPinPadAccessoryButtonInfo {
		didSet {
			owner?.updateAccessoryButtons()
		}
	}

	/// Правая вспомогательная кнопка
	public var rightButtonInfo: SkyPinPadAccessoryButtonInfo {
		didSet {
			owner?.updateAccessoryButtons()
		}
	}

	override init() {
		self.leftButtonInfo = SkyPinPadAccessoryButtonInfo()
		self.rightButtonInfo = SkyPinPadAccessoryButtonInfo()
		super.init()
	}
}
