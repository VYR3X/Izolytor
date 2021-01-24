//
//  ManualTableViewCell.swift
//  Izolyator
//
//  Created by Vladislav Zhokhov on 23.01.2021.
//  Copyright © 2021 Splash Fire. All rights reserved.
//

import UIKit

/// Делегат ячейки с каруселью продуктов
protocol ManualTableViewCellDelegate {
	func didSelectCell(position: Int)
}

/// Ячейка для перехода на руководство по эксплуатации 
final class ManualTableViewCell: UITableViewCell {

	/// Делегат ячейки продуктов
	var delegate: ManualTableViewCellDelegate?

	private let titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.sizeToFit()
		label.text = "Руководство по эксплуатации"
//		label.font = UIFont.boldSystemFont(ofSize: 20)
		label.textColor = .white
		label.backgroundColor = .clear
		label.numberOfLines = 1
		label.textAlignment = .left
		return label
	}()

	private let arrowLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.sizeToFit()
		label.text = ">"
//		label.font = UIFont.boldSystemFont(ofSize: 30)
		label.makeSquare(side: 20)
		label.textColor = .white
		label.backgroundColor = .clear
		label.numberOfLines = 1
		label.textAlignment = .center
		return label
	}()

	required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		contentView.backgroundColor = UIColor(hex: 0x2E3944)
		setupConstraints()
	}

	private func setupConstraints() {
		contentView.addSubviews(titleLabel, arrowLabel)

		NSLayoutConstraint.activate([
			titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
			titleLabel.trailingAnchor.constraint(equalTo: arrowLabel.leadingAnchor, constant: -20),
			titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
			arrowLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
			arrowLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
		])
	}
}

