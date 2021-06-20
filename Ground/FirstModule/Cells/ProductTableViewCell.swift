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
	/// Определить текущий индекс ячейки в карусели продкутов на главном экране
	func detectCurrentCellIndex(_ index: Int)
}

/// Ячейка содержащая коллекшн вью c продуктами - '"Высоковольтными вводами"
final class ProductTableViewCell: UITableViewCell {

	/// продукты для отображения в карусели
//	var dataSource: [ProductServiceModel.MainScreenProductType] = []

	/// Делегат ячейки продуктов
	var delegate: ProductTableViewCellDelegate?

	private let headerLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.sizeToFit()
		label.text = "Изолятор"
		label.font = UIFont.boldSystemFont(ofSize: 30)
		label.textColor = UIColor.Pallete.darkBlue
		label.backgroundColor = .clear
		label.numberOfLines = 0
		label.textAlignment = .center
		return label
	}()

	private let paginationCollectionView = PaginationCollectionView()

	required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupConstraints()
	}

	func updateCollectionViewWith(source: [ProductServiceModel.MainScreenProductModel], delegate: ProductTableViewCellDelegate) {
		paginationCollectionView.delegate = delegate
		paginationCollectionView.updateCollectionView(source: source)
	}

	private func setupConstraints() {
		contentView.addSubviews(paginationCollectionView)

		NSLayoutConstraint.activate([
			paginationCollectionView.topAnchor.constraint(equalTo: topAnchor),
			paginationCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
			paginationCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			paginationCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
		])
	}
}
