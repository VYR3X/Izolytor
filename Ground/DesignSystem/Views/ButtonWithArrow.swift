//
//  ButtonWithArrow.swift
//  Izolyator
//
//  Created by Vladislav Zhokhov on 21.01.2021.
//  Copyright © 2021 Splash Fire. All rights reserved.
//

import UIKit


final class ButtonWithArrow: UIView {

	var collapsed: Bool = true

	var delegate: CollapsibleTableViewHeaderDelegate?

	var section: Int = 0

	/// Картинка стрелки разворота секций
	let arrowLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.makeSquare(side: 20) // высота картинки влияет на -> высоту стек вью -> высоту кнопки
		label.text = ">"
		label.textAlignment = .center
		label.textColor = UIColor.blue
		return label
	}()

	private lazy var productModelButton: UIButton = {
		let button = UIButton()
		button.translatesAutoresizingMaskIntoConstraints = false
		button.backgroundColor = UIColor(red: 0, green: 0, blue: 0.078, alpha: 0.04)
		button.layer.cornerRadius = 10
		button.backgroundColor = .white
//		button.addTarget(self, action: #selector(openModelList(sender:)), for: .touchUpInside)
		button.widthAnchor.constraint(equalToConstant: 150).isActive = true
		return button
	}()

	private let productModelLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.sizeToFit()
		label.text = "Models"
		label.font = UIFont.boldSystemFont(ofSize: 17)
		label.textColor = .systemGray
		label.backgroundColor = .clear
		label.numberOfLines = 1
		label.textAlignment = .center
		return label
	}()

	private let buttonContentStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.spacing = 10
		stackView.axis = .horizontal
		stackView.distribution = .fill
		return stackView
	}()

	override init(frame: CGRect) {
		super.init(frame: .zero)
		self.translatesAutoresizingMaskIntoConstraints = false
		setupView()
	}

	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	private func setupView() {
		buttonContentStackView.addArrangedSubviews(productModelLabel, arrowLabel)
		productModelButton.addSubview(buttonContentStackView)
		buttonContentStackView.pinToSuperView(insets: UIEdgeInsets(top: 2, left: 10, bottom: 2, right: 10))
		self.addSubview(productModelButton)
	}
}