//
//  SplashViewController.swift
//  Izolyator
//
//  Created by 17790204 on 03.01.2021.
//  Copyright © 2021 Splash Fire. All rights reserved.
//

import UIKit

final class SplashViewController: UIViewController {

	static let logoImageBig: UIImage = UIImage(named: "splash-logo-big")!
	var logoIsHidden: Bool = false
	var textImage: UIImage?

	// MARK: - Properties

	lazy var logoImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.backgroundColor = .gray
		imageView.makeSquare(side: 50)
		return imageView
	}()

	lazy var textLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.backgroundColor = .green
		label.text = "Изолятор"
		return label
	}()

	// MARK: - Life cycle

	override func viewDidLoad() {
		super.viewDidLoad()

//		textImageView.image = textImage
		logoImageView.isHidden = logoIsHidden
		setupConstraints()
	}

	private func setupConstraints() {
		view.addSubviews(logoImageView, textLabel)
		NSLayoutConstraint.activate([
			logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

			textLabel.heightAnchor.constraint(equalToConstant: 20),
			textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, padding: .edge).reverse,
			textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, padding: .edge),
			textLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
		])
	}
}
