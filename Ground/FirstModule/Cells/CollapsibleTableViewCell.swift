//
//  CollapsibleTableViewCell.swift
//  Izolyator
//
//  Created by Vladislav Zhokhov on 17.01.2021.
//  Copyright © 2021 Splash Fire. All rights reserved.
//

import UIKit

/// Ячейка вложенная в разворацивающиюся ячейку
class CollapsibleTableViewCell: UITableViewCell {

	/// Иконка для ячейки
	private lazy var iconView: UIImageView = {
		let imageView = UIImageView(frame: .zero)
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.makeSquare(side: 40.0)
		return imageView
	}()

	/// а это пока тайтл заголовка ячейки
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = 0
		label.textColor = .black // /* On Background / Primary */
		label.font = UIFont.systemFont(ofSize: 16)
		return label
	}()

	/// и подзаголовок 
	private let subtitleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = 0
		label.font = UIFont.systemFont(ofSize: 14)
		label.textColor = UIColor.lightGray // /* On Background / Secondary */
		label.lineBreakMode = .byTruncatingTail // если текст не влезает то "abcd..."
		return label
	}()

	private let verticalStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.spacing = 4
		stackView.axis = .vertical
		stackView.distribution = .fill
		return stackView
	}()

	private let horizontalStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.spacing = 12
		stackView.axis = .horizontal
		stackView.distribution = .fill
		return stackView
	}()

	// MARK: Initalizers
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupView()
		contentView.backgroundColor = .white
	}

	required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	private func setupView() {
		verticalStackView.addArrangedSubviews(titleLabel, subtitleLabel)
		horizontalStackView.addArrangedSubviews(iconView, verticalStackView)
		contentView.addSubviews(horizontalStackView)
		horizontalStackView.pinToSuperView(insets: UIEdgeInsets(top: 12, left: 24, bottom: 12, right: 24))
	}

	/// Устанавливаем значения в ячейку
	func bind(title: String, subTitle: String, iconName: String) {
		titleLabel.text = title
		subtitleLabel.text = subTitle
		iconView.image = UIImage(named: iconName)
	}
}
