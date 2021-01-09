//
//  UIView+extensions.swift
//  Izolyator
//
//  Created by 17790204 on 03.01.2021.
//  Copyright © 2021 Splash Fire. All rights reserved.
//

import UIKit

// MARK: - UIView метод, который делает ее квадратной
public extension UIView {

	/// Сделать вьюху квадратной
	/// - Parameter side: Длина стороны, если нужно
	func makeSquare(side: CGFloat? = nil) {
		heightAnchor.constraint(equalTo: widthAnchor).isActive = true
		if let side = side {
			heightAnchor.constraint(equalToConstant: side).isActive = true
		}
	}
}

// MARK: - UIView метод, для добавления нескольких вью сразу
public extension UIView {

	/// Добавить несколько сабвью
	///
	/// - Parameter views:  несколько вью
	func addSubviews(_ views: UIView...) {
		addSubviews(views)
	}

	/// Добавить массив сабвью
	///
	/// - Parameter views:  массив вью
	func addSubviews(_ views: [UIView]) {
		for view in views {
			addSubview(view)
		}
	}
}

// MARK: - UIStackView метод, для добавления нескольких вью сразу
public extension UIStackView {

	/// Добавить несколько сабвью
	///
	/// - Parameter views: несколько вью
	func addArrangedSubviews(_ views: UIView...) {
		addArrangedSubviews(views)
	}

	/// Добавить массив сабвью
	///
	/// - Parameter views: массив вью
	func addArrangedSubviews(_ views: [UIView]) {
		views.forEach { addArrangedSubview($0) }
	}
}

// MARK: - UIView метод, для прикреплеления вью констрейнтами к супервью
public extension UIView {

	///  Прицепить вью констрейнтами к супервью с одинаковым отступом от всех сторон
	///
	/// - Parameters:
	///   - inset:  отступ
	func pinToSuperView(inset: CGFloat = 0.0) {
		pinToSuperView(insets: UIEdgeInsets(top: inset,
									   left: inset,
									   bottom: inset,
									   right: inset))
	}

	///  Прицепить вью констрейнтами к супервью с разным отступом от всех сторон
	///
	/// - Parameters:
	///   - insets:  отступы
	func pinToSuperView(insets: UIEdgeInsets) {

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

	/// Создание вьюхи для помещения в UIStackView, будет занимать все пустое пространство и сжиматься при его заполнении в первую очередь
	static func makeFlexibleSpaceView(_ axis: NSLayoutConstraint.Axis) -> UIView {
		let flexibleSpaceView = UIView()
		flexibleSpaceView.backgroundColor = .clear
		flexibleSpaceView.translatesAutoresizingMaskIntoConstraints = false
		flexibleSpaceView.setContentHuggingPriority(.required, for: axis)
		flexibleSpaceView.setContentCompressionResistancePriority(.defaultLow, for: axis)
		return flexibleSpaceView
	}
}

//
//init(items: [UIView]) {
//	super.init(frame: .zero)
//	setupView(with: items)
//}
//
///// Установка иерархии вьюх
/////
///// - Parameters:
/////   -  items: Вьюхи для отображения слева
//private func setupView(with items: [UIView]) {
//	let flexibleSpaceView = UIView.makeFlexibleSpaceView(.horizontal)
//	let stackView = UIStackView(arrangedSubviews: items + [flexibleSpaceView, continueButton])
//	stackView.spacing = Constants.itemSpacing
//	stackView.axis = .horizontal
//	stackView.translatesAutoresizingMaskIntoConstraints = false
//	addSubview(stackView)
//	stackView.pinToSuperView(insets: GInsets(horizontal: Constants.leftRightOffset))
//	heightAnchor.constraint(equalToConstant: Constants.viewHeight).isActive = true
//}

