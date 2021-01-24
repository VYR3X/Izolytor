//
//  MultipleView.swift
//  Izolyator
//
//  Created by Vladislav Zhokhov on 14.01.2021.
//  Copyright © 2021 Splash Fire. All rights reserved.
//

import UIKit

/// Протокол делегата для управления multiple view
protocol MultipleViewDelegate: NSObject {

	func didTapLeftButton()

	func openArScene()
}

/// Вью с двумя кнопками прикрепленное к таббару на главном экране выбора продукта
final class MultipleView: UIView {

	weak var delegate: MultipleViewDelegate?

	private lazy var productFullInfoButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
//		button.backgroundColor =
		button.layer.cornerRadius = 20
		button.addTarget(self, action: #selector(tapOnLeftButton(sender:)), for: .touchUpInside)
		return button
	}()

	/// Лейбл левой кнопки
	let productFullInfoLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.sizeToFit()
		label.text = "Full Info"
		label.font = UIFont.boldSystemFont(ofSize: 15)
		label.textColor = .blue //LightPalette().color(.darkBlue)
		label.backgroundColor = .clear
		label.numberOfLines = 1
		label.textAlignment = .center
		return label
	}()

	private lazy var productModelButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.backgroundColor = .blue //LightPalette().color(.darkBlue)
		button.layer.cornerRadius = 20
		button.addTarget(self, action: #selector(openArScene(sender:)), for: .touchUpInside)
		return button
	}()

	/// Лейбл правой кнопки
	let titleARLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.sizeToFit()
		label.text = "AR object"
		label.font = UIFont.boldSystemFont(ofSize: 15)
		label.textColor = .white//LightPalette().color(.lightBackground)
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

	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	override init(frame: CGRect) {
		super.init(frame: .zero)
		translatesAutoresizingMaskIntoConstraints = false
		self.backgroundColor = .white
		setupView()
	}

	private func setupView() {
		productFullInfoButton.addSubview(productFullInfoLabel)
		productFullInfoLabel.pinToSuperView()
		productModelButton.addSubview(titleARLabel)
		titleARLabel.pinToSuperView()

		modelInfoStaskView.addArrangedSubviews(productFullInfoButton, productModelButton)
		addSubview(modelInfoStaskView)

		NSLayoutConstraint.activate([
			modelInfoStaskView.topAnchor.constraint(equalTo: topAnchor),
			modelInfoStaskView.bottomAnchor.constraint(equalTo: bottomAnchor),
			modelInfoStaskView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
			modelInfoStaskView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
		])
	}

	@objc private func openArScene(sender: UIButton) {
		delegate?.openArScene()
	}

	@objc private func tapOnLeftButton(sender: UIButton) {
		delegate?.didTapLeftButton()
	}
}
