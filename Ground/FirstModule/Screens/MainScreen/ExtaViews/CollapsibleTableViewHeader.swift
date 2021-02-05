//
//  CollapsibleTableViewHeader.swift
//  Izolyator
//
//  Created by Vladislav Zhokhov on 17.01.2021.
//  Copyright © 2021 Splash Fire. All rights reserved.
//

import UIKit

/// Протокол делегата для сворачивающейся секции
protocol CollapsibleTableViewHeaderDelegate {
	
	func toggleSection(_ header: CollapsibleTableViewHeader, section: Int)
}

/// Хедер вью для сворачивающейся секции
final class CollapsibleTableViewHeader: UITableViewHeaderFooterView {

	/// делегат секции
	var delegate: CollapsibleTableViewHeaderDelegate?
	/// номер свернутой секции
	var section: Int = 0

	/// Тип ВВ: например Трансформаторный тип ввода
	let typeLabel: UILabel = {
		let label = UILabel()
		label.sizeToFit()
		label.font = UIFont.boldSystemFont(ofSize: 20)
		label.translatesAutoresizingMaskIntoConstraints = false
		label.textColor = UIColor.black
		return label
	}()

	private lazy var arrowImageView: UIImageView = {
		let imageView = UIImageView(frame: .zero)
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.image = UIImage(named: "chevron_right")
		imageView.makeSquare(side: 18.0)
		return imageView
	}()

	private let horizontalStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.spacing = 12
		stackView.axis = .horizontal
		stackView.distribution = .fill
		return stackView
	}()

	required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	override init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
		contentView.backgroundColor = .white
		addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CollapsibleTableViewHeader.tapHeader(_:))))
		setupView()
	}

	private func setupView() {
//		addSubviews(typeLabel, arrowButton)
//		addSubview(typeLabel)
		horizontalStackView.addArrangedSubviews(typeLabel, arrowImageView)
		addSubview(horizontalStackView)
		horizontalStackView.pinToSuperView(insets: UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24))

//		NSLayoutConstraint.activate([
//			typeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
//			typeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
//		])
	}

	/// Обработчик нажатия на секцию
	@objc func tapHeader(_ gestureRecognizer: UITapGestureRecognizer) {
		guard let cell = gestureRecognizer.view as? CollapsibleTableViewHeader else { return }
//		delegate?.toggleSection(self, section: cell.section)
	}

	/// Обработчик нажатия на кнопку
	@objc func openModelList(sender: UIButton) {
		delegate?.toggleSection(self, section: section)
	}

	/// Анимируем поворот стрелки для сворачивания секции
	func setCollapsed(_ collapsed: Bool) {
//		arrowButton.arrowLabel.rotate(collapsed ? 0.0 : .pi / 2)
//		arrowLabel.rotate(collapsed ? 0.0 : .pi / 2)
	}
}

