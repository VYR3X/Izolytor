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

}

/// Хедер вью для сворачивающейся секции
final class CollapsibleTableViewHeader: UITableViewHeaderFooterView {

	/// делегат секции
	var delegate: CollapsibleTableViewHeaderDelegate?
	/// номер свернутой секции
	var section: Int = 0

	/// Тип ВВ: например Трансформаторный тип ввода
	let typeLabel: UILabel = {
		let label = UILabel()
		label.sizeToFit()
		label.font = UIFont.boldSystemFont(ofSize: 16)
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = UIColor.black
		return label
	}()

	private lazy var arrowButton: ButtonWithArrow = {
		let button = ButtonWithArrow()
		button.delegate = delegate
		button.section = section
		return button
	}()

	required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	override init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
		contentView.backgroundColor = .white
		addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CollapsibleTableViewHeader.tapHeader(_:))))
		setupView()
	}

	private func setupView() {
		addSubviews(typeLabel, arrowButton)

		NSLayoutConstraint.activate([
			typeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
			typeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			typeLabel.trailingAnchor.constraint(equalTo: arrowButton.leadingAnchor, constant: -10),

			arrowButton.heightAnchor.constraint(equalToConstant: 30),
			arrowButton.centerYAnchor.constraint(equalTo: centerYAnchor),
			arrowButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
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
		arrowButton.arrowLabel.rotate(collapsed ? 0.0 : .pi / 2)
//		arrowLabel.rotate(collapsed ? 0.0 : .pi / 2)
	}
}

