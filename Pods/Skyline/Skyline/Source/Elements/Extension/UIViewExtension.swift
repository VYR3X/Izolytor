//
//  UIViewExtension.swift
//  Skyline
//
//  Created by 17790204 on 09.05.2021.
//

import UIKit

public extension UIView {

	///  Прицепить вью констрейнтами к супервью с одинаковым отступом от всех сторон
	///
	/// - Parameters:
	///   - inset:  отступ
	func pinToSuperView(inset: CGFloat = 0.0) {
		pinToView(insets: UIEdgeInsets(top: inset,
									   left: inset,
									   bottom: inset,
									   right: inset))
	}

	///  Прицепить вью констрейнтами к супервью с разным отступом от всех сторон
	///
	/// - Parameters:
	///   - insets:  отступы
	func pinToView(insets: UIEdgeInsets) {

		guard let superview = superview else { return }

		let top = superview.topAnchor
		let leading = superview.leadingAnchor
		let trailing = superview.trailingAnchor
		let bottom = superview.bottomAnchor

		translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			topAnchor.constraint(equalTo: top, constant: insets.top),
			leadingAnchor.constraint(equalTo: leading, constant: insets.left),
			trailingAnchor.constraint(equalTo: trailing, constant: -insets.right),
			bottomAnchor.constraint(equalTo: bottom, constant: -insets.bottom)
		])
	}

	/// Сделать вьюху квадратной
	/// - Parameter side: Длина стороны, если нужно
	func makeSquare(side: CGFloat? = nil) {
		heightAnchor.constraint(equalTo: widthAnchor).isActive = true
		if let side = side {
			heightAnchor.constraint(equalToConstant: side).isActive = true
		}
	}
}

