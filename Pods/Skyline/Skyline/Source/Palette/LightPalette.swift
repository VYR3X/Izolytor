//
//  LightPalette.swift
//  Skyline
//
//  Created by Vladislav Zhokhov on 04.05.2021.
//

import UIKit

/// Палитра для светлой темы
struct LightPalette: Palette {

	// swiftlint:disable cyclomatic_complexity
	func color(_ gColor: Color) -> UIColor {
		switch gColor {
		case .clear:					return UIColor(white: 1.0, alpha: 0.0)

		case .generalPrimary:			return UIColor(hex: "#1A1A1A")
		case .generalBrand:				return UIColor(hex: "#29B260")

		case .backgroundDefault:		return UIColor(hex: "#FFFFFF")
		case .backgroundOverlay:		return UIColor(hex: "#000000").withAlphaComponent(0.8)

		case .onBackgroundPrimary:		return UIColor(hex: "#1A1A1A")
		case .onBackgroundSecondary:	return UIColor(hex: "#757575")
		case .onBackgroundTertiary: 	return UIColor(hex: "#CCCCD0")
		case .onBackgroundQuaternary: 	return UIColor(hex: "#F5F5F6")

		case .surfaceDefault: 			return UIColor(hex: "#FFFFFF")
		case .surfaceAccent: 			return UIColor(hex: "#F5F5F6")

		case .onSurfacePrimary: 		return UIColor(hex: "#1A1A1A")
		case .onSurfaceSecondary:		return UIColor(hex: "#757575")

		case .onColorPrimary: 			return UIColor(hex: "#FFFFFF")
		case .onImagePrimary: 			return UIColor(hex: "#FFFFFF")

		case .helperError: 				return UIColor(hex: "#FF3B30")
		case .helperWarning: 			return UIColor(hex: "#FF9500")

		case .lentaSecondaryLight: 		return UIColor(hex: "#FFFFFF").withAlphaComponent(0.74)
		case .lentaTertiaryLight: 		return UIColor(hex: "#FFFFFF").withAlphaComponent(0.32)
		case .lentaSecondaryDark: 		return UIColor(hex: "#1A1A1A").withAlphaComponent(0.55)
		case .lentaTertiaryDark: 		return UIColor(hex: "#1A1A1A").withAlphaComponent(0.20)
		case .lentaQuaternaryDark: 		return UIColor(hex: "#1A1A1A").withAlphaComponent(0.08)
		case .lentaSnackbar:			return UIColor(hex: "#1A1A1A")
		case .lentaTapOverlay: 			return UIColor(hex: "#FFFFFF").withAlphaComponent(0.32)

		case .poppy: 					return UIColor(hex: "#F14F1D")
		case .rose: 					return UIColor(hex: "#E2236C")
		case .lavender:					return UIColor(hex: "#9B32F6")
		case .dewberry: 				return UIColor(hex: "#5935F5")
		case .blueberry: 				return UIColor(hex: "#2D56F4")
		case .cornflower: 				return UIColor(hex: "#158CF9")
		case .aqua: 					return UIColor(hex: "#0BB8E3")
		case .papaya: 					return UIColor(hex: "#07BD98")
		case .lime: 					return UIColor(hex: "#42C737")
		case .kiwi: 					return UIColor(hex: "#81BA09")
		case .sunflower: 				return UIColor(hex: "#FFCC00")
		case .fig: 						return UIColor(hex: "#6C44BF")
		case let .custom(uiColor): 		return uiColor
		}
	}
}

