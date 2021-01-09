//
//  DefaultLayout.swift
//  Izolyator
//
//  Created by 17790204 on 03.01.2021.
//  Copyright © 2021 Splash Fire. All rights reserved.
//

import CoreGraphics

protocol GLayout {
	/// Получить значение отступа внутри элемента
	///
	/// - Parameter gap: отступ внутри элемента
	/// - Returns: значение отступа
	func value(gap: Gap) -> CGFloat

	/// Получить значение горизонтального отступа от краев элемента
	///
	/// - Parameter horizontalPadding: отступ от краев элемента
	/// - Returns: значение отступа
	func value(horizontalPadding: Padding.Horizontal) -> CGFloat

	/// Получить значение вертикального отступа от краев элемента
	///
	/// - Parameter verticalPadding: отступ от краев элемента
	/// - Returns: значение отступа
	func value(verticalPadding: Padding.Vertical) -> CGFloat

	/// Получить значение внешнего отступа элемента
	///
	/// - Parameter padding: внешний отступ элемента
	/// - Returns: значение отступа
	func value(margin: Margin) -> CGFloat
}

/// Стандартный лэйаут приложения
struct DefaultLayout: GLayout {
	func value(gap: Gap) -> CGFloat {
		switch gap {
		case .zero:
			return 0
		case .text:
			return 4
		case .atom:
			return 12
		case .molecule:
			return 16
		}
	}

	func value(horizontalPadding: Padding.Horizontal) -> CGFloat {
		switch horizontalPadding {
		case .zero:
			return 0
		case .smallest:
			return 8
		case .molecule:
			return 16
		case .edge:
			return ScreenSizeMapper.value(small: 12, other: 24)
		}
	}

	func value(verticalPadding: Padding.Vertical) -> CGFloat {
		switch verticalPadding {
		case .zero:
			return 0
		case .smallest:
			return 8
		case .atom:
			return 12
		case .molecule:
			return 16
		case .organism:
			return 16
		}
	}

	func value(margin: Margin) -> CGFloat {
		switch margin {
		case .zero:
			return 0
		case .atom:
			return 12
		case .molecule:
			return 12
		case .organism:
			return 8
		}
	}
}

