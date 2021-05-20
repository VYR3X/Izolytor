//
//  UIColor+hex.swift
//  Skyline
//
//  Created by Vladislav Zhokhov on 04.05.2021.
//

import UIKit

public extension UIColor {

	private struct RGBA {
		let red: CGFloat
		let green: CGFloat
		let blue: CGFloat
		let alpha: CGFloat
	}

	///  Создает цвет по хексу в формате RGBA или RGB
	/// - Note: Примеры цвета: #1A2B3CFF или #1A2B3C.
	/// Если hex был передан без альфы, по умолчанию выставляется 1.0
	/// Если была передана некорректная строка, возвращается clear (#00000000)
	/// - Parameter hex:  hex-код цвета
	convenience init(hex: String) {
		let hexColor: String
		if hex.hasPrefix("#") {
			let start = hex.index(hex.startIndex, offsetBy: 1)
			hexColor = String(hex[start...])
		} else {
			hexColor = hex
		}
		let scanner = Scanner(string: hexColor)
		var hexNumber: UInt64 = 0
		if scanner.scanHexInt64(&hexNumber), let rgba = UIColor.parse(hex: hexColor, hexNumber: hexNumber) {
			self.init(red: rgba.red, green: rgba.green, blue: rgba.blue, alpha: rgba.alpha)
			return
		}
		self.init(white: 0.0, alpha: 0.0)
	}

	/// Создает цвет по хексу в формате RGBA или RGB
	///
	/// - Parameter hex: цвет в формате #1A2B3CFF или #1A2B3C
	convenience init?(hex: String?) {
		guard let hex = hex else { return nil }
		self.init(hex: hex)
	}

	private static func parse(hex: String, hexNumber: UInt64) -> RGBA? {
		let red, green, blue, alpha: UInt64

		switch hex.count {
		case 3:
			red = ((hexNumber & 0xf00) >> 4) * 17
			green = ((hexNumber & 0x0f0) >> 1) * 17
			blue = ((hexNumber & 0x00f)) * 17
			alpha = 255
		case 6:
			red = (hexNumber & 0xff0000) >> 16
			green = (hexNumber & 0x00ff00) >> 8
			blue = hexNumber & 0x0000ff
			alpha = 255
		case 8:
			red = (hexNumber & 0xff000000) >> 24
			green = (hexNumber & 0x00ff0000) >> 16
			blue = (hexNumber & 0x0000ff00) >> 8
			alpha = hexNumber & 0x000000ff
		default: return nil
		}

		return RGBA(red: CGFloat(red) / 255,
					green: CGFloat(green) / 255,
					blue: CGFloat(blue) / 255,
					alpha: CGFloat(alpha) / 255)
	}
}

