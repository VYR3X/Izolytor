//
//  CollapsibleTableViewHeader.swift
//  Izolyator
//
//  Created by Vladislav Zhokhov on 17.01.2021.
//  Copyright © 2021 Splash Fire. All rights reserved.
//

import UIKit

/// Протокол делегата для сворачивающейся секции
protocol CollapsibleTableViewHeaderDelegate {
	func toggleSection(_ header: CollapsibleTableViewHeader, section: Int)

//	func buttonCollapsedCell()
}

/// Хедер вью для сворачивающейся секции
class CollapsibleTableViewHeader: UITableViewHeaderFooterView {

	/// делегат секции
	var delegate: CollapsibleTableViewHeaderDelegate?
	/// номер свернутой секции
	var section: Int = 0

	/// Тип ВВ: например Трансформаторный тип ввода
	let typeLabel: UILabel = {
		let label = UILabel()
		label.sizeToFit()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = UIColor.white
		return label
	}()

	lazy var button: ButtonWithArrow = {
		let button = ButtonWithArrow()
		button.delegate = delegate
		button.section = section
		return button
	}()

//	let arrowLabel: UILabel = {
//		let label = UILabel()
//		label.translatesAutoresizingMaskIntoConstraints = false
//		label.textColor = UIColor.white
//		return label
//	}()

	required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	override init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
		contentView.backgroundColor = UIColor(hex: 0x2E3944)

		addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CollapsibleTableViewHeader.tapHeader(_:))))
		setupView()
	}

	private func setupView() {
		button.widthAnchor.constraint(equalToConstant: 150).isActive = true
		addSubviews(typeLabel, button)

		NSLayoutConstraint.activate([
			typeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
			typeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
			button.topAnchor.constraint(equalTo: topAnchor, constant: 10)
		])
	}

	/// Обработчик нажатия на секцию
	@objc func tapHeader(_ gestureRecognizer: UITapGestureRecognizer) {
		guard let cell = gestureRecognizer.view as? CollapsibleTableViewHeader else { return }
		delegate?.toggleSection(self, section: cell.section)
	}

	/// Обработчик нажатия на кнопку
	@objc func openModelList(sender: UIButton) {
		delegate?.toggleSection(self, section: section)
	}

	/// Анимируем поворот стрелки для сворачивания секции
	func setCollapsed(_ collapsed: Bool) {
		button.arrowLabel.rotate(collapsed ? 0.0 : .pi / 2)
//		arrowLabel.rotate(collapsed ? 0.0 : .pi / 2)
	}
}

