//
//  ProductListTableViewCell.swift
//  Izolyator
//
//  Created by 17790204 on 28.01.2021.
//  Copyright © 2021 Splash Fire. All rights reserved.
//

import UIKit

/// Ячейка с информацией о вводе на экране поиска
class ProductListTableViewCell: UITableViewCell {

	/// а это пока тайтл заголовка ячейки
	let typeLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = 0
		label.font = UIFont.systemFont(ofSize: 16)
		label.textColor = .black
		return label
	}()

	/// и подзаголовок
	let detailLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = 0
		label.font = UIFont.systemFont(ofSize: 12)
		label.textColor = UIColor.lightGray
		label.lineBreakMode = .byTruncatingTail // если текст не влезает то "abcd..."
		return label
	}()

	required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	// MARK: Initalizers
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupView()
	}

	private func setupView() {
		let marginGuide = contentView.layoutMarginsGuide
		contentView.addSubviews(typeLabel, detailLabel)

		NSLayoutConstraint.activate([
			typeLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor),
			typeLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor),
			typeLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor),

			detailLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor),
			detailLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor),
			detailLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor),
			detailLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 5),
		])
	}
}
