//
//  DarkPalette.swift
//  Izolyator
//
//  Created by Vladislav Zhokhov on 14.01.2021.
//  Copyright © 2021 Splash Fire. All rights reserved.
//

import UIKit

/// Палитра для темной темы
struct DarkPalette: Palette {

	// swiftlint:disable cyclomatic_complexity
	func color(_ gColor: Color) -> UIColor {
		switch gColor {
		case .clear:					return UIColor(white: 0.0, alpha: 0.0)

		case .generalPrimary:			return UIColor(hex: "#FFFFFF")
		case .generalBrand:				return UIColor(hex: "#29B260")

		case .darkBlue: return UIColor(hex: "1C4F97")
		case .lightBackground: return UIColor(hex: "F9F9F9")
		case .lightBlue:	return UIColor(hex: "66BFED")

		case .backgroundDefault:		return UIColor(hex: "#121212")
		case .backgroundOverlay:		return UIColor(hex: "#000000").withAlphaComponent(0.8)

		case .onBackgroundPrimary:		return UIColor(hex: "#E7E7E7")
		case .onBackgroundSecondary:	return UIColor(hex: "#A0A0A0")
		case .onBackgroundTertiary: 	return UIColor(hex: "#717171")
		case .onBackgroundQuaternary: 	return UIColor(hex: "#414141")

		case .surfaceDefault: 			return UIColor(hex: "#212121")
		case .surfaceAccent: 			return UIColor(hex: "#2D2D2D")

		case .onSurfacePrimary: 		return UIColor(hex: "#E7E7E7")
		case .onSurfaceSecondary:		return UIColor(hex: "#A0A0A0")

		case .onColorPrimary: 			return UIColor(hex: "#FFFFFF")
		case .onImagePrimary: 			return UIColor(hex: "#FFFFFF")

		case .helperError: 				return UIColor(hex: "#FF3B30")
		case .helperWarning: 			return UIColor(hex: "#FF9500")

		case .lentaSecondaryLight: 		return UIColor(hex: "#FFFFFF").withAlphaComponent(0.74)
		case .lentaTertiaryLight: 		return UIColor(hex: "#FFFFFF").withAlphaComponent(0.32)
		case .lentaSecondaryDark: 		return UIColor(hex: "#1A1A1A").withAlphaComponent(0.55)
		case .lentaTertiaryDark: 		return UIColor(hex: "#1A1A1A").withAlphaComponent(0.20)
		case .lentaQuaternaryDark: 		return UIColor(hex: "#1A1A1A").withAlphaComponent(0.04)
		case .lentaSnackbar:			return UIColor(hex: "#1A1A1A")
		case .lentaTapOverlay: 			return UIColor(hex: "#000000").withAlphaComponent(0.16)

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

