//
//  SkyButton.swift
//  Skyline
//
//  Created by 17790204 on 06.05.2021.
//

import UIKit

/// Простая кнопка, которую можно конфигурировать кварками.
public final class SkyButton: UIButton {

	public enum ImageAlignment {
		case leading
		case trailing
	}

	/// Конфигурация кнопки
	public let sky: SkyButtonConfiguration<SkyButton>

	/// Конструктор
	///
	/// - Parameters:
	///   - style: стиль
	///   - descriptor: описание кнопки
	init(type: SkyButtonType? = nil) {
		sky = SkyButtonConfiguration()
		super.init(frame: .zero)
		translatesAutoresizingMaskIntoConstraints = false
		sky.owner = self
		if let type = type { apply(type) }
	}

	@available(*, unavailable)
	required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
	@available(*, unavailable)
	public override init(frame: CGRect) { fatalError("init(coder:) has not been implemented") }

	public override var intrinsicContentSize: CGSize {
		let intristicWidth = super.intrinsicContentSize.width
		return CGSize(width: intristicWidth, height: sky.size.height)
	}

	/// Применить новый тип кнопки
	///
	/// - Parameter type: тип кнопки
	public func apply(_ type: SkyButtonType) {
		type.descriptor.configure(self)
	}
}

// MARK: - Публичные конструкторы

public extension SkyButton {

	/// Конструктор
	convenience init() {
		self.init()
	}

	/// Конструктор
	///
	/// - Parameter type: тип кнопки
	convenience init(skytype: SkyButtonType) {
		self.init(type: skytype)
	}

	/// Конструктор
	/// - Parameter descriptor: описание кнопки
	convenience init(descriptor: ButtonDescriptor) {
		self.init(type: .custom(descriptor: descriptor))
	}
}

