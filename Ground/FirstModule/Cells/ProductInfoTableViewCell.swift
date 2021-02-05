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

	private let titleLabel: UILabel = {
		let label = UILabel()
		label.sizeToFit()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.boldSystemFont(ofSize: 20)
		label.textColor = .black
		label.textAlignment = .left
		label.numberOfLines = 1
		return label
	}()

	private let backgroundRoundView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .white
		view.layer.cornerRadius = 15
		view.layer.shadowColor = UIColor.black.cgColor
		view.layer.shadowOpacity = 0.5
		view.layer.shadowOffset = .zero
		view.layer.shadowRadius = 5
		return view
	}()

	/// Краткое описание типа ввода
	private let descriptionTextView: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = LightPalette().color(.lentaSecondaryDark)
		label.font = UIFont.boldSystemFont(ofSize: 17)
		label.backgroundColor = .white
		label.numberOfLines = 0
		label.textAlignment = .left
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
		contentView.addSubviews(titleLabel, backgroundRoundView)
		descriptionStackView.addArrangedSubviews(descriptionSecondLabel, descriptionTextView)
		/// Опциональный лейбл если возникнет ошибка то можем вывести как предупреждение
		descriptionSecondLabel.isHidden = !modelsIsHidden

//		contentView.addSubview(descriptionStackView)
		backgroundRoundView.addSubview(descriptionStackView)

		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
			titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),

			backgroundRoundView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
			backgroundRoundView.bottomAnchor.constraint(equalTo: descriptionStackView.bottomAnchor, constant: 10),
			backgroundRoundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
			backgroundRoundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

			descriptionStackView.topAnchor.constraint(equalTo: backgroundRoundView.topAnchor, constant: 10),
			descriptionStackView.leadingAnchor.constraint(equalTo: backgroundRoundView.leadingAnchor, constant: 10),
			descriptionStackView.trailingAnchor.constraint(equalTo: backgroundRoundView.trailingAnchor, constant: -10)
		])
	}

	/// устанавливаем значения в тайтл
	func bind(title: String, text: String) {
		titleLabel.text = title
		descriptionTextView.text = text
	}

	@objc private func openModelList(sender: UIButton) {
		print("нажата кнопка выбора")
	}
}
