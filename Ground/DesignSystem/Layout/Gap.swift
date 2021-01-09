//
//  Gap.swift
//  Izolyator
//
//  Created by 17790204 on 03.01.2021.
//  Copyright © 2021 Splash Fire. All rights reserved.
//

import CoreGraphics
import Foundation

/// Расстояния внутри компоннетов
@objc public enum Gap: Int, CaseIterable {

	/// Нулевой
	case zero

	/// Между текстовыми элементами
	case text

	/// Внутри атомов
	case atom

	/// Внутри молекул
	case molecule
}
