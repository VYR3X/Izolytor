//
//  ProductModelTableViewCell.swift
//  Izolyator
//
//  Created by Vladislav Zhokhov on 17.01.2021.
//  Copyright © 2021 Splash Fire. All rights reserved.
//

import UIKit

/// Делегат ячейки с каруселью продуктов
protocol ProductModelTableViewCellDelegate: AnyObject {
	func addTableViewCell()
}

/// Ячейка содержащая коллекшн вью c продуктами - '"Высоковольтными вводами"
final class ProductModelTableViewCell: UITableViewCell {

	weak var delegate: ProductModelTableViewCellDelegate?

	private let productTypeLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.sizeToFit()
		label.text = "Напряжение: 500 КВт"
		label.font = UIFont.boldSystemFont(ofSize: 15)
		label.textColor = .black
		label.backgroundColor = .clear
		label.numberOfLines = 1
		label.textAlignment = .left
		return label
	}()

	private lazy var productModelButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.backgroundColor = UIColor(red: 0, green: 0, blue: 0.078, alpha: 0.04)
		button.layer.cornerRadius = 20
		button.addTarget(self, action: #selector(openModelList(sender:)), for: .touchUpInside)
		return button
	}()

	private let productModelLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.sizeToFit()
		label.text = "Models"
		label.font = UIFont.boldSystemFont(ofSize: 10)
		label.textColor = .systemGray
		label.backgroundColor = .clear
		label.numberOfLines = 1
		label.textAlignment = .center
		return label
	}()

	private let modelInfoStaskView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.spacing = 25
		stackView.axis = .horizontal
		stackView.distribution = .fillEqually
		return stackView
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupConstraints()
	}

	required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	private func setupConstraints() {
//		productModelButton.addSubview(productModelLabel)
//		productModelLabel.pinToSuperView()
		modelInfoStaskView.addArrangedSubviews(productTypeLabel, productModelButton)
		contentView.addSubview(modelInfoStaskView)
//		contentView.addSubview(productModelButton)

		NSLayoutConstraint.activate([
			modelInfoStaskView.topAnchor.constraint(equalTo: contentView.topAnchor),
			modelInfoStaskView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			modelInfoStaskView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			modelInfoStaskView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
		])
	}

	@objc func openModelList(sender: UIButton) {
		delegate?.addTableViewCell()
	}
}
