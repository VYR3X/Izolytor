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
class CollapsibleTableViewHeader: UITableViewHeaderFooterView {

	/// делегат секции
	var delegate: CollapsibleTableViewHeaderDelegate?
	/// номер свернутой секции
	var section: Int = 0


	let titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = UIColor.white
		return label
	}()

	let arrowLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = UIColor.white
		return label
	}()

	required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	override init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
		contentView.backgroundColor = UIColor(hex: 0x2E3944)

		addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CollapsibleTableViewHeader.tapHeader(_:))))
		setupView()
	}

	private func setupView() {
		let marginGuide = contentView.layoutMarginsGuide
		contentView.addSubviews(titleLabel, arrowLabel)

		NSLayoutConstraint.activate([
			arrowLabel.widthAnchor.constraint(equalToConstant: 12),
			arrowLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor),
			arrowLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor),
			arrowLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor),

			titleLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor),
			titleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor),
			titleLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor),
			titleLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor)
		])
	}

	/// Обработчик нажатия на секцию
	@objc func tapHeader(_ gestureRecognizer: UITapGestureRecognizer) {
		guard let cell = gestureRecognizer.view as? CollapsibleTableViewHeader else { return }
		delegate?.toggleSection(self, section: cell.section)
	}

	/// Анимируем поворот стрелки для сворачивания секции
	func setCollapsed(_ collapsed: Bool) {
		arrowLabel.rotate(collapsed ? 0.0 : .pi / 2)
	}

}

