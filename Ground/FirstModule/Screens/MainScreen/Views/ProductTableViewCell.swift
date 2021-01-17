//
//  ProductTableViewCell.swift
//  Izolyator
//
//  Created by Vladislav Zhokhov on 12.01.2021.
//  Copyright © 2021 Splash Fire. All rights reserved.
//

import UIKit

/// Делегат ячейки с каруселью продуктов
protocol ProductTableViewCellDelegate {
	func didSelectAlbum(position: Int)
}

/// Ячейка содержащая коллекшн вью c продуктами - '"Высоковольтными вводами"
final class ProductTableViewCell: UITableViewCell {

	/// Делегат ячейки продуктов
	var delegate: ProductTableViewCellDelegate?

	private let headerLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.sizeToFit()
		label.text = "Изолятор"
		label.font = UIFont.boldSystemFont(ofSize: 25)
		label.textColor = .black
		label.backgroundColor = .clear
		label.numberOfLines = 0
		label.textAlignment = .center
		return label
	}()

	private let paginationCollectionView = PaginationCollectionView()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		paginationCollectionView.delegate = delegate
		setupConstraints()
	}

	required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	private func setupConstraints() {
		contentView.addSubviews(headerLabel, paginationCollectionView)

		NSLayoutConstraint.activate([
			headerLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
			headerLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

			paginationCollectionView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 15),
			paginationCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
			paginationCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			paginationCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
		])
	}
}
