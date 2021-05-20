//
//  SkyPinPadDelegate.swift
//  Skyline
//
//  Created by 17790204 on 05.05.2021.
//

///  Делегат пин пад вью
public protocol SkyPinPadDelegate: AnyObject {

	///  Была нажата кнопка с цифрой
	func pinPadView(_ pinPadView: SkyPinPad, didTapDigitButtonWith text: String)
	///  Была нажата левая вспомогательная кнопка
	func pinPadViewDidTapLeftButton(_ pinPadView: SkyPinPad)
	///  Была нажата правая вспомогательная кнопка
	func pinPadViewDidTapRightButton(_ pinPadView: SkyPinPad)
}

// MARK: - Дефолтная имплеменатация
public extension SkyPinPadDelegate {
	func pinPadView(_ pinPadView: SkyPinPad, didTapDigitButtonWith text: String) {}
	func pinPadViewDidTapLeftButton(_ pinPadView: SkyPinPad) {}
	func pinPadViewDidTapRightButton(_ pinPadView: SkyPinPad) {}
}
