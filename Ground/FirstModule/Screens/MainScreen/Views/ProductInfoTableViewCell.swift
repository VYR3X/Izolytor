//
//  ProductInfoTableViewCell.swift
//  Izolyator
//
//  Created by Vladislav Zhokhov on 12.01.2021.
//  Copyright © 2021 Splash Fire. All rights reserved.
//
import UIKit

/// Делегат ячейки с информацией о выбранном продукте
protocol ProductInfoTableViewCellDelegate {
	func didSelect(position: Int)
}

/// Ячейка содержащая краткую информацию о продукте представленном в коллекшн вью
final class ProductInfoTableViewCell: UITableViewCell {

	/// Делегат для ячейки с информацией
	var delegate: ProductInfoTableViewCellDelegate?

	/// при нажатии на кнопку попробую вывести  список моделей в стек вью
	var modelsIsHidden: Bool = false

	private let descriptionLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.sizeToFit()
		label.text = "Описание ввода \nбла бла бла бла бла бла бла \nбла бла бла бла бла бла \nбла бла бла бал "
		label.font = UIFont.boldSystemFont(ofSize: 20)
		label.textColor = LightPalette().color(.onSurfacePrimary)
//		label.backgroundColor = .orange
		label.numberOfLines = 0
		label.textAlignment = .justified
		return label
	}()

	private let descriptionSecondLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.sizeToFit()
		label.text = "Лейб с ошибкой"
		label.font = UIFont.boldSystemFont(ofSize: 20)
		label.textColor = LightPalette().color(.onSurfacePrimary)
		label.backgroundColor = .blue
		label.numberOfLines = 0
		label.textAlignment = .justified
		return label
	}()

	private let descriptionStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.sizeToFit()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.spacing = 16
		stackView.distribution = .fill
		stackView.axis = .vertical
		return stackView
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupView()
	}

	required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	private func setupView() {
		descriptionStackView.addArrangedSubviews(descriptionSecondLabel, descriptionLabel)
		/// Опциональный лейбл если возникнет ошибка то можем вывести как предупреждение
		descriptionSecondLabel.isHidden = !modelsIsHidden

		contentView.addSubview(descriptionStackView)

		NSLayoutConstraint.activate([
			descriptionStackView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
			descriptionStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
			descriptionStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25)
		])
	}

	@objc private func openModelList(sender: UIButton) {
		print("нажата кнопка выбора")
	}
}
