//
//  ButtonDescriptor.swift
//  Skyline
//
//  Created by 17790204 on 06.05.2021.
//

import UIKit
import CoreGraphics

/// Сотояние контрола
///
/// - `default`: обычное состояние
/// - active: активное состояние (например нажатый лайк)
/// - pressed: нажатое состояние
/// - disabled: неактивное состояние
public enum SkyControlState {
	case `default`
	case selected
	case pressed
	case disabled
}

/// Описание кнопки
public protocol ButtonDescriptor {

	/// Сконфигурировать кнопку
	///
	/// - Parameter button:  кнопка, которую нужно сконфигурировать
	func configure(_ button: SkyButton)
}

/// Базовое описание кнопки
open class BaseButtonDescriptor: ButtonDescriptor {

	/// Размер кнопки
	public let size: SkyButtonSize
	/// Иконка
	public let icon: UIImage?

	/// Конструктор
	///
	/// - Parameters:
	///   - size: размер кнопки
	///   - icon: иконка
	public init(size: SkyButtonSize,
				icon: UIImage? = nil) {
		self.size = size
		self.icon = icon
	}

	open func configure(_ button: SkyButton) {
//		button.sky.font = .button
		button.sky.clipsToBounds = true
//		button.sky.blurred = false
		button.sky.size = size
//		button.sky.removeAllAssociations()

		let initialTransform = button.sky.transform
		let scale: CGFloat = 0.95

		button.sky.associate(states: .default, .selected) { g in
			g.transform = initialTransform
//			g.overlay.state = .inactive
			g.isEnabled = true
		}
		button.sky.associate(states: .disabled) { g in
			g.transform = initialTransform
			g.isEnabled = false
		}
		button.sky.associate(states: .pressed) { g in
			if case .large = g.size {
				g.transform = initialTransform.scaledBy(x: scale, y: scale)
			}
//			g.overlay.state = .aboveAll
			g.isEnabled = true
		}

		switch size {
		case .medium:
			print("medium button")
			button.sky.cornerRadius = 20.0//.circle
//			let padding = button.sky.layout.value(horizontalPadding: .molecule)
//			button.g.contentInsets = GInsets(horizontal: padding)
//			button.sky.gap = .text
		case .large:
			print("large button")
			button.sky.cornerRadius = 10.0//.small
		}
	}
}

/// Описание главной кнопки
final class PrimaryButtonDescriptor: BaseButtonDescriptor {
	override func configure(_ button: SkyButton) {
		super.configure(button)
		button.sky.associate(states: .default, .pressed) { g in
			g.textColor = .backgroundDefault
			g.backgroundColor = .generalPrimary
//			g.picture?.repaint(to: g.textColor)
		}
		button.sky.associate(states: .disabled) { g in
			g.textColor = .lentaSecondaryLight
			g.backgroundColor = .onBackgroundTertiary
//			g.picture?.repaint(to: g.textColor)
		}
	}
}

/// Описание вторичной кнопки
final class SecondaryButtonDescriptor: BaseButtonDescriptor {
	override func configure(_ button: SkyButton) {
		super.configure(button)
		button.sky.backgroundColor = .onBackgroundQuaternary
		button.sky.associate(states: .default, .pressed) { g in
			g.textColor = .onSurfaceSecondary
//			g.picture?.repaint(to: g.textColor)
		}
		button.sky.associate(states: .disabled) { g in
			g.textColor = .lentaTertiaryDark
//			g.picture?.repaint(to: g.textColor)
		}
	}
}

/// Описание кнопки Floating
final class FloatingButtonDescriptor: BaseButtonDescriptor {
	override func configure(_ button: SkyButton) {
		super.configure(button)
		button.sky.mode = .spring
		button.sky.backgroundColor = .surfaceDefault
//		button.sky.shadow = .small
		button.sky.associate(states: .default, .pressed) { g in
			g.textColor = .onSurfacePrimary
//			g.picture?.repaint(to: g.textColor)
		}
		button.sky.associate(states: .pressed, .disabled) { g in
			g.textColor = .onSurfaceSecondary
		}
	}
}

/// Описание  кнопки c текстом
final class TextButtonDescriptor: ButtonDescriptor {
	func configure(_ button: SkyButton) {
//		button.sky.font = .button
		button.sky.clipsToBounds = true
		button.sky.cornerRadius = .zero
//		button.sky.blurred = false
		button.sky.size = .large
		button.sky.removeAllAssociations()
		button.sky.associate(states: .default, .selected) { g in
			g.isEnabled = true
			g.textColor = .onBackgroundSecondary
//			g.picture?.repaint(to: g.textColor)
		}
		button.sky.associate(states: .disabled) { g in
			g.isEnabled = false
			g.textColor = .onBackgroundTertiary
//			g.picture?.repaint(to: g.textColor)
		}
		button.sky.associate(states: .pressed) { g in
			g.isEnabled = true
			g.textColor = .onBackgroundTertiary
//			g.picture?.repaint(to: .onBackgroundQuaternary)
		}
		button.sky.associate(states: .selected) { g in
			g.isEnabled = true
			g.textColor = .generalBrand
//			g.picture?.repaint(to: g.textColor)
		}
	}
}

/// Кнопка с прозрачным юэкграундом
struct ClearButtonDescriptor: ButtonDescriptor {

	private let color: Color
	private let icon: UIImage?

	/// Конструктор
	///
	/// - Parameters:
	///   - icon: иконка для отображения
	///   - color:цвет иконки в дефолтном состоянии
	init(icon: UIImage?, color: Color) {
		self.icon = icon
		self.color = color
	}

	func configure(_ button: SkyButton) {
		button.sky.clipsToBounds = false
//		button.sky.cornerRadius = .circle
		button.sky.backgroundColor = .clear
//		button.sky.picture = button.g.album.optionalIcon(icon, color: color)
		button.sky.removeAllAssociations()
		button.sky.associate(states: .default) { g in
//			g.picture?.repaint(to: color)
			g.isEnabled = true
		}
		button.sky.associate(states: .pressed) { g in
//			g.picture?.repaint(to: .lentaTapOverlay)
			g.isEnabled = true
		}
		button.sky.associate(states: .disabled) { g in
//			g.picture?.repaint(to: .lentaTapOverlay)
			g.isEnabled = false
		}
	}
}

/// Описание кнопки Check
final class CheckButtonDescriptor: ButtonDescriptor {
	func configure(_ button: SkyButton) {
		button.sky.size = .large
		button.sky.backgroundColor = .clear
		button.sky.mode = .sticky
//		button.g.gap = .atom
		button.sky.associate(states: .default) { g in
//			g.picture = g.album.icon(.checkboxOff, color: .onBackgroundSecondary)
		}
		button.sky.associate(states: .pressed) { g in
//			g.picture?.repaint(to: .lentaTapOverlay)
		}
		button.sky.associate(states: .selected) { g in
//			g.picture = g.album.icon(.checkboxOn, color: .generalBrand)
		}
	}
}

/// Описание кнопки Radio
final class RadioButtonDescriptor: ButtonDescriptor {
	func configure(_ button: SkyButton) {
		button.sky.size = .large
		button.sky.backgroundColor = .clear
		button.sky.mode = .sticky
//		button.g.gap = .atom
		button.sky.associate(states: .default) { g in
//			g.picture = g.album.icon(.radiobox, color: .onBackgroundSecondary)
		}
		button.sky.associate(states: .pressed) { g in
//			g.picture?.repaint(to: .lentaTapOverlay)
		}
		button.sky.associate(states: .selected) { g in
//			g.picture = g.album.icon(.radioboxOn, color: .generalBrand)
		}
	}
}

