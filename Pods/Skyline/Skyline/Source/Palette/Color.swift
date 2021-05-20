//
//  Color.swift
//  Skyline
//
//  Created by Vladislav Zhokhov on 04.05.2021.
//

import UIKit

// #codegen
public enum Color: CaseIterable {
	public typealias AllCases = [Color]

	case clear

	// General
	case generalPrimary
	case generalBrand

	// Background
	case backgroundDefault
	case backgroundOverlay

	// OnBackground
	case onBackgroundPrimary
	case onBackgroundSecondary
	case onBackgroundTertiary
	case onBackgroundQuaternary

	// Surface
	case surfaceDefault
	case surfaceAccent

	// OnSurface
	case onSurfacePrimary
	case onSurfaceSecondary

	// OnImage
	case onImagePrimary

	// OnColor
	case onColorPrimary

	// Helper
	case helperError
	case helperWarning

	// Lenta
	case lentaSecondaryLight
	case lentaTertiaryLight
	case lentaSecondaryDark
	case lentaTertiaryDark
	case lentaQuaternaryDark
	case lentaSnackbar
	case lentaTapOverlay

	// Other Colors
	case poppy
	case rose
	case lavender
	case dewberry
	case blueberry
	case cornflower
	case aqua
	case papaya
	case lime
	case kiwi
	case sunflower
	case fig

	// Используется, когда цвет приходит с бэка
	case custom(uiColor: UIColor)

	public static var allCases: [Color] {
		return [clear,
				generalPrimary, generalBrand,
				backgroundDefault, backgroundOverlay,
				onBackgroundPrimary, onBackgroundSecondary, onBackgroundTertiary, onBackgroundQuaternary,
				surfaceDefault, surfaceAccent,
				onSurfacePrimary, onSurfaceSecondary,
				onColorPrimary, onImagePrimary,
				helperError, helperWarning,
				lentaSecondaryLight, lentaTertiaryLight, lentaSecondaryDark, lentaTertiaryDark, lentaQuaternaryDark,
				lentaSnackbar, lentaTapOverlay,
				poppy, rose, lavender, dewberry, blueberry,
				cornflower, aqua, papaya, lime, kiwi, sunflower, fig]
	}

	static var `default`: Color = .onBackgroundSecondary
}

