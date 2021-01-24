//
//  ManualHeaderView.swift
//  Izolyator
//
//  Created by Vladislav Zhokhov on 25.01.2021.
//  Copyright © 2021 Splash Fire. All rights reserved.
//

import UIKit

/// Протокол делегата для сворачивающейся секции
protocol ManualHeaderViewDelegate {
	/// свернуть секцию
	func collapseSection(_ header: ManualHeaderView, section: Int)
}

/// Хедер вью для сворачивающейся секции
final class ManualHeaderView: UITableViewHeaderFooterView {

	/// делегат секции
	var delegate: ManualHeaderViewDelegate?

	/// номер свернутой секции
	var section: Int = 0

	/// Название секции
	let secionName: UILabel = {
		let label = UILabel()
		label.sizeToFit()
		label.font = UIFont.boldSystemFont(ofSize: 20)
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = UIColor.black
		return label
	}()

	let arrowLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.sizeToFit()
//		label.font = UIFont.boldSystemFont(ofSize: 30)
		label.makeSquare(side: 20)
		label.textColor = .black
		label.backgroundColor = .clear
		label.numberOfLines = 1
		label.textAlignment = .center
		return label
	}()

	required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	override init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
		contentView.backgroundColor = .white
		addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CollapsibleTableViewHeader.tapHeader(_:))))
		setupView()
	}

	private func setupView() {
		addSubviews(secionName, arrowLabel)
		NSLayoutConstraint.activate([
			secionName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
			secionName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

			arrowLabel.leadingAnchor.constraint(equalTo: secionName.trailingAnchor, constant: 15),
			arrowLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
		])
	}

	/// Обработчик нажатия на секцию
	@objc func tapHeader(_ gestureRecognizer: UITapGestureRecognizer) {
		guard let cell = gestureRecognizer.view as? ManualHeaderView else { return }
		delegate?.collapseSection(self, section: cell.section)
	}

	func setCollapsed(_ collapsed: Bool) {
		arrowLabel.rotate(collapsed ? 0.0 : .pi / 2)
	}
}


