//
//  Margin.swift
//  Izolyator
//
//  Created by 17790204 on 03.01.2021.
//  Copyright © 2021 Splash Fire. All rights reserved.
//

import Foundation
import CoreGraphics

/// Внешние отступы
@objc public enum Margin: Int, CaseIterable {

	/// Нулевой
	case zero

	/// Внешний отступ для атома
	case atom

	/// Внешний отступ для молекулы
	case molecule

	/// Внешний отступ для организма
	case organism
}
