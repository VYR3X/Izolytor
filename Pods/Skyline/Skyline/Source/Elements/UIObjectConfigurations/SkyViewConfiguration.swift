//
//  SkyViewConfiguration.swift
//  Skyline
//
//  Created by 17790204 on 05.05.2021.
//

import UIKit

/// Конфигурация View кварками
public class SkyViewConfiguration<Type: UIView>: SkyConfiguration<Type> {

	/// Цвет фона
	public var backgroundColor: Color = .clear {
		didSet {
			let palette = LightPalette()
			let color = palette.color(backgroundColor)
//			let color = style.palette.color(backgroundColor)
			owner?.backgroundColor = color
		}
	}

	/// Аналог tintColor из UIKit
	public var tintColor: Color = .generalBrand {
		didSet {
			owner?.tintColor = LightPalette().color(tintColor) //style.palette.color(tintColor)
		}
	}

	/// Радиус закругления
	public var cornerRadius: CGFloat = .zero {
		didSet {
//			let radius = style.radii.radius(cornerRadius, size: owner?.frame.size ?? .zero)
			owner?.layer.cornerRadius = cornerRadius
//			overlay.viewCornerRadiusDidChange()
		}
	}

	/// Толщина обводки
	public var borderWidth: CGFloat = 0 {
		didSet {
			owner?.layer.borderWidth = borderWidth
		}
	}

	/// Цвет обводки
	public var borderColor: Color? {
		didSet {
			guard let color = borderColor else {
				owner?.layer.borderColor = nil
				return
			}
			owner?.layer.borderColor = LightPalette().color(color).cgColor //style.palette.color(color).cgColor
		}
	}

	/// Обрезать ли все что выходит за пределы вью
	public var clipsToBounds: Bool = true {
		didSet {
			owner?.clipsToBounds = clipsToBounds
		}
	}

	/// Переводить ли автроресайзинг маски в констреинты
	public var useAutoresizingMask: Bool = false {
		didSet {
			owner?.translatesAutoresizingMaskIntoConstraints = useAutoresizingMask
		}
	}

	/// Прозрачность
	public var alpha: CGFloat = 1 {
		didSet {
			owner?.alpha = alpha
		}
	}

	/// Искажение вью
	public var transform: CGAffineTransform = .identity {
		didSet {
			owner?.transform = transform
		}
	}

	/// Обрабатывает ли получатель исключительно события касания.
	public var isExclusiveTouch: Bool = false {
		didSet {
			owner?.isExclusiveTouch = isExclusiveTouch
		}
	}

	/// Возможно ли взаимодействие с пользователем
	public var isUserInteractionEnabled: Bool = true {
		didSet {
			owner?.isUserInteractionEnabled = isUserInteractionEnabled
		}
	}

	/// Идентификатор вью при переходе
	public var transitionId: String?

	override func configureOwner() {
//		guard let owner = owner else { return }
		super.configureOwner()
	}

	/// Анимированное изменений лэйаута
	func animateLayoutChanges() {
		UIView.animate(withDuration: CATransaction.animationDuration(),
					   delay: .zero,
					   options: [.allowUserInteraction],
					   animations: {
			self.owner?.layoutIfNeeded()
		})
	}
}

