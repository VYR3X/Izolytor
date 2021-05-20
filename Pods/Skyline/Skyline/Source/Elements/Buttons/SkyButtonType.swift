//
//  SkyButtonType.swift
//  Skyline
//
//  Created by 17790204 on 06.05.2021.
//

import UIKit

/// Типы кнопок
public enum SkyButtonType {
	case base
	case primary(size: SkyButtonSize)
	case secondary(size: SkyButtonSize)
	case floating
	case text
//	case clear(icon: UIImage?, color: Color)
	case check
	case radio
	case custom(descriptor: ButtonDescriptor)

	var descriptor: ButtonDescriptor {
		switch self {
		case .base: return BaseButtonDescriptor(size: .large)
		case let .primary(size): return PrimaryButtonDescriptor(size: size)
		case let .secondary(size): return SecondaryButtonDescriptor(size: size)
		case .text: return TextButtonDescriptor()
		case .floating: return FloatingButtonDescriptor(size: .large)
//		case .clear(let (icon, color)): return ClearButtonDescriptor(icon: icon, color: color)
		case .check: return CheckButtonDescriptor()
		case .radio: return RadioButtonDescriptor()
		case let .custom(descriptor): return descriptor
		}
	}
}

