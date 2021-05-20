//
//  Palette.swift
//  Skyline
//
//  Created by Vladislav Zhokhov on 04.05.2021.
//

import UIKit

/// Палитра приложения
protocol Palette {

	/// Перевести Color в UIColor
	/// - Parameter gColor:цвет дизайн системы
	func color(_ gColor: Color) -> UIColor
}
