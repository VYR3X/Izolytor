//
//  ScreenSizeMapper.swift
//  Izolyator
//
//  Created by 17790204 on 03.01.2021.
//  Copyright © 2021 Splash Fire. All rights reserved.
//

import UIKit

/// Маппер значений для различных размеров экрана
public final class ScreenSizeMapper {

	private enum ScreenSize {
		// 5, 5c , 5s, SE(2016)
		case p320

		// 6, 6s, 7, 8, SE(2020)
		case p375x667

		// 6+, 6s+, 7+, 8+
		case p414x736

		// X, XS, 11 Pro
		case p375x812

		// XR, 11, XS Max, 11 Pro Max
		case p414x896
	}

	/// размер UIScreen по ширине и высоте
	private static let screenSize: ScreenSize = {
		let size = UIScreen.main.bounds.size
		switch (size.width, size.height) {
		case (320, _): // 5, 5c , 5s, SE(2016)
			return .p320
		case (375, 667): // 6, 6s, 7, 8, SE(2020)
			return .p375x667
		case (414, 736): // 6+, 6s+, 7+, 8+
			return .p414x736
		case (375, 812): // X, XS, 11 Pro
			return .p375x812
		case (414, 896): // XR, 11, XS Max, 11 Pro Max
			return .p414x896
		default:
			return .p414x896
		}
	}()

	/// Возвращает переданное значение в зависимости от размера экрана
	///
	/// - Parameters:
	///   - small: значение для маленьких экранов
	///   - medium: значение для средних экранов
	///   - large: значение для больших экранов
	/// - Returns: значение
	public static func value<T>(small: T, medium: T, large: T) -> T {
		switch screenSize {
		case .p320:
			return small
		case .p375x667, .p375x812:
			return medium
		case .p414x736, .p414x896:
			return large
		}
	}

	/// Возвращает переданное значение в зависимости от размера экрана
	///
	/// - Parameters:
	///   - small: значение для маленьких экранов
	///   - other: значение для остальных экранов
	/// - Returns: значение
	public static func value<T>(small: T, other: T) -> T {
		return value(small: small, medium: other, large: other)
	}

	/// Разделение по наличию кнопки Home
	/// - Parameters:
	///   - past: модели с кнопкой Home
	///   - future: модели без кнопки Home
	public static func value<T>(past: T, future: T) -> T {
		switch screenSize {
		case .p320, .p375x667, .p414x736:
			return past
		case .p375x812, .p414x896:
			return future
		}
	}

	/// Возвращает переданное значение в зависимости от размера экрана
	///
	/// - Parameters:
	/// 	- iPhone5: девайсы: 5, 5c , 5s, SE(2016)
	/// 	- iPhone6: девайсы: 6, 6s, 7, 8, SE(2020)
	/// 	- iPhone6Plus: девайсы: 6+, 6s+, 7+, 8+
	/// 	- iPhoneX: девайсы: X, XS, 11 Pro
	/// 	- iPhoneXR: девайсы: XR, 11,  XS Max, 11 Pro Max
	/// - Returns: значение для модели
	public static func value<T>(iPhone5: T,
								iPhone6: T,
								iPhone6Plus: T,
								iPhoneX: T,
								iPhoneXR: T) -> T {
		switch screenSize {
		case .p320:
			return iPhone5
		case .p375x667:
			return iPhone6
		case .p414x736:
			return iPhone6Plus
		case .p375x812:
			return iPhoneX
		case .p414x896:
			return iPhoneXR
		}
	}
}

