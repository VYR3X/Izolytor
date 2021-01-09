//
//  Padding.swift
//  Izolyator
//
//  Created by 17790204 on 03.01.2021.
//  Copyright © 2021 Splash Fire. All rights reserved.
//

import CoreGraphics

/// Отступы от краев элемента
public enum Padding {

	/// Горизонтальные отступы от краев элемента
	public enum Horizontal: Int, CaseIterable {
		/// Нулевой
		case zero

		/// Наименьший
		case smallest

		/// Отступ в молекуле
		case molecule

		/// Отступ от краев девайса
		case edge
	}

	/// Вертикальные отступы от краев элемента
	public enum Vertical: Int, CaseIterable {
		/// Нулевой
		case zero

		/// Наименьший
		case smallest

		/// Отступ в атоме
		case atom

		/// Отступ в молекуле
		case molecule

		/// Отступ в организме
		case organism
	}
}

