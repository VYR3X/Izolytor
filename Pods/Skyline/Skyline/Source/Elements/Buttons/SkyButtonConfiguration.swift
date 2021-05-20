//
//  SkyButtonConfiguration.swift
//  Skyline
//
//  Created by 17790204 on 06.05.2021.
//

import UIKit

/// Конфигурация кнопки кварками
public final class SkyButtonConfiguration<Type: UIButton>: SkyBaseButtonConfiguration<Type, SkyButtonConfiguration>, Statable {

	/// Картинка, которую нужно отобразить
	public var picture: UIImage? {
		didSet {
//			guard let picture = picture else {
//				owner?.setImage(nil, for: .normal)
//				return
//			}
//			switch picture {
//			case .logo: break
//			case let .icon(_, color):
//				tintColor = color
//			}
			owner?.setImage(picture, for: .normal)
			updateInsets()
		}
	}

	/// Шрифт текста
//	public var font: Font = .button {
//		didSet {
//			updateAttributedText()
//		}
//	}

	/// Цвет текста
	public var textColor: Color = .onBackgroundPrimary {
		didSet {
			updateAttributedText()
		}
	}

	/// Текст
	public var text: String? {
		didSet {
			updateAttributedText()
			updateInsets()
		}
	}

	/// Отступы картинки, как imageEdgeInsets
//	public var imageInsets: GInsets? {
//		didSet {
//			owner?.imageEdgeInsets = imageInsets?.uiEdgeInsets ?? .zero
//			owner?.invalidateIntrinsicContentSize()
//		}
//	}

	/// Отступы контента
	public var contentInsets: UIEdgeInsets? {
		didSet {
			updateInsets()
		}
	}

	/// Отступ между текстом и картинкой
//	public var gap: Gap? {
//		didSet {
//			updateInsets()
//		}
//	}

	/// Расположение картинки
	public var imageAlignment: SkyButton.ImageAlignment = .leading {
		didSet {
			let direction = UIApplication.shared.userInterfaceLayoutDirection
			switch imageAlignment {
			case .leading:
				owner?.semanticContentAttribute = direction == .leftToRight ? .forceLeftToRight : .forceRightToLeft
			default:
				owner?.semanticContentAttribute = direction == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
			}
			updateInsets()
		}
	}

	/// устанавливаем стартер для конфига кнопки
	init() {
		super.init(stater: SkyStateDecorator(state: .default))
		stater.sky = self
	}

//	public override func styleDidChange(options: UpdateOptions) {
//		super.styleDidChange(options: options)
//
//		if options.contains(.palette) {
//			retrigger(self, \.textColor)
//		}
//		if options.contains(.typography) {
//			retrigger(self, \.font)
//		}
//		if options.contains(.language) {
//			retrigger(self, \.text)
//		}
//	}

	override func configureOwner() {
		super.configureOwner()

//		retrigger(self, \.picture)
//		retrigger(self, \.font)
//		retrigger(self, \.textColor)
//		retrigger(self, \.imageAlignment)
	}

	private func updateAttributedText() {
		guard let text = text else {
			owner?.setAttributedTitle(nil, for: .normal)
			return
		}
		let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: LightPalette().color(textColor)]
		let attributedString = NSAttributedString(string: text, attributes: attributes)

		owner?.setAttributedTitle(attributedString, for: .normal)
	}

	private func updateInsets() {
		defer { owner?.invalidateIntrinsicContentSize() }

		let insets = contentInsets ?? .zero
		guard
//			let gap = gap,
			text != nil,
			picture != nil else {
//				owner?.contentEdgeInsets = insets.uiEdgeInsets
				owner?.titleEdgeInsets = .zero
			return
		}
//		let gapValue = layout.value(gap: gap)
		let titleInsets: UIEdgeInsets
		switch imageAlignment {
		case .leading:
			owner?.contentEdgeInsets = UIEdgeInsets(top: insets.top,
													left: insets.left,
													bottom: insets.bottom,
													right: insets.right) // + gapValue
			titleInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
			owner?.titleEdgeInsets = titleInsets
		case .trailing:
			owner?.contentEdgeInsets = UIEdgeInsets(top: insets.top,
													left: insets.left, // + gapValue
													bottom: insets.bottom,
													right: insets.right)
//			titleInsets = GInsets(left: -gapValue, right: gapValue)
			titleInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
			owner?.titleEdgeInsets = titleInsets
		}
//		owner?.titleEdgeInsets = titleInsets 
	}
}
