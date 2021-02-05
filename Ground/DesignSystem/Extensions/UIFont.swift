//
//  UIFont.swift
//  Izolyator
//
//  Created by 17790204 on 05.02.2021.
//  Copyright © 2021 Splash Fire. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {

	public enum OpenSansType: String {
		case extraboldItalic = "-ExtraboldItalic"
		case semiboldItalic = "-SemiboldItalic"
		case semibold = "-Semibold"
		case regular = ""
		case lightItalic = "Light-Italic"
		case light = "-Light"
		case italic = "-Italic"
		case extraBold = "-Extrabold"
		case boldItalic = "-BoldItalic"
		case bold = "-Bold"
	}

	static func OpenSans(_ type: OpenSansType = .regular, size: CGFloat = UIFont.systemFontSize) -> UIFont {
		return UIFont(name: "OpenSans\(type.rawValue)", size: size)!
	}

	var isBold: Bool {
		return fontDescriptor.symbolicTraits.contains(.traitBold)
	}

	var isItalic: Bool {
		return fontDescriptor.symbolicTraits.contains(.traitItalic)
	}

}


// Example how to use custom font
//self.numberLabel.font = UIFont.OpenSans(.bold, size: 20)

// https://stackoverflow.com/questions/50978284/swift-4-set-custom-font-programmatically/50978343
